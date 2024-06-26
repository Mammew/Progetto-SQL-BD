set search_path to 'UniGeSocialSport_p';
-------------------------------------------------------------------

--2. Vista
/*Vista Programma che per ogni impianto e mese riassume tornei e eventi che si svolgono in tale impianto, 
evidenziando in particolare per ogni categoria il numero di tornei, il numero di eventi, 
il numero di partecipanti coinvolti e di quanti diversi corsi di studio, 
la durata totale (in termini di minuti) di utilizzo e la percentuale di utilizzo rispetto alla disponibilita 
complessiva (minuti totali nel mese in cui l impianto utilizzabile) */


/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della vista senza rimuovere la specifica nel commento precedente */ 

CREATE VIEW Programma(Impianto, Mese,Numero_Torneo, Numero_Eventi, Categoria, Numero_Giocatori, 
					  Numero_corso_di_studi, Minuti_Tot, Percentuale_utilizzo)AS
	Select Impianto, 
			EXTRACT(MONTH FROM Evento.data) Mese,
			count(distinct NomeT) Num_Tornei,
			count(distinct Evento.ID) Num_Eventi, nomeC, 
			count(distinct Punti_Segnati.Username) Num_Giocatori, 
			count (distinct corso_di_studi) Num_corso_di_studi, 
			sum(durata) Minuti_Tot, 
			(sum(durata)/18000*100) Percentuale_utilizzo
	From Torneo
		join Evento on torneo=NomeT 
		join Categoria on Categoria = Categoria.ID
		join Punti_Segnati on Punti_Segnati.Evento_ID = Evento.ID
		--join Iscrive on Evento.ID = Iscrive.ID
		join Utente on Punti_Segnati.Username = Utente.Username
		--join Candidatura on candidatura.Username = Utente.Username
	--Where Iscrive.stato = 'confermato'
	Group by (Impianto, Mese, nomeC, durata);

--Select * from Programma;

/*************************************************************************************************************************************************************************/ 
--3. Interrogazioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 3a: Determinare gli utenti che si sono candidati come giocatori e non sono mai stati accettati e quelli che sono stati accettati tutte le volte che si sono candidati */
/*************************************************************************************************************************************************************************/ 
-- La query è stata interpretata come candidatura alle Squadre in quanto se un Utente viene accettato allora seguirà la sua candidatura
-- ad una squadra. Tale Squadra sarà creata nella quale vi saranno, naturlamente, tutti gli Utenti confermati per l'Evento
Select * 
from(
		Select Username User
		from Utente natural join Candidatura
		where stato = 'accettato'
		EXCEPT
		Select Username User
		from Utente natural join Candidatura
		where stato = 'rifiutato'
	)
	UNION
	(
		Select u1.Username User
		from Utente u1 natural join Candidatura c1 join Iscrive i1 on i1.Username = u1.Username
		where c1.stato = 'rifiutato' OR i1.stato = 'rifiutato'
		EXCEPT
		Select u2.Username User
		from Utente u2 natural join Candidatura c2 join Iscrive i2 on i2.Username = u2.Username
		where c2.stato = 'accettato' OR i2.stato = 'accettato'
	);
/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 

/*************************************************************************************************************************************************************************/ 
/* 3b: determinare gli utenti che hanno partecipato ad almeno un evento di ogni categoria */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 
--join Iscrive on Iscrive.Username = Utente.Username
-- è superflua perche se ha preso parte all'evento allora è stato messo in una Squadra.

Select Username
from (Select distinct Utente.Username, Categoria
		from Utente --natural join Iscrive
	  		join Candidatura on Candidatura.Username = Utente.Username
	  		join Squadra on Candidatura.Squadra = Squadra.ID
	  		join Partecipa p on p.Squadra_ID = Squadra.ID
	  		join Evento on p.Evento_ID = Evento.ID
		where  Candidatura.stato = 'accettato' AND Evento.data <= current_date)
group by Username
HAVING count (distinct Categoria) = (Select count (*) from Categoria);

/*Union
Select Username
from (Select distinct Utente.Username, Categoria
		from Utente natural join Candidatura join Partecipa on Candidatura.Squadra = Squadra_ID
	  		 join Evento on Evento_ID = Evento.ID
		where Candidatura.stato = 'confermato' AND Evento.data <= current_date)
group by Username
HAVING count (distinct Categoria) = (Select count (*) from Categoria)*/

/*************************************************************************************************************************************************************************/ 
/* 3c: determinare per ogni categoria il corso di laurea più attivo in tale categoria, 
cioè quello i cui studenti hanno partecipato al maggior numero di eventi (singoli o all'interno di tornei) di tale categoria */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 

