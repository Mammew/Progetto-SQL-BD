--- Progetto BD 23-24 (12 CFU)
--- Team 26
--- Elena Deidda 5448731
---	Marco Mammoliti 5564736
---	Filippo Pedullà 5575626


--- PARTE III 
/* il file deve essere file SQL ... cioè formato solo testo e apribili ed eseguibili in pgAdmin */



/*************************************************************************************************************************************************************************/ 
--1b. Schema per popolamento in the large
/*************************************************************************************************************************************************************************/ 


/* per ogni relazione R coinvolta nel carico di lavoro, inserire qui i comandi SQL per creare una nuova relazione R_CL con schema equivalente a R ma senza vincoli di chiave primaria, secondaria o esterna e con eventuali attributi dummy */

CREATE SCHEMA "UniGeSocialSport_p3";
set search_path to 'UniGeSocialSport_p3';

CREATE TABLE Utente(
	Username varchar (25) not null PRIMARY KEY,
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
	dataN timestamp not null , --check(dataN < current_date),
	UNIQUE (telefono),
	UNIQUE (matricola)
);

CREATE TABLE Iscrive(
	Username varchar(25) not null REFERENCES Utente(Username),
	ID decimal(5,0) not null,-- REFERENCES Evento(ID),
	Sostituto varchar (25) REFERENCES Utente(Username),-- check (user_not_in_this_event(Sostituto, ID)),
	stato varchar(10), --check (stato in ('rifiutato','confermato')),
	data timestamp  not null default current_date,
	ruolo varchar(10) not null ,--check (ruolo in ('giocatore','arbitro')),
	ritardo boolean,
	no_show boolean,
	PRIMARY KEY (Username, ID),
	UNIQUE(Username,ID,Sostituto)
);

CREATE TABLE Utente_CL AS
Select *
from Utente
WITH DATA;

CREATE TABLE Iscrive_CL AS
Select *
from Iscrive
WITH DATA;


/*************************************************************************************************************************************************************************/
--1c. Carico di lavoro
/*************************************************************************************************************************************************************************/ 


/*************************************************************************************************************************************************************************/ 
/* Q1: Query con singola selezione e nessun join */
/*************************************************************************************************************************************************************************/ 


/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzione */ 

EXPLAIN ANALYZE SELECT matricola
FROM Utente_CL
WHERE matricola < 1000000


/*************************************************************************************************************************************************************************/ 
/* Q2: Query con condizione di selezione complessa e nessun join */
/*************************************************************************************************************************************************************************/ 


/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzion */ 
-- Forse un indice sul luogo potrebbe creare

EXPLAIN ANALYZE SELECT matricola
FROM Utente_CL
WHERE luogoN = 'Mumbai' AND matricola < 5000000

/*************************************************************************************************************************************************************************/ 
/* Q3: Query con almeno un join e almeno una condizione di selezione */
/*************************************************************************************************************************************************************************/ 


/* inserire qui i comandi SQL per la creazione della query, in modo da visualizzarne piane di esecuzione e tempi di esecuzione */ 

EXPLAIN ANALYZE SELECT DISTINCT u.Username
FROM Utente_CL u, Iscrive_CL i
WHERE stato = 'confermato' and u.Username = i.Username AND telefono > 900000000;

EXPLAIN ANALYZE Select u.nome, u.cognome
from Utente_CL u, Iscrive_CL i
where ruolo = 'giocatore' and u.Username = i.Username;

/*************************************************************************************************************************************************************************/
--1e. Schema fisico
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per cancellare tutti gli indici già esistenti per le tabelle coinvolte nel carico di lavoro */

			/**** Abbiamo creato le tabelle R_CL in modo da non avere indici creati in precedenza da Postgres. ****/

/* inserire qui i comandi SQL perla creazione dello schema fisico della base di dati in accordo al risultato della fase di progettazione fisica per il carico di lavoro. */

CREATE INDEX utente_matricola 
ON Utente_CL(matricola ASC);

CREATE INDEX utente_luogon_matricola
ON Utente_CL(matricola,luogoN);

CREATE INDEX utente_Username
ON Utente_CL(Username ASC);

CREATE INDEX iscrive_Username
ON Iscrive_CL(Username ASC);

CREATE INDEX utente_telefono
ON Utente_CL(telefono)

CLUSTER Utente_CL USING 
utente_Username;

CLUSTER Iscrive_CL USING 
iscrive_Username;

drop INDEX  iscrive_Username;

drop index utente_Username;
drop index utente_matricola;


/*************************************************************************************************************************************************************************/ 
--2. Controllo dell'accesso 
/*************************************************************************************************************************************************************************/ 

/* inserire qui i comandi SQL per la definizione della politica di controllo dell'accesso della base di dati  (definizione ruoli, gerarchia, definizione utenti, assegnazione privilegi) in modo che, dopo l'esecuzione di questi comandi, 
le operazioni corrispondenti ai privilegi delegati ai ruoli e agli utenti sia correttamente eseguibili. */

set search_path to 'UniGeSocialSport_p';

Create role amministratore;
Create role utente_premium;
Create role gestore_impianto;
Create role utente_semplice;

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

GRANT INSERT, UPDATE, DELETE ON TABLE Torneo, Squadra, Evento, Note TO utente_premium;
GRANT INSERT, UPDATE ON TABLE Partecipa, Restrizioni, RestrizioniTorneo, Sponsor, SponsorTorneo, Premio, PremioTorneo, Punti_Segnati,  TO utente_premium;
GRANT UPDATE ON TABLE Candidatura, Iscrive TO utente_premium;

GRANT INSERT, UPDATE ON TABLE Impianto TO gestore_impianto;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO utente_semplice;
GRANT INSERT ON TABLE Iscrive, Candidatura, Prestazione TO utente_semplice;

-- Definizione della gerarchia tra i ruoli
-- l'amministratore possedendo tutti i permessi non è stato messo in gerarchia perchè non ha nessun permesso da ereditare
GRANT utente_semplice TO utente_premium;
GRANT utente_semplice TO gestore_impianto;






