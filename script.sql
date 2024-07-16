CREATE SCHEMA "UniGeSocialSport";
set search_path to 'UniGeSocialSport';
set datestyle to "DMY";

CREATE TABLE Utente(
	Username varchar (25) not null PRIMARY KEY,
	premium boolean not null DEFAULT false,
	genere varchar not null check(genere in ('M','F')),
	corso_di_studi varchar (30) NOT NULL,
	cognome varchar (30) not null,
	nome varchar(15) not null,
	foto boolean not null default false,
	telefono decimal (9,0) not null,
	password varchar (20) not null,
	affidabile boolean not null default true,
	matricola decimal (7,0) not null,
	luogoN varchar(25) not null,
	dataN timestamp not null check(dataN < current_date),
	UNIQUE (telefono),
	UNIQUE (matricola)
);

----------------------------------------------------------------------

CREATE TABLE Categoria(
	ID decimal (5,0) not null PRIMARY KEY,
	nomeC varchar (20) not null,
	num_giocatori decimal (2,0) NOT NULL,
	durata decimal (3,0) not null,
	regolamento varchar (100) not null,
	foto boolean NOT NULL
);



CREATE TABLE Liv_Utente(
	ID decimal (5,0) not null REFERENCES Categoria (ID),
	Username  varchar (25) not null REFERENCES Utente (Username),
	livello decimal (3,0) not null check (livello  between 1 and 100),
	PRIMARY KEY(ID, Username)
);

-------------------------------------------------------------
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
	NomeT varchar (30) not null PRIMARY KEY,
	data_limite date  not null, --check( data_limite > current_date),
	Organizzatore varchar(25) not null REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)), 
	descrizione varchar (100)
);


-------------------------------------------------------------------------

CREATE TABLE Squadra(
	ID decimal (5,0) not null PRIMARY KEY,
	NomeS varchar(25) not null,
	Torneo varchar(30) REFERENCES Torneo (NomeT),
	Organizzatore varchar (25) not null REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)),
	num_giocatori_max decimal (2,0) not null,
	num_giocatori_min decimal (2,0) not null check (num_giocatori_min <= num_giocatori_max),
	colore_maglia varchar (15),
	stato varchar(6) not null default 'aperto' check (stato in ('aperto','chiuso')),
	descrizione varchar (100),
	UNIQUE(NomeS,Torneo)
);

-------------------------------------------------------------------------------

CREATE TABLE Note (
	ID decimal (5,0) not null PRIMARY KEY,
	Squadra_ID decimal (5,0) not null REFERENCES Squadra(ID),
	nota varchar (100) not null
);

------------------------------------------------------------------------------------------
-- Nella tabella l'utente organizzatore di un Evetno 'spot' inserirà le tuple anche per le squadre

CREATE TABLE Candidatura(
	Username varchar (25) not null REFERENCES Utente (Username),
	Squadra decimal (5,0) not null REFERENCES Squadra (ID),
	stato varchar(9) check (stato in ('accettato','rifiutato')),
	data timestamp  default current_date,
	PRIMARY KEY(Username,Squadra)
);


---------------------------------------------------------------------------------

CREATE TABLE Restrizioni(
	ID decimal (2,0) not null PRIMARY KEY,
	descrizione varchar(100) not null
);


CREATE TABLE RestrizioniTorneo(
	ID decimal(2,0) not null REFERENCES Restrizioni (ID),
	NomeT varchar (30) not null REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);



---------------------------------------------------------------------

CREATE TABLE Premio (
	ID decimal(2,0) not null PRIMARY KEY,
	premio varchar(100) not null not null
);


CREATE TABLE PremioTorneo(
	ID decimal(2,0) not null REFERENCES Premio (ID),
	NomeT varchar (30) not null REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);



---------------------------------------------------------------------

CREATE TABLE Sponsor(
	ID decimal(2,0) not null PRIMARY KEY,
	nome varchar(40) not null
);


CREATE TABLE SponsorTorneo (
	ID decimal(2,0) not null REFERENCES Sponsor (ID),
	NomeT varchar (30) not null REFERENCES Torneo(NomeT),
	PRIMARY KEY (ID,NomeT)
);


----------------------------------------------------------

CREATE TABLE Impianto (
	NomeI varchar(20) not null PRIMARY KEY,
	via varchar(20) not null,
	telefono decimal (9,0) not null,
	email varchar (30) not null,
	latitudine float (10),
	longitudine float (10),
	UNIQUE(telefono),
	UNIQUE(email)
);


------------------------------------------------------------------------------------------------------

CREATE TABLE Evento (
	ID decimal (5,0) not null PRIMARY KEY,
	data timestamp  not null,
	data_disiscrizione timestamp  not null check(data_disiscrizione < data),
	foto boolean not null DEFAULT false,
	Categoria decimal(5,0) not null REFERENCES Categoria (ID),
	Torneo varchar(30) REFERENCES Torneo (NomeT),
	Impianto varchar(20) not null REFERENCES Impianto(NomeI),
	Organizzatore varchar(25) not null REFERENCES Utente(Username) CHECK (is_organizzatore_premium(Organizzatore)),
	stato varchar(6) not null default 'aperto' check (stato in ('aperto','chiuso'))
);

----------------------------------------------------------------------------------------

CREATE TABLE Prestazione(
	Valutato varchar (25) not null REFERENCES Utente (Username),
	Evento_ID decimal (5,0) not null REFERENCES Evento (ID),
	Valutante varchar (25) not null REFERENCES Utente (Username),
	valutazione decimal (3,0) not null,
	commento varchar(100),
	PRIMARY KEY (Valutato, Evento_ID, Valutante)
);

-- L'inserimento all'interno della tabella è possibile solamente in data successiva a quella dell'Evento.
-- E' possibile valutare un Utente solamente in Eventi a cui ha preso parte (sia come singolo che come squadra)
-- Implementabile tramite Trigger.

---------------------------------------------------------------------------------------------------

CREATE TABLE Punti_Segnati(
	Username varchar (25) not null REFERENCES Utente(Username),
	Evento_ID decimal (5,0) not null REFERENCES Evento(ID),
	punti_Goal decimal(3,0) not null,
	PRIMARY KEY (Username, Evento_ID)
);

-- Eventuali INSERT nella tabella potranno essere effettuate solamente in data posteriore all'Evento a cui si fa riferimento
-- Implementabile tramite Trigger

----------------------------------------------------------------------------------------
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
	data timestamp  not null default current_date,
	ruolo varchar(10) not null check (ruolo in ('giocatore','arbitro')),
	ritardo boolean,
	no_show boolean,
	PRIMARY KEY (Username, ID),
	UNIQUE(Username,ID,Sostituto)
);
-- E' possibile iscriversi solo ad Eventi aventi il campo Torneo = NULL
--Evento 0:
	
-----------------------------------------------------------------
-- Trigger che impone che solo squadre con nomi differenti possono iscriversi allo stesso evento

CREATE TABLE Partecipa (
	Squadra_ID decimal (5,0) not null REFERENCES Squadra(ID),
	Evento_ID decimal (5,0) not null REFERENCES Evento (ID),
	punti_segnati decimal(3,0),
	PRIMARY KEY(Squadra_ID, Evento_ID)
);