Select distinct nomeC, corso_di_studi, count(Username)
From Categoria join Liv_utente on Categoria.ID = Liv_utente.ID natural join Utente
Group by nomeC, corso_di_studi
Having count(Username) >= ALL (Select count(Username)
						 	From Categoria join Liv_utente on Categoria.ID = Liv_utente.ID natural join Utente
							Group by nomeC, corso_di_studi);



/*************************************************************************************************************************************************************************/ 
--4. Funzioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 4a: funzione che effettua la conferma di un giocatore quale componente di una squadra, realizzando gli opportuni controlli */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della funzione senza rimuovere la specifica nel commento precedente */ 
Create FUNCTION is_part_of_team(Person varchar)
RETURNS boolean
AS $$
BEGIN
	IF Person IN ( Select distinct Username
					from Candidatura
					where stato = 'accettato')
	THEN
		return true;
	ELSE
		return false;
	END IF;
END $$
LANGUAGE plpgsql;

/*************************************************************************************************************************************************************************/ 
/* 4b1: funzione che dato un giocatore ne calcoli il livello */

/*
calcolo la media delle valutazioni la peso in centesimi e ottengo il mio livello
se ho perso l'ultima partita al mio livello in centesimo sottagraggo 3
se ho il flag affidabile a false la mia valutazione sarà inferiore di 5*/

------------------------------------------------------------------------------
-- Funzione che trova la squadra vincente dell'ultimo evento a cui l'utente ha partecipato

