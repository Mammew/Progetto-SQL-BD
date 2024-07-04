--- Progetto BD 23-24 (12 CFU)
--- Numero gruppo
--- Nomi e matricole componenti

set search_path to 'UniGeSocialSport_p';

--- PARTE III 
/* il file deve essere file SQL ... cio� formato solo testo e apribili ed eseguibili in pgAdmin */



/*************************************************************************************************************************************************************************/ 
--1b. Schema per popolamento in the large
/*************************************************************************************************************************************************************************/ 


/* per ogni relazione R coinvolta nel carico di lavoro, inserire qui i comandi SQL per creare una nuova relazione R_CL con schema equivalente a R ma senza vincoli di chiave primaria, secondaria o esterna e con eventuali attributi dummy */

CREATE SCHEMA "UniGeSocialSport_p3";
set search_path to 'UniGeSocialSport_p3';

CREATE TABLE Utente(
	Username varchar (25) not null, --PRIMARY KEY,
	premium boolean not null DEFAULT false,
	genere varchar(1) not null, --check(genere in ('M','F')),
	corso_di_studi varchar (30) NOT NULL,
	cognome varchar (30) not null,
	nome varchar(15) not null,
	foto boolean not null default false,
	telefono decimal (9,0) not null,
	password varchar (20) not null,
	affidabile boolean not null default true,
	matricola decimal (7,0) not null,
	luogoN varchar(25) not null,
	dataN timestamp not null --check(dataN < current_date),
	--UNIQUE (telefono),
	--UNIQUE (matricola)
);

CREATE TABLE Iscrive(
	Username varchar(25) not null,-- REFERENCES Utente(Username),
	ID decimal(5,0) not null,-- REFERENCES Evento(ID),
	Sostituto varchar (25),-- REFERENCES Utente(Username) check (user_not_in_this_event(Sostituto, ID)),
	stato varchar(10),-- check (stato in ('rifiutato','confermato')),
	data timestamp  not null default current_date,
	ruolo varchar(10) not null,-- check (ruolo in ('giocatore','arbitro')),
	ritardo boolean,
	no_show boolean
	--PRIMARY KEY (Username, ID),
	--UNIQUE(Username,ID,Sostituto)
);





/*************************************************************************************************************************************************************************/
--1c. Carico di lavoro
/*************************************************************************************************************************************************************************/ 


/*************************************************************************************************************************************************************************/ 
/* Q1: Query con singola selezione e nessun join */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzione */ 

EXPLAIN ANALYZE SELECT matricola
FROM Utente
WHERE matricola < 1000000

/*************************************************************************************************************************************************************************/ 
/* Q2: Query con condizione di selezione complessa e nessun join */
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzion */ 

EXPLAIN ANALYZE SELECT matricola
FROM Utente
WHERE luogoN = 'Torino' AND matricola < 5000000

/*************************************************************************************************************************************************************************/ 
/* Q3: Query con almeno un join e almeno una condizione di selezione */
/*************************************************************************************************************************************************************************/ 


/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzione */ 

EXPLAIN ANALYZE SELECT DISTINCT u.Username
 FROM Utente u, Iscrive i
WHERE stato= 'confermato' AND u.Username = i.Username

/*************************************************************************************************************************************************************************/
--1e. Schema fisico
/*************************************************************************************************************************************************************************/ 


/* inserire qui i comandi SQL per cancellare tutti gli indici già esistenti per le tabelle coinvolte nel carico di lavoro */
--Non risultano esserci indici
/*
SELECT 'DROP INDEX ' || schemaname || '.' || indexname || ';' AS drop_command
FROM pg_indexes
WHERE tablename = 'Utente';

SELECT schemaname, tablename, indexname
FROM pg_indexes
WHERE tablename = 'Utente';


SELECT 
    schemaname, 
    tablename, 
    indexname, 
    indexdef 
FROM 
    pg_indexes 
WHERE 
    schemaname NOT IN ('pg_catalog', 'information_schema');*/
	
/* inserire qui i comandi SQL per la creazione dello schema fisico della base di dati in accordo al risultato della fase di progettazione fisica per il carico di lavoro. */
	
/*
Per ogni relazione ci saranno diversi indici ma solo 1 potrà essere clusterizzato
*/
DROP INDEX utente_matricola;

DROP INDEX utente_luogon;
DROP INDEX utente_username;

DROP INDEX iscrive_username;
/**********************************************/
-- indice per la 1° Query. (ma anche per la 2°)
CREATE INDEX utente_matricola ON Utente(matricola ASC);
/**********************************************/
-- indice per la 2° Query.
CREATE INDEX utente_luogon
ON Utente
USING HASH (luogoN);
/**********************************************/
-- inidice per la 3° Query
CREATE INDEX utente_Username
ON Utente(Username ASC);

CREATE INDEX iscrive_Username
ON Iscrive(Username ASC);

CLUSTER Utente USING 
utente_matricola;

CLUSTER Iscrive USING 
iscrive_username;

/*************************************************************************************************************************************************************************/ 
--2. Controllo dell'accesso 
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la definizione della politica di controllo dell'accesso della base di dati  (definizione ruoli, gerarchia, definizione utenti, assegnazione privilegi) in modo che, dopo l'esecuzione di questi comandi, 
le operazioni corrispondenti ai privilegi delegati ai ruoli e agli utenti sia correttamente eseguibili. */


set search_path to 'ANSI';

Select *
from information_schema.table_privileges
where table_schema = 'UniGeSocialSport_p';

set search_path to 'UniGeSocialSport_p';

Create role amministratore;
Create role utente_premium;
Create role gestore_impianto;
Create role utente_standard;

CREATE USER u_admin WITH PASSWORD 'password_admin';
CREATE USER u_premium WITH PASSWORD 'password_premium';
CREATE USER u_gestore WITH PASSWORD 'password_gestore';
CREATE USER u_semplice WITH PASSWORD 'password_utente';

GRANT amministratore TO u_admin;
GRANT utente_premium TO u_premium;
GRANT gestore_impianto TO u_gestore;
GRANT utente_semplice TO u_semplice;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO amministratore;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO amministratore;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Torneo, Squadra, Evento TO utente_premium;
GRANT USAGE, SELECT ON SEQUENCE torneo_id_seq, squadra_id_seq, evento_id_seq TO utente_premium;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Impianto, Evento TO gestore_impianto;
GRANT USAGE, SELECT ON SEQUENCE impianto_id_seq, evento_id_seq TO gestore_impianto;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO utente_semplice;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO utente_semplice;

GRANT INSERT, UPDATE, DELETE ON TABLE Partecipazione TO utente_premium;
GRANT INSERT, UPDATE, DELETE ON TABLE Partecipazione TO gestore_impianto;
GRANT INSERT, UPDATE, DELETE ON TABLE Partecipazione TO utente_semplice;

