set search_path to 'UniGeSocialSport';
-------------------------------------------------------------------

--2. Vista
/*Vista Programma che per ogni impianto e mese riassume tornei e eventi che si svolgono in tale impianto, 
evidenziando in particolare per ogni categoria il numero di tornei, il numero di eventi, 
il numero di partecipanti coinvolti e di quanti diversi corsi di studio, 
la durata totale (in termini di minuti) di utilizzo e la percentuale di utilizzo rispetto alla disponibilita 
complessiva (minuti totali nel mese in cui l impianto utilizzabile) */


/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della vista senza rimuovere la specifica nel commento precedente */ 

CREATE OR REPLACE VIEW Programma(Impianto, Mese,Numero_Torneo, Numero_Eventi, Categoria, Numero_Giocatori, 
					  Numero_corso_di_studi, Minuti_Tot, Percentuale_utilizzo)AS
	Select Impianto, 
			EXTRACT(MONTH FROM Evento.data) Mese,
			count(distinct NomeT) Num_Tornei,
			count(distinct Evento.ID) Num_Eventi, nomeC, 
			count(distinct Iscrive.Username) Num_Giocatori, 
			count (distinct corso_di_studi) Num_corso_di_studi, 
			sum(durata) Minuti_Tot, 
			(sum(durata)/18000*100) Percentuale_utilizzo
	From Torneo
		join Evento on torneo=NomeT 
		join Categoria on Categoria = Categoria.ID
		--join Punti_Segnati on Punti_Segnati.Evento_ID = Evento.ID
		join Iscrive on Evento.ID = Iscrive.ID
		join Utente on Iscrive.Username = Utente.Username
		--join Candidatura on candidatura.Username = Utente.Username
	Where Iscrive.stato = 'confermato'
	Group by (Impianto, Mese, nomeC);

--Select * from Programma;

/*************************************************************************************************************************************************************************/ 
--3. Interrogazioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 3a: Determinare gli utenti che si sono candidati come giocatori e non sono mai stati accettati e quelli che sono stati accettati tutte le volte che si sono candidati */
/*************************************************************************************************************************************************************************/ 
-- La query è stata interpretata come candidatura alle Squadre in quanto se un Utente viene accettato allora seguirà la sua candidatura
-- ad una squadra. Tale Squadra sarà creata nella quale vi saranno, naturlamente, tutti gli Utenti confermati per l'Evento
/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 

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

/*************************************************************************************************************************************************************************/ 
/* 3b: determinare gli utenti che hanno partecipato ad almeno un evento di ogni categoria */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 
-- l'eventuale join Iscrive on Iscrive.Username = Utente.Username
-- è superflua perche se ha preso parte all'evento allora è stato messo in una Squadra.

Select Username
from (Select distinct Utente.Username, Categoria
		from Utente natural join Iscrive
	  		join Evento on Iscrive.ID = Evento.ID
		where  Iscrive.stato = 'confermato' AND Evento.data <= current_date)
group by Username
HAVING count (distinct Categoria) = (Select count (*) from Categoria);

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
CREATE OR REPLACE FUNCTION is_part_of_team(Person varchar)
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

-- Select * from is_part_of_team('FQ30');
-- Select * from is_part_of_team('user456');

/*************************************************************************************************************************************************************************/ 
/* 4b1: funzione che dato un giocatore ne calcoli il livello */

-- ALGORTIMO
/*calcolo la media delle valutazioni la peso in centesimi e ottengo il mio livello
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
CREATE OR REPLACE FUNCTION user_category_level(Pers varchar, Cat decimal)
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

--Select* From user_category_level('user456',4);

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
    SELECT COUNT(distinct i.Username) INTO totale_partecipanti
    FROM Iscrive i
		JOIN Utente u ON i.Username = u.Username
    	--JOIN Partecipa p ON p.Squadra_ID = c.Squadra
    	JOIN Evento e ON e.ID = i.ID
    WHERE e.Categoria = CategoriaID AND u.corso_di_studi = CorsoDiStudi
		AND i.stato = 'confermato';
		
    -- Calcolare il numero di partecipanti femminili provenienti dal corso di studi
    SELECT COUNT(distinct i.Username) --INTO partecipanti_femminili
    FROM Iscrive i
		JOIN Utente u ON i.Username = u.Username
    	JOIN Evento e ON e.ID = i.ID
    WHERE e.Categoria = CategoriaID AND u.corso_di_studi = CorsoDiStudi
		AND i.stato = 'confermato' AND u.genere='F';

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

-- Select * from FrazionePartecipantiFemminili(3,'Chimica');

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

CREATE OR REPLACE FUNCTION check_event_closed()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se l'evento è chiuso
    IF (SELECT stato FROM Evento WHERE ID = NEW.ID) = 'chiuso' THEN
        RAISE EXCEPTION 'Non è possibile iscriversi a un evento chiuso.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_event_closed
AFTER INSERT ON Iscrive
FOR EACH ROW
EXECUTE FUNCTION check_event_closed();

/*Trigger per aggiornare lo stato dell'evento a "CHIUSO"*/


