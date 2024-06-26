set search_path to 'UniGeSocialSport_p'
set datestyle to "DMY";

CREATE TABLE Utente(
	Username varchar (25) PRIMARY KEY,
	premium boolean not null DEFAULT false,
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
INSERT INTO Utente (Username, premium, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user123', true ,'Informatica', 'Rossi', 'Mario', 123456789, 'password123', '123456789', 'Torino', '1990-01-01');

-- 2. Insert with optional fields set to default
INSERT INTO Utente (Username, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user456', 'Ingegneria', 'Bianchi', 'Anna', 987654321, 'secure_password', '987654321', 'Milano', '1995-07-14');

-- 3. Insert with boolean field set to true
INSERT INTO Utente (Username, premium, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user789', true,'Economia', 'Verdi', 'Giuseppe', 222333444, 'pass1234', '222333444', 'Roma', '2000-12-31');


----------------------------------------------------------------------

CREATE TABLE Categoria(
	ID decimal (5,0) PRIMARY KEY,
	num_giocatori decimal (2,0) NOT NULL,
	regolamento varchar (100) not null,
	foto boolean NOT NULL
);

INSERT INTO Categoria VALUES(1, 10, 'si gioca 5 Vs 5 regole del Basket FIBA', false);
INSERT INTO Categoria VALUES(2, 12, 'si gioca 6 Vs 6 regole della pallavolo classica', false);
INSERT INTO Categoria VALUES(3, 2, 'si gioca 1 Vs 1 regole del Tennis singolo', false);
INSERT INTO Categoria VALUES(4, 14, 'si gioca 7 Vs 7 regole del Calcio a 7', false);


CREATE TABLE Liv_Utente(
	ID decimal (5,0) REFERENCES Categoria (ID),
	Username  varchar (25) REFERENCES Utente (Username),
	livello decimal (3,0) not null check (livello  between 1 and 100),
	PRIMARY KEY(ID, Username)
);

INSERT INTO Liv_Utente VALUES(1, 'user123', 50);
INSERT INTO Liv_Utente VALUES(2, 'user123', 50);
INSERT INTO Liv_Utente VALUES(3, 'user123', 50);
INSERT INTO Liv_Utente VALUES(4, 'user123', 50);


INSERT INTO Liv_Utente VALUES(1, 'user456', 50);
INSERT INTO Liv_Utente VALUES(2, 'user456', 20);
INSERT INTO Liv_Utente VALUES(3, 'user456', 30);
INSERT INTO Liv_Utente VALUES(4, 'user456', 60);


INSERT INTO Liv_Utente VALUES(1, 'user789', 20);
INSERT INTO Liv_Utente VALUES(2, 'user789', 60);
INSERT INTO Liv_Utente VALUES(3, 'user789', 70);
INSERT INTO Liv_Utente VALUES(4, 'user789', 40);

-------------------------------------------------------------------------
CREATE TABLE Squadra(
	ID decimal (5,0) PRIMARY KEY,
	NomeS varchar(25) not null,
	num_giocatori_max decimal (2,0) not null,
	num_giocatori_min decimal (2,0) not null,
	colore_maglia varchar (15),
	stato varchar(6) not null default 'aperto' check (stato in ('aperto','chiuso')),
	descrizione varchar (100)
);

INSERT INTO Squadra VALUES(1, 'Boston', 16, 5, 'verde','aperto');
INSERT INTO Squadra VALUES(2, 'NonTroppoAtletici', 14, 6, 'bianco','aperto');
INSERT INTO Squadra VALUES(3, 'Cardedu', 2, 2, 'blu','aperto');
INSERT INTO Squadra VALUES(4, 'SanfruBeach', 26, 11, 'rosso','aperto');

CREATE TABLE Candidatura(
	Username varchar (25) references Utente (Username),
	Squadra decimal (5,0) references Squadra (ID),
	stato varchar(9) check (stato in ('accettato','rifiutato')),
	data date default current_date,
	PRIMARY KEY(Username,Squadra)
);

INSERT INTO Candidatura VALUES('user123', 1);
INSERT INTO Candidatura VALUES('user123', 2);
INSERT INTO Candidatura VALUES('user123', 3);
INSERT INTO Candidatura VALUES('user123', 4);
INSERT INTO Candidatura VALUES('user456', 1);
INSERT INTO Candidatura VALUES('user456', 2);
INSERT INTO Candidatura VALUES('user456', 3);
INSERT INTO Candidatura VALUES('user456', 4);
INSERT INTO Candidatura VALUES('user789', 2);

---------------------------------------------------------------------

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


CREATE TABLE Evento(
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

INSERT INTO Evento VALUES (1, current_date, '20/06/2024', 'false' , 1, 'NBA', 'calcio Gambaro', 'user123');
INSERT INTO Evento VALUES (2, current_date, '21/06/2024', 'TRUE' , 3, 'Roland garros', 'tennis Puggia', 'user123');
INSERT INTO Evento VALUES (3, current_date, '22/06/2024', 'false' , 2, 'FIVB', 'pallavolo Puggia', 'user789');
---------------------------------------------------------------------------------------------------

CREATE TABLE Prestazione(
	Username varchar (25) REFERENCES Utente (Username),
	Evento_ID decimal (5,0) REFERENCES Evento (ID),
	Valutante varchar (25) REFERENCES Utente (Username),
	valutazione decimal (3,0) not null,
	commento varchar(100),
	PRIMARY KEY (Username, Evento_ID, Valutante)
);

-- L'inserimento all'interno della tabella è possibile solamente in data successiva a quella dell'Evento.
-- Implementabile tramite Trigger.

-- INSERT INTO Prestazione VALUES();

---------------------------------------------------------------------------------------------------

CREATE TABLE Punti_Segnati(
	Username varchar (25) REFERENCES Utente(Username),
	Evento_ID decimal (5,0) REFERENCES Evento(ID),
	punti_Goal decimal(3,0) not null,
	PRIMARY KEY (Username, Evento_ID)
);

-- Eventuali INSERT nella tabella potranno essere effettuate solamente in data posteriore all'Evento a cui si fa riferimento
-- Implementabile tramite Trigger

--INSERT INTO Punti_segnati VALUES ();

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
	Username varchar(25) REFERENCES Utente(Username),
	ID decimal(5,0) REFERENCES Evento(ID),
	Sostituto varchar (25) REFERENCES Utente(Username) check (user_not_in_this_event(Sostituto, ID)),
	stato varchar(10) check (stato in ('rifiutato','accettato')),
	data date not null default current_date,
	ruolo varchar(10) not null check (ruolo in ('giocatore','arbitro')),
	ritardo boolean,
	no_show boolean,
	PRIMARY KEY (Username, ID),
	UNIQUE(Username,ID,Sostituto)
);

INSERT INTO Iscrive VALUES ('user123',1,null,null,current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user123',2,null,null,current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',3,null,null,current_date,'giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',2,null,null,current_date,'giocatore',null,null);

-----------------------------------------------------------------
-- Trigger che impone che solo squadre con nomi differenti possono iscriversi allo stesso evento

CREATE TABLE Partecipa (
	Squadra_ID decimal (5,0) REFERENCES Squadra(ID),
	Evento_ID decimal (5,0) REFERENCES Evento (ID),
	punti_segnati decimal(3,0),
	PRIMARY KEY(Squadra_ID, Evento_ID)
);

INSERT INTO Partecipa VALUES (1,1);
INSERT INTO Partecipa VALUES (2,1);
INSERT INTO Partecipa VALUES (3,2);
INSERT INTO Partecipa VALUES (1,2);

------------------------------------------------------------------
-- Trigger che impone che solo squadre aventi nomi differenti possono partecipare allo stesso Torneo

CREATE TABLE Prende_parte (
	Squadra_ID decimal (5,0) REFERENCES Squadra(ID),
	Torneo_ID decimal (5,0) REFERENCES Evento (ID),
	PRIMARY KEY(Squadra_ID, Torneo_ID)
);

INSERT INTO Prende_parte VALUES (1,1);
INSERT INTO Prende_parte VALUES (2,1);
INSERT INTO Prende_parte VALUES (3,2);
INSERT INTO Prende_parte VALUES (1,2);

-------------------------------------------------------------------
