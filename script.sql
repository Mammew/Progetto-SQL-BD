CREATE SCHEMA "UniGeSocialSport_p";
set search_path to 'UniGeSocialSport_p';
set datestyle to "DMY";

CREATE TABLE Utente(
	Username varchar (25) PRIMARY KEY,
	premium boolean not null DEFAULT false,
	genere varchar not null check(genere in ('M','F')),
	corso_di_studi varchar (30) NOT NULL,
	cognome varchar (30) not null,
	nome varchar(15) not null,
	foto boolean not null default false,
	telefono decimal (9,0) not null,
	password varchar (20) not null,
	affidabile boolean,
	matricola varchar (9) not null,
	luogoN varchar(25) not null,
	dataN date not null,
	UNIQUE (telefono),
	UNIQUE (matricola)
);
INSERT INTO Utente (Username, premium, genere,corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user123', true,'F','Informatica', 'Rossi', 'Mario', 123456789, 'password123', '123456789', 'Torino', '1990-01-01',true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('FQ30', true,'M','Matematica statistica', 'Quirolo', 'Federico', 163456789, 'password123', '133756789', 'Genova', '2002-12-30');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('simple2', true,'F','Giurisprudenza', 'Francesca', 'Totti', 128456789, 'password123', '103456789', 'Torino', '1999-01-01');

-- 2. Insert with optional fields set to default
INSERT INTO Utente (Username, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user456', 'F','Informatica', 'Bianchi', 'Anna', 987654321, 'secure_password', '987654321', 'Milano', '1995-07-14', true);

-- 3. Insert with boolean field set to true
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user789', true,'M','Giurisprudenza', 'Verdi', 'Giuseppe', 222333444, 'pass1234', '222333444', 'Roma', '2000-12-31');

----------------------------------------------------------------------

CREATE TABLE Categoria(
	ID decimal (5,0) PRIMARY KEY,
	nomeC varchar (20) not null,
	num_giocatori decimal (2,0) NOT NULL,
	durata decimal (3,0) not null,
	regolamento varchar (100) not null,
	foto boolean NOT NULL
);

INSERT INTO Categoria VALUES(1,'Basket' ,10, 42,'si gioca 5 Vs 5 regole del Basket FIBA', false);
INSERT INTO Categoria VALUES(2,'Pallavolo' ,12, 60, 'si gioca 6 Vs 6 regole della pallavolo classica', false);
INSERT INTO Categoria VALUES(3,'Tennis singolo', 2, 120, 'si gioca 1 Vs 1 regole del Tennis singolo', false);
INSERT INTO Categoria VALUES(4,'Calcio a 7' ,14, 60,'si gioca 7 Vs 7 regole del Calcio a 7', false);


CREATE TABLE Liv_Utente(
	ID decimal (5,0) not null REFERENCES Categoria (ID),
	Username  varchar (25) not null REFERENCES Utente (Username),
	livello decimal (3,0) not null check (livello  between 1 and 100),
	PRIMARY KEY(ID, Username)
);

INSERT INTO Liv_Utente VALUES(1, 'user123', 60);
INSERT INTO Liv_Utente VALUES(2, 'user123', 60);
INSERT INTO Liv_Utente VALUES(3, 'user123', 60);
INSERT INTO Liv_Utente VALUES(4, 'user123', 60);

INSERT INTO Liv_Utente VALUES(1, 'FQ30', 60);
INSERT INTO Liv_Utente VALUES(2, 'FQ30', 60);
INSERT INTO Liv_Utente VALUES(3, 'FQ30', 60);
INSERT INTO Liv_Utente VALUES(4, 'FQ30', 60);


INSERT INTO Liv_Utente VALUES(1, 'simple2', 60);
INSERT INTO Liv_Utente VALUES(2, 'simple2', 60);
INSERT INTO Liv_Utente VALUES(3, 'simple2', 60);
INSERT INTO Liv_Utente VALUES(4, 'simple2', 60);


INSERT INTO Liv_Utente VALUES(1, 'user456', 60);
INSERT INTO Liv_Utente VALUES(2, 'user456', 60);
INSERT INTO Liv_Utente VALUES(3, 'user456', 60);
INSERT INTO Liv_Utente VALUES(4, 'user456', 60);


INSERT INTO Liv_Utente VALUES(1, 'user789', 60);
INSERT INTO Liv_Utente VALUES(2, 'user789', 60);
INSERT INTO Liv_Utente VALUES(3, 'user789', 60);
INSERT INTO Liv_Utente VALUES(4, 'user789', 60);
------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION is_organizzatore_premium(organizzatore varchar)
RETURNS boolean
AS $$
DECLARE
  is_premium boolean;
BEGIN
  SELECT premium INTO is_premium
  FROM Utente
  WHERE Username = organizzatore;

  IF NOT is_premium THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END $$
LANGUAGE plpgsql;


CREATE TABLE Torneo (
	NomeT varchar (20) PRIMARY KEY,
	data_limite date not null check( data_limite > current_date),
	Organizzatore varchar(25) not null REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)), 
	descrizione varchar (100)
);