CREATE OR REPLACE FUNCTION CalcolaEsitoUltimoEvento(Persona varchar)
RETURNS TABLE(
    Squadra_Vincente_ID DECIMAL(5,0),
    Punti_Vincente DECIMAL(3,0)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        vincente.Squadra_ID AS Squadra_Vincente_ID,
        vincente.punti_segnati AS Punti_Vincente
    FROM
        (SELECT p.Squadra_ID, p.punti_segnati
         FROM Partecipa p
         	JOIN Evento e ON p.Evento_ID = e.ID
		 	JOIN Candidatura ca ON ca.Username = Persona
		 	JOIN Categoria c ON c.ID = e.Categoria
         WHERE e.data = (SELECT MAX(e2.data) FROM Evento e2)
		 	AND ca.stato = 'accettato'
		 ORDER BY
		 	CASE
        		WHEN c.nomeC = 'minigolf' THEN p.punti_segnati 
        		ELSE NULL 
    		END ASC,
    		CASE
        		WHEN c.nomeC <> 'minigolf' THEN p.punti_segnati 
        		ELSE NULL 
    		END DESC
		  LIMIT 1 ) as vincente;
END;
$$ 
LANGUAGE plpgsql;

-------------------------------------------------------------------------
CREATE FUNCTION user_category_level(Pers varchar, Cat decimal)
RETURNS DECIMAL
AS $$
Declare
	num_valutaz decimal;
	sum_valutaz decimal;
	affidabile boolean;
	vincente boolean;
	team decimal;
BEGIN
	--check se l'utente non è affidabile
	Select Utente.affidabile into affidabile
	From Utente
	Where Username = Pers;
		 
	--check se l'utente ha perso l'utima partita
	Select Squadra_Vincente_ID into team
	From CalcolaEsitoUltimoEvento(Pers);
	
	IF Pers IN (Select Username
				From Candidatura
				Where Squadra = team AND stato = 'accettato')
	THEN
		vincente = true;
	ELSE
		vincente = false;
	END IF;
	
	Select count(*) into num_valutaz
	from Prestazione join Evento on Evento_ID = ID
	Where Valutato = Pers AND Categoria =  Cat;
	
	Select sum(valutazione) into sum_valutaz
	From Prestazione join Evento on Evento_ID = ID
	Where Valutato = Pers AND Categoria = Cat;
	
	IF num_valutaz = 0 THEN
		RETURN 60;
	ELSE
		IF affidabile = false AND vincente = false THEN
			RETURN ((sum_valutaz / num_valutaz) * 10) - 5 - 3;
		ELSIF affidabile = false AND vincente = true THEN
			RETURN ((sum_valutaz / num_valutaz) * 10) - 5;
		ELSIF affidabile = true AND vincente = false THEN
			RETURN ((sum_valutaz / num_valutaz) * 10) - 3;
		ELSE
			RETURN (sum_valutaz / num_valutaz) * 10;
		END IF;
	END IF;
END $$
LANGUAGE plpgsql;

--Select* From user_category_level('user456',1);
------------------------------------------------------------------------------

CREATE FUNCTION find_last_match(Pers varchar, Cat decimal)
RETURNS DECIMAL
AS $$
DECLARE
	last_event decimal;
BEGIN
	Select Evento.ID INTO last_event
	From Utente join 
END $$;
LANGUAGE plpgsql;

-----------------------------------------------------------------------------

/* 4b2: funzione corrispondente alla seguente query parametrica: data una categoria e un corso di studi,
determinare la frazione di partecipanti a 
eventi di quella categoria di genere femminile sul totale dei partecipanti provenienti da quel corso di studi */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della funzione lasciando la specifica nel commento precedente corrispondente alla funzione realizzata tra le due alternative proposte per b., a seconda che il livello del giocatore sia memorizzato o meno */ 

CREATE OR REPLACE FUNCTION FrazionePartecipantiFemminili(CategoriaID decimal, CorsoDiStudi varchar)
RETURNS DECIMAL AS $$
DECLARE
    totale_partecipanti DECIMAL;
    partecipanti_femminili DECIMAL;
BEGIN
    -- Calcolare il totale dei partecipanti provenienti dal corso di studi
    SELECT COUNT(*) INTO totale_partecipanti
    FROM Candidatura c
		JOIN Utente u ON c.Username = u.Username
    	JOIN Partecipa p ON p.Squadra_ID = c.Squadra
    	JOIN Evento e ON e.ID = p.Evento_ID
    WHERE e.Categoria = CategoriaID AND u.corso_di_studi = CorsoDiStudi
		AND c.stato = 'accettato';

    -- Calcolare il numero di partecipanti femminili provenienti dal corso di studi
    SELECT COUNT(*) INTO partecipanti_femminili
    FROM Candidatura c
		JOIN Utente u ON c.Username = u.Username
    	JOIN Partecipa p ON p.Squadra_ID = c.Squadra
    	JOIN Evento e ON e.ID = p.Evento_ID
    WHERE e.Categoria = CategoriaID AND u.corso_di_studi = CorsoDiStudi
		AND c.stato = 'accettato' AND u.genere='F';
    -- Se il totale dei partecipanti è zero, restituire zero
    IF totale_partecipanti = 0 THEN
        RETURN 0;
    ELSE
        -- Calcolare e restituire la frazione di partecipanti femminili
        RETURN partecipanti_femminili / totale_partecipanti;
    END IF;
END;
$$ 
LANGUAGE plpgsql;

--Select * from FrazionePartecipantiFemminili(1,'Informatica');

/*************************************************************************************************************************************************************************/ 
--5. Trigger
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 5a: trigger per la verifica del vincolo che non è possibile iscriversi a eventi chiusi 
e che lo stato di un evento sportivo diventa CHIUSO quando si raggiunge un numero di giocatori pari a quello previsto 
dalla categoria */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione del trigger senza rimuovere la specifica nel commento precedente */ 
/* Trigger per impedire l'iscrizione a eventi chiusi*/

CREATE FUNCTION check_event_closed()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se l'evento è chiuso
    IF (SELECT stato FROM Evento WHERE ID = NEW.ID_evento) = 'CHIUSO' THEN
        RAISE EXCEPTION 'Non è possibile iscriversi a un evento chiuso.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_event_closed
BEFORE INSERT ON Iscrive
FOR EACH ROW
EXECUTE FUNCTION check_event_closed();

/*Trigger per aggiornare lo stato dell'evento a "CHIUSO"*/

CREATE FUNCTION close_event_if_full()
RETURNS TRIGGER AS $$
DECLARE
    num_giocatori_categoria INT;
    num_partecipanti INT;
BEGIN
    -- il numero di giocatori previsto dalla categoria
    SELECT num_giocatori INTO num_giocatori_categoria
    FROM Categoria
    WHERE ID = (SELECT Categoria FROM Evento WHERE ID = NEW.ID_evento);
    
    --il numero di partecipanti attuali all'evento
    SELECT COUNT(*) INTO num_partecipanti
    FROM Iscrive
    WHERE ID_evento = NEW.ID_evento AND stato = 'confermato';
    
    -- Se il numero di partecipanti è uguale o superiore al numero di giocatori previsto, chiudo l'evento
    IF num_partecipanti >= num_giocatori_categoria THEN
        UPDATE Evento
        SET stato = 'CHIUSO'
        WHERE ID = NEW.ID_evento;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_close_event_if_full
AFTER INSERT OR UPDATE ON Iscrive
FOR EACH ROW
EXECUTE FUNCTION close_event_if_full();

/*************************************************************************************************************************************************************************/ 
/* 5b1: trigger che gestisce la sede di un evento: se la sede è disponibile nel periodo 
di svolgimento dell'evento la sede viene confermata altrimenti viene individuata una sede alternativa: 
tra gli impianti disponibili nel periodo di svolgimento dell'evento si seleziona 
quello meno utilizzato nel mese in corso (vedi vista Programma) */



/* 5b2: trigger per il mantenimento dell'attributo derivato livello */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione del trigger lasciando la specifica nel commento precedente corrispondente al trigger realizzato tra le due alternative proposte per b.,
a seconda che il livello del giocatore sia memorizzato o meno */ 