CREATE OR REPLACE FUNCTION close_event_if_full_past()
RETURNS TRIGGER AS $$
DECLARE
    num_giocatori_categoria INT;
    num_partecipanti INT;
	is_past boolean;
BEGIN
    -- il numero di giocatori previsto dalla categoria
    SELECT num_giocatori INTO num_giocatori_categoria
    FROM Categoria
    WHERE ID = (SELECT Categoria FROM Evento WHERE ID = NEW.ID);
    
    --il numero di partecipanti attuali all'evento
    SELECT COUNT(*) INTO num_partecipanti
    FROM Iscrive
    WHERE Iscrive.ID = NEW.ID AND stato = 'confermato';
    
    -- Se il numero di partecipanti è uguale o superiore al numero di giocatori previsto, chiudo l'evento
    IF num_partecipanti >= num_giocatori_categoria THEN
        UPDATE Evento
        SET stato = 'chiuso'
        WHERE ID = NEW.ID;
    END IF;
    
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_close_event_if_full
AFTER INSERT OR UPDATE ON Iscrive
FOR EACH ROW
EXECUTE FUNCTION close_event_if_full_past();

/*************************************************************************************************************************************************************************/ 
/* 5b1: trigger che gestisce la sede di un evento: se la sede è disponibile nel periodo 
di svolgimento dell'evento la sede viene confermata altrimenti viene individuata una sede alternativa: 
tra gli impianti disponibili nel periodo di svolgimento dell'evento si seleziona 
quello meno utilizzato nel mese in corso (vedi vista Programma) */
-- Creazione della funzione del trigger

CREATE OR REPLACE FUNCTION gestione_sede_evento() 
RETURNS TRIGGER AS $$
DECLARE
    volte_sede_non_disponibile decimal;
    sede_alternativa RECORD;
BEGIN
    -- Verifica se la sede è disponibile nel periodo dell'evento 
    SELECT COUNT(*) INTO volte_sede_non_disponibile
    FROM Evento join Categoria on Evento.categoria = categoria.id
    WHERE Impianto = NEW.Impianto
	 AND 
	 (
		 --se finisco dopo l'inizio di un evento E prima della sua fine non va bene
			((NEW.data + INTERVAL '1 minute' * Categoria.durata) >= Evento.data 
			 AND ((NEW.data + INTERVAL '1 minute' * Categoria.durata) < Evento.data + INTERVAL '1 minute' * Categoria.durata))
		OR --se inizio dopo l'inizio di un evento E prima della sua fine non va bene
        	(NEW.data > Evento.data 
			 AND (NEW.data < Evento.data + INTERVAL '1 minute' * Categoria.durata)) 
		OR --se inizio prima E finisco dopo di un evento non va bene
			(NEW.data < Evento.data 
			 AND ((Evento.data + INTERVAL '1 minute' * Categoria.durata) < NEW.data + INTERVAL '1 minute' * Categoria.durata))
	 ) ;
	 
    IF volte_sede_non_disponibile = 0 THEN
        -- Se la sede è disponibile, conferma la sede
        RETURN NEW;
    ELSE
        -- Se la sede non è disponibile, seleziona una sede alternativa
        SELECT Impianto INTO sede_alternativa
        FROM Programma
        WHERE Mese = EXTRACT(MONTH FROM NEW.data)
        ORDER BY Percentuale_utilizzo ASC
        LIMIT 1;

        -- Assegna la sede alternativa
        IF sede_alternativa IS NOT NULL THEN
            NEW.Impianto = sede_alternativa.Impianto;
        ELSE
            RAISE EXCEPTION 'Nessuna sede disponibile per il periodo specificato.';
        END IF;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Applicazione del trigger alla tabella Evento
CREATE OR REPLACE TRIGGER trigger_gestione_sede_evento
BEFORE INSERT OR UPDATE ON Evento
FOR EACH ROW
EXECUTE FUNCTION gestione_sede_evento();

--INSERT INTO Evento VALUES (51, '22/06/2024 14:00:00', '21/06/2024 11:00:00', 'TRUE' , 3, 'NBA', 'basket Puggia', 'user123');

/* 5b2: trigger per il mantenimento dell'attributo derivato livello */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione del trigger lasciando la specifica nel commento precedente corrispondente al trigger realizzato tra le due alternative proposte per b.,
a seconda che il livello del giocatore sia memorizzato o meno */ 