INSERT INTO Torneo VALUES ('Roland garros', '25/08/2024','user123' ,'Torneo Tennis su terra rossa');
INSERT INTO Torneo VALUES ('FIVB',' 25/08/2024', 'user789', 'Torneo Pallavolo');
INSERT INTO Torneo VALUES ('Europeo', '1/08/2024', 'user789', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('NBA', '10/07/2024', 'user123', 'Torneo Basket indor');
INSERT INTO Torneo VALUES ('Mondiale', '1/08/2025', 'user123', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('FIBA', '1/08/2025', 'user123', 'Torneo Basket indor');

-------------------------------------------------------------------------

CREATE TABLE Squadra(
	ID decimal (5,0) PRIMARY KEY,
	NomeS varchar(25) not null,
	Torneo varchar(20) not null REFERENCES Torneo (NomeT), -- forse serve il not null
	Organizzatore varchar (25) REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)),
	num_giocatori_max decimal (2,0) not null,
	num_giocatori_min decimal (2,0) not null,
	colore_maglia varchar (15),
	stato varchar(6) not null default 'aperto' check (stato in ('aperto','chiuso')),
	descrizione varchar (100),
	UNIQUE(NomeS,Torneo)
);

INSERT INTO Squadra VALUES(1, 'Boston', 'NBA', 'user123', 16, 5, 'verde','aperto');
INSERT INTO Squadra VALUES(2, 'NonTroppoAtletici', 'FIVB', 'user123', 14, 6, 'bianco','aperto');
INSERT INTO Squadra VALUES(3, 'Cardedu', 'Roland garros', 'user789', 2, 2, 'blu','aperto');
INSERT INTO Squadra VALUES(4, 'SanfruBeach', 'Europeo', 'user789', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(5, 'Boston', 'FIBA', 'user123', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(6, 'SanfruBeach', 'Mondiale', 'user789', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(7, 'Los Angeles', 'NBA', 'user789', 16, 5, 'viola','aperto');
------------------------------------------------------------------------------------------

CREATE TABLE Note (
	ID decimal (5,0) PRIMARY KEY,
	Squadra_ID decimal (5,0) not null REFERENCES Squadra(ID),
	nota varchar (100) not null
);

------------------------------------------------------------------------------------------
-- Nella tabella l'utente organizzatore di un Evetno 'spot' inserirà le tuple anche per le squadre

CREATE TABLE Candidatura(
	Username varchar (25) not null REFERENCES Utente (Username),
	Squadra decimal (5,0) not null REFERENCES Squadra (ID),
	stato varchar(9) check (stato in ('accettato','rifiutato')),
	data date default current_date,
	PRIMARY KEY(Username,Squadra)
);

INSERT INTO Candidatura VALUES('user123', 1,'accettato');
INSERT INTO Candidatura VALUES('user123', 3,'accettato');
INSERT INTO Candidatura VALUES('user123', 4,'accettato');
INSERT INTO Candidatura VALUES('user456', 2,'accettato');
INSERT INTO Candidatura VALUES('user456', 3);
INSERT INTO Candidatura VALUES('user456', 4,'accettato');
INSERT INTO Candidatura VALUES('user789', 2,'accettato');

---------------------------------------------------------------------------------

CREATE TABLE Restrizioni(
	ID decimal (2,0) PRIMARY KEY,
	descrizione varchar(100) not null
);

INSERT INTO Restrizioni VALUES (1, 'Torneo solamente per altleti non tesserati');
INSERT INTO Restrizioni VALUES (2, 'Torneo solamente per femmine ');
INSERT INTO Restrizioni VALUES (3, 'Torneo solamente per maschi ');
INSERT INTO Restrizioni VALUES (4, 'Torneo solamente per atleti over 25');

CREATE TABLE RestrizioniTorneo(
	ID decimal(2,0) REFERENCES Restrizioni (ID),
	NomeT varchar (25) REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);

INSERT INTO RestrizioniTorneo VALUES(1, 'NBA');

INSERT INTO RestrizioniTorneo VALUES(1,'Europeo');

---------------------------------------------------------------------

CREATE TABLE Premio (
	ID decimal(2,0) PRIMARY KEY,
	premio varchar(100) not null
);

INSERT INTO Premio VALUES (1, 'Trofeo al vincitore del Torneo');
INSERT INTO Premio VALUES (2, 'Trofeo al secondo classificato del Torneo');
INSERT INTO Premio VALUES (3, 'Trofeo al terzo classificato del Torneo');
INSERT INTO Premio VALUES (4, 'Medaglia ai partecipanti delle fasi finali del Torneo');

CREATE TABLE PremioTorneo(
	ID decimal(2,0) REFERENCES Premio (ID),
	NomeT varchar (25) REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);

INSERT INTO PremioTorneo VALUES(1,'NBA');
INSERT INTO PremioTorneo VALUES(2,'NBA');

INSERT INTO PremioTorneo VALUES(1,'Europeo');
INSERT INTO PremioTorneo VALUES(2,'Europeo');
INSERT INTO PremioTorneo VALUES(3,'Europeo');

---------------------------------------------------------------------

CREATE TABLE Sponsor(
	ID decimal(2,0) PRIMARY KEY,
	nome varchar(40) not null
);

INSERT INTO Sponsor VALUES(1,'TIM');
INSERT INTO Sponsor VALUES(2,'Strike');
INSERT INTO Sponsor VALUES(3,'Regione Liguria');
INSERT INTO Sponsor VALUES(4,'Università degli studi di Genova');

CREATE TABLE SponsorTorneo (
	ID decimal(2,0) REFERENCES Sponsor (ID),
	NomeT varchar (25) REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);

INSERT INTO SponsorTorneo VALUES(1,'NBA');
INSERT INTO SponsorTorneo VALUES(3,'NBA');

INSERT INTO SponsorTorneo VALUES(1,'Europeo');
INSERT INTO SponsorTorneo VALUES(4,'Europeo');
---------------------------------------------------------------------

CREATE TABLE Impianto(
	NomeI varchar(20) PRIMARY KEY,
	via varchar(20) not null,
	telefono decimal (9,0) not null,
	email varchar (30) not null,
	latitudine float (10),
	longitudine float (10),
	UNIQUE(telefono),
	UNIQUE(email)
);

INSERT INTO Impianto VALUES('calcio Gambaro','viale gambaro',123456789,'calciog@gmail.com');
INSERT INTO Impianto VALUES('tennis Puggia','valletta puggia',222222222,'tennisp@gmail.com');
INSERT INTO Impianto VALUES('basket Puggia','valletta puggia',223344556,'basketp@gmail.com');
INSERT INTO Impianto VALUES('pallavolo Puggia','valletta puggia',998866523,'pallavolop@gmail.com');

------------------------------------------------------------------------------------------------------

CREATE TABLE Evento (
	ID decimal (5,0) PRIMARY KEY,
	data date not null,
	data_disiscrizione date not null check(data_disiscrizione < data),
	foto boolean not null DEFAULT false,
	Categoria decimal(5,0) not null REFERENCES Categoria (ID),
	Torneo varchar(20) REFERENCES Torneo (NomeT),
	Impianto varchar(20) not null REFERENCES Impianto(NomeI),
	Organizzatore varchar(25) not null REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)),
	stato varchar(6) not null default 'aperto' check (stato in ('aperto','chiuso'))
);
INSERT INTO Evento VALUES (0, '20/06/2000', '20/06/1999', 'false' , 1, null, 'basket Puggia', 'user123');

INSERT INTO Evento VALUES (1, '22/06/2024', '20/06/2024', 'false' , 1, null, 'basket Puggia', 'user123');
INSERT INTO Evento VALUES (2, '22/06/2024', '21/06/2024', 'TRUE' , 3, 'Roland garros', 'tennis Puggia', 'user123');
INSERT INTO Evento VALUES (3, '23/06/2024', '22/06/2024', 'false' , 2, 'FIVB', 'pallavolo Puggia', 'user789');
INSERT INTO Evento VALUES (4, '24/06/2024', '22/06/2024', 'false' , 4, 'Mondiale', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (5, '30/06/2024', '22/06/2024', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (6, '29/06/2024', '22/06/2024', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
---------------------------------------------------------------------------------------------------

CREATE TABLE Prestazione(
	Valutato varchar (25) REFERENCES Utente (Username),
	Evento_ID decimal (5,0) REFERENCES Evento (ID),
	Valutante varchar (25) REFERENCES Utente (Username),
	valutazione decimal (3,0) not null,
	commento varchar(100),
	PRIMARY KEY (Valutato, Evento_ID, Valutante)
);

-- L'inserimento all'interno della tabella è possibile solamente in data successiva a quella dell'Evento.
-- E' possibile valutare un Utente solamente in Eventi a cui ha preso parte (sia come singolo che come squadra)
-- Implementabile tramite Trigger.

-- INSERT INTO Prestazione VALUES();
INSERT INTO Prestazione VALUES('user123',1,'user456', 7);
INSERT INTO Prestazione VALUES('user123',1,'user789', 8);
INSERT INTO Prestazione VALUES('user456',5,'user123', 8);
INSERT INTO Prestazione VALUES('user456',5,'user789', 7);
INSERT INTO Prestazione VALUES('user789',2,'user123', 6);
INSERT INTO Prestazione VALUES('user789',2,'user456', 7);
INSERT INTO Prestazione VALUES('user789',1,'user456', 7);
INSERT INTO Prestazione VALUES('user789',1,'user123', 5);

---------------------------------------------------------------------------------------------------

CREATE TABLE Punti_Segnati(
	Username varchar (25) REFERENCES Utente(Username),
	Evento_ID decimal (5,0) REFERENCES Evento(ID),
	punti_Goal decimal(3,0) not null,
	PRIMARY KEY (Username, Evento_ID)
);

-- Eventuali INSERT nella tabella potranno essere effettuate solamente in data posteriore all'Evento a cui si fa riferimento
-- Implementabile tramite Trigger

INSERT INTO Punti_segnati VALUES ('user123',5,1);
INSERT INTO Punti_segnati VALUES ('user456',5,1);
INSERT INTO Punti_segnati VALUES ('user789',5,1);
INSERT INTO Punti_segnati VALUES ();
INSERT INTO Punti_segnati VALUES ();
---------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION user_not_in_this_event(Sostituto varchar, Evento decimal)
RETURNS boolean
AS $$
BEGIN

  IF Sostituto IN(  SELECT Username
  						FROM Utente natural join Iscrive
  						WHERE Evento = Iscrive.ID)
  THEN
    RETURN FALSE;
  ELSE
    RETURN TRUE;
  END IF;
END $$
LANGUAGE plpgsql;

--DROP FUNCTION not_in_this_event(varchar, decimal);

CREATE TABLE Iscrive(
	Username varchar(25) not null REFERENCES Utente(Username),
	ID decimal(5,0) not null REFERENCES Evento(ID),
	Sostituto varchar (25) REFERENCES Utente(Username) check (user_not_in_this_event(Sostituto, ID)),
	stato varchar(10) check (stato in ('rifiutato','confermato')),
	data date not null default current_date,
	ruolo varchar(10) not null check (ruolo in ('giocatore','arbitro')),
	ritardo boolean,
	no_show boolean,
	PRIMARY KEY (Username, ID),
	UNIQUE(Username,ID,Sostituto)
);
-- E' possibile iscriversi solo ad Eventi aventi il campo Torneo = NULL
--Evento 0:
	INSERT INTO Iscrive VALUES ('user123',0,null,'confermato','12/06/1999','giocatore',null,null);
	INSERT INTO Iscrive VALUES ('user456',0,null,'confermato','10/06/1999','giocatore',null,null);
	INSERT INTO Iscrive VALUES ('user789',0,null,'confermato','28/06/1999','giocatore',null,null);

INSERT INTO Iscrive VALUES ('user123',1,null,'confermato',current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user123',2,null,'confermato',current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user123',3,null,'confermato',current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user123',4,null,'confermato',current_date,'giocatore',null,null);

INSERT INTO Iscrive VALUES ('user456',3,null,'confermato',current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',2,null,'confermato',current_date,'giocatore',null,null);

INSERT INTO Iscrive VALUES ('user789',1,null,'confermato','28/06/1999','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',2,null,'confermato','28/06/1999','giocatore',null,null);

-----------------------------------------------------------------
-- Trigger che impone che solo squadre con nomi differenti possono iscriversi allo stesso evento

CREATE TABLE Partecipa (
	Squadra_ID decimal (5,0) REFERENCES Squadra(ID),
	Evento_ID decimal (5,0) REFERENCES Evento (ID),
	punti_segnati decimal(3,0),
	PRIMARY KEY(Squadra_ID, Evento_ID)
);

INSERT INTO Partecipa VALUES (1,5,1);
INSERT INTO Partecipa VALUES (2,5,2);
INSERT INTO Partecipa VALUES (3,2);
INSERT INTO Partecipa VALUES (7,6);

-------------------------------------------------------------------

--2. Vista
/*Vista Programma che per ogni impianto e mese riassume tornei e eventi che si svolgono in tale impianto, 
evidenziando in particolare per ogni categoria il numero di tornei, il numero di eventi, 
il numero di partecipanti coinvolti e di quanti diversi corsi di studio, 
la durata totale (in termini di minuti) di utilizzo e la percentuale di utilizzo rispetto alla disponibilita 
complessiva (minuti totali nel mese in cui l impianto utilizzabile) */

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
	Group by (Impianto, Mese, nomeC, durata)

/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della vista senza rimuovere la specifica nel commento precedente */ 

/*************************************************************************************************************************************************************************/ 
--3. Interrogazioni
/*************************************************************************************************************************************************************************/ 

/*************************************************************************************************************************************************************************/ 
/* 3a: Determinare gli utenti che si sono candidati come giocatori e non sono mai stati accettati e quelli che sono stati accettati tutte le volte che si sono candidati */
/*************************************************************************************************************************************************************************/ 

Select Username
from Utente natural join Iscrive
where stato = 'confermato'
EXCEPT
Select Username
from Utente natural join Iscrive
where stato = 'rifiutato'

/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 

/*************************************************************************************************************************************************************************/ 
/* 3b: determinare gli utenti che hanno partecipato ad almeno un evento di ogni categoria */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query senza rimuovere la specifica nel commento precedente */ 

Select Username
from (Select distinct Utente.Username, Categoria
		from Utente natural join Iscrive join Evento on Iscrive.ID = Evento.ID 
	  		join Candidatura on Candidatura.Username = Utente.Username 
		where Iscrive.stato = 'confermato' OR Candidatura.stato = 'accettato' AND Evento.data <= current_date)
group by Username
HAVING count (distinct Categoria) = (Select count (*) from Categoria)

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
							Group by nomeC, corso_di_studi)



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
AS$$
DECLARE
	last_event decimal;
BEGIN
	Select Evento.ID INTO last_event
	From Utente join 
END $$
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
CREATE OR REPLACE FUNCTION check_event_closed()
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

CREATE OR REPLACE FUNCTION close_event_if_full()
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