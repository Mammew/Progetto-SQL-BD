INSERT INTO Utente (Username, premium, genere,corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user123', true,'F','Informatica', 'Rossi', 'Mario', 123456789, 'password123', '123456789', 'Torino', '1990-01-01',true);

INSERT INTO Utente (Username, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('FQ30','M','Matematica statistica', 'Quirolo', 'Federico', 163456789, 'password123', '133756789', 'Genova', '2002-12-30');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('simple2', true,'F','Giurisprudenza', 'Francesca', 'Totti', 128456789, 'password123', '103456789', 'Torino', '1999-01-01');
-- simple non ha mai partecipato a un evento valutare
-- 2. Insert with optional fields set to default
INSERT INTO Utente (Username,premium ,genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user456', true, 'F','Informatica', 'Bianchi', 'Anna', 987654321, 'secure_password', '987654321', 'Milano', '1995-07-14', true);

-- 3. Insert with boolean field set to true
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user789', true,'M','Giurisprudenza', 'Verdi', 'Giuseppe', 222333444, 'pass1234', '222333444', 'Roma', '2000-12-31');

INSERT INTO Categoria VALUES(1,'Basket' ,10, 42,'si gioca 5 Vs 5 regole del Basket FIBA', false);
INSERT INTO Categoria VALUES(2,'Pallavolo' ,12, 60, 'si gioca 6 Vs 6 regole della pallavolo classica', false);
INSERT INTO Categoria VALUES(3,'Tennis singolo', 2, 120, 'si gioca 1 Vs 1 regole del Tennis singolo', false);
INSERT INTO Categoria VALUES(4,'Calcio a 7' ,14, 60,'si gioca 7 Vs 7 regole del Calcio a 7', false);

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
------
INSERT INTO Torneo VALUES ('Roland garros', '25/08/2024','user123' ,'Torneo Tennis su terra rossa');
INSERT INTO Torneo VALUES ('FIVB',' 25/08/2024', 'user789', 'Torneo Pallavolo');
INSERT INTO Torneo VALUES ('Europeo', '1/08/2024', 'user789', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('NBA', '10/07/2024', 'user123', 'Torneo Basket indor');
INSERT INTO Torneo VALUES ('Mondiale', '1/08/2025', 'user789', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('FIBA', '1/08/2025', 'user123', 'Torneo Basket indor');
INSERT INTO Torneo VALUES ('World Volleyball Championship', '01/07/2024', 'user456', 'Campionato mondiale di pallavolo');
INSERT INTO Torneo VALUES ('Wimbledon', '05/07/2024', 'user123', 'Torneo di tennis su erba');
INSERT INTO Torneo VALUES ('Champions League', '10/07/2024', 'user789', 'Torneo di calcio europeo');
INSERT INTO Torneo VALUES ('Euroleague', '15/07/2024', 'user456', 'Torneo di basket europeo');
INSERT INTO Torneo VALUES ('US Open', '25/07/2024', 'user123', 'Torneo di tennis su cemento');
INSERT INTO Torneo VALUES ('Serie A', '30/07/2024', 'user456', 'Campionato di calcio italiano');
INSERT INTO Torneo VALUES ('NBA Finals', '01/08/2024', 'user789', 'Finali del campionato di basket NBA');
INSERT INTO Torneo VALUES ('Olympics', '05/08/2024', 'user456', 'Giochi olimpici di pallavolo');
INSERT INTO Torneo VALUES ('French Open', '10/08/2024', 'user123', 'Torneo di tennis su terra battuta');
---
INSERT INTO Squadra VALUES(1, 'Boston', 'NBA', 'user123', 16, 5, 'verde','aperto');
INSERT INTO Squadra VALUES(2, 'NonTroppoAtletici', 'FIVB', 'user123', 14, 6, 'bianco','aperto');
INSERT INTO Squadra VALUES(3, 'Cardedu', 'Roland garros', 'user789', 1, 1, null,'aperto');
INSERT INTO Squadra VALUES(4, 'SanfruBeach', 'Europeo', 'user456', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(5, 'Boston', 'FIBA', 'user123', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(6, 'SanfruBeach', 'Mondiale', 'user789', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(7, 'Los Angeles', 'NBA', 'user789', 16, 5, 'viola','aperto');
INSERT INTO Squadra VALUES(8, 'Team Italy', 'Mondiale', 'user456', 10, 5, 'azzurro', 'aperto');
INSERT INTO Squadra VALUES(9, 'Team USA', 'Olympics', 'user456', 12, 6, 'bianco', 'aperto');
INSERT INTO Squadra VALUES(10, 'FC Barcelona', 'Champions League', 'user789', 18, 7, 'blaugrana', 'aperto');
INSERT INTO Squadra VALUES(11, 'Real Madrid', 'Champions League', 'user789', 18, 7, 'bianco', 'aperto');
INSERT INTO Squadra VALUES(12, 'VolleyClub Milano', 'Olympics', 'user456', 12, 6, 'blu', 'aperto');
INSERT INTO Squadra VALUES(13, 'Alghero', 'Roland garros', 'user456', 1, 1, null,'aperto');
------

INSERT INTO Candidatura VALUES('user123', 1,'accettato');
INSERT INTO Candidatura VALUES('user123', 3,'accettato');
INSERT INTO Candidatura VALUES('user123', 4,'accettato');
INSERT INTO Candidatura VALUES('user456', 2,'accettato');
INSERT INTO Candidatura VALUES('user456', 3);
INSERT INTO Candidatura VALUES('user456', 4,'rifiutato');
INSERT INTO Candidatura VALUES('user789', 2,'rifiutato');
INSERT INTO Candidatura VALUES ('user123', 2, 'accettato');
INSERT INTO Candidatura VALUES ('user123', 5, 'accettato');
INSERT INTO Candidatura VALUES ('user789', 4, 'rifiutato');

INSERT INTO Restrizioni VALUES (1, 'Torneo solamente per altleti non tesserati');
INSERT INTO Restrizioni VALUES (2, 'Torneo solamente per femmine ');
INSERT INTO Restrizioni VALUES (3, 'Torneo solamente per maschi ');
INSERT INTO Restrizioni VALUES (4, 'Torneo solamente per atleti over 25');

INSERT INTO RestrizioniTorneo VALUES(1, 'NBA');

INSERT INTO RestrizioniTorneo VALUES(1,'Europeo');

INSERT INTO Premio VALUES (1, 'Trofeo al vincitore del Torneo');
INSERT INTO Premio VALUES (2, 'Trofeo al secondo classificato del Torneo');
INSERT INTO Premio VALUES (3, 'Trofeo al terzo classificato del Torneo');
INSERT INTO Premio VALUES (4, 'Medaglia ai partecipanti delle fasi finali del Torneo');

INSERT INTO PremioTorneo VALUES(1,'NBA');
INSERT INTO PremioTorneo VALUES(2,'NBA');

INSERT INTO PremioTorneo VALUES(1,'Europeo');
INSERT INTO PremioTorneo VALUES(2,'Europeo');
INSERT INTO PremioTorneo VALUES(3,'Europeo');

INSERT INTO PremioTorneo VALUES (1, 'Champions League');
INSERT INTO PremioTorneo VALUES (2, 'Champions League');
INSERT INTO PremioTorneo VALUES (3, 'Champions League');

INSERT INTO PremioTorneo VALUES (1, 'Euroleague');
INSERT INTO PremioTorneo VALUES (2, 'Euroleague');
INSERT INTO PremioTorneo VALUES (3, 'Euroleague');

INSERT INTO PremioTorneo VALUES (1, 'Olympics');
INSERT INTO PremioTorneo VALUES (2, 'Olympics');
INSERT INTO PremioTorneo VALUES (3, 'Olympics');

INSERT INTO Sponsor VALUES(1,'TIM');
INSERT INTO Sponsor VALUES(2,'Strike');
INSERT INTO Sponsor VALUES(3,'Regione Liguria');
INSERT INTO Sponsor VALUES(4,'Università degli studi di Genova');

INSERT INTO SponsorTorneo VALUES(1,'NBA');
INSERT INTO SponsorTorneo VALUES(3,'NBA');

INSERT INTO SponsorTorneo VALUES(1,'Europeo');
INSERT INTO SponsorTorneo VALUES(4,'Europeo');

INSERT INTO SponsorTorneo VALUES (2, 'Champions League');
INSERT INTO SponsorTorneo VALUES (3, 'Champions League');

INSERT INTO SponsorTorneo VALUES (4, 'Mondiale');
INSERT INTO SponsorTorneo VALUES (1, 'Mondiale');

INSERT INTO SponsorTorneo VALUES (2, 'Olympics');
INSERT INTO SponsorTorneo VALUES (3, 'Olympics');

------
INSERT INTO Impianto VALUES('calcio Gambaro','viale gambaro',123456789,'calciog@gmail.com');
INSERT INTO Impianto VALUES('tennis Puggia','valletta puggia',222222222,'tennisp@gmail.com');
INSERT INTO Impianto VALUES('basket Puggia','valletta puggia',223344556,'basketp@gmail.com');
INSERT INTO Impianto VALUES('pallavolo Puggia','valletta puggia',998866523,'pallavolop@gmail.com');

INSERT INTO Evento VALUES (0, '20/06/2000', '20/06/1999', 'false' , 1, null, 'basket Puggia', 'user123');

INSERT INTO Evento VALUES (1, '22/06/2024', '20/06/2024', 'false' , 1, null, 'basket Puggia', 'user123');
INSERT INTO Evento VALUES (2, '22/06/2024', '21/06/2024', 'TRUE' , 3, 'Roland garros', 'tennis Puggia', 'user123');
INSERT INTO Evento VALUES (3, '23/06/2024', '22/06/2024', 'false' , 2, 'FIVB', 'pallavolo Puggia', 'user789');
INSERT INTO Evento VALUES (4, '24/06/2024', '22/06/2024', 'false' , 4, 'Mondiale', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (5, '30/06/2024', '22/06/2024', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (6, '29/06/2024', '22/06/2024', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (7, '01/07/2024', '30/06/2024', 'true', 2, 'World Volleyball Championship', 'pallavolo Puggia', 'user456');
-->INSERT INTO Evento VALUES (8, '05/07/2024', '04/07/2024', 'false', 3, 'Wimbledon', 'tennis Puggia', 'user123');
INSERT INTO Evento VALUES (9, '10/07/2024', '09/07/2024', 'true', 4, 'Champions League', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (10, '15/07/2024', '14/07/2024', 'false', 1, 'Euroleague', 'basket Puggia', 'user456');
INSERT INTO Evento VALUES (11, '20/07/2024', '19/07/2024', 'true', 2, 'FIVB', 'pallavolo Puggia', 'user789');
--> INSERT INTO Evento VALUES (12, '25/07/2024', '24/07/2024', 'false', 3, 'US Open', 'tennis Puggia', 'user123');
--> INSERT INTO Evento VALUES (13, '30/07/2024', '29/07/2024', 'true', 4, 'Serie A', 'calcio Gambaro', 'user456');
-->INSERT INTO Evento VALUES (14, '01/08/2024', '31/07/2024', 'false', 1, 'NBA Finals', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (15, '05/08/2024', '04/08/2024', 'true', 2, 'Olympics', 'pallavolo Puggia', 'user456');
INSERT INTO Evento VALUES (16, '10/08/2024', '09/08/2024', 'false', 4, 'Mondiale', 'calcio Gambaro', 'user789');
------
--Partecipazione di Boston (Squadra_ID = 1) all evento NBA (Evento_ID = 5)
INSERT INTO Partecipa VALUES (1, 5, 85);

-- Partecipazione di Los Angeles (Squadra_ID = 7) all'evento NBA (Evento_ID = 5)
INSERT INTO Partecipa VALUES (7, 5, 72);

-- Partecipazione di Cardedu (Squadra_ID = 3) all'evento Roland Garros (Evento_ID = 2)
INSERT INTO Partecipa VALUES (3, 2, 3);

-- Partecipazione di Cardedu (Squadra_ID = 3) all'evento Roland Garros (Evento_ID = 2)
INSERT INTO Partecipa VALUES (13, 2, 2);

-- Partecipazione di SanfruBeach Mondiale (Squadra_ID = 6) all'evento Mondiale (Evento_ID = 4)
 INSERT INTO Partecipa VALUES (6, 4, 1);

 -- Partecipazione di Team Italy (Squadra_ID = 8) all'evento Mondiale  (Evento_ID = 4)
INSERT INTO Partecipa VALUES (8, 4, 2);

-- Partecipazione di Boston (Squadra_ID = 5) all'evento fiba (Evento_ID = 4)
--> INSERT INTO Partecipa VALUES (5, 4, 82); FIBA NON HA EVENTI

-- Partecipazione di Los Angeles (Squadra_ID = 7) all'evento NBA (Evento_ID = 6)
INSERT INTO Partecipa VALUES (7, 6, 35);

-- Partecipazione di Bostom (Squadra_ID = 1) all'evento NBA (Evento_ID = 6)
INSERT INTO Partecipa VALUES (1, 6, 78);

-- Partecipazione di Team USA (Squadra_ID = 9) all'evento Olympics (Evento_ID = 8)
INSERT INTO Partecipa VALUES (9, 15, 75);

-- Partecipazione di VolleyClub Milano (Squadra_ID = 12)  all'evento Olympics (Evento_ID = 8)
INSERT INTO Partecipa VALUES (12, 15, 82);

-- Partecipazione di FC Barcelona (Squadra_ID = 10) all'evento Champions League (Evento_ID = 9)
INSERT INTO Partecipa VALUES (10, 9, 4);

-- Partecipazione di Real Madrid (Squadra_ID = 11) all'evento Champions League (Evento_ID = 10)
INSERT INTO Partecipa VALUES (11, 9, 2);
------
INSERT INTO Prestazione VALUES();
INSERT INTO Prestazione VALUES('user123',1,'user456', 7);
INSERT INTO Prestazione VALUES('user123',1,'user789', 8);
INSERT INTO Prestazione VALUES('user456',5,'user123', 8);
INSERT INTO Prestazione VALUES('user456',5,'user789', 7);
INSERT INTO Prestazione VALUES('user789',2,'user123', 6);
INSERT INTO Prestazione VALUES('user789',2,'user456', 7);
INSERT INTO Prestazione VALUES('user789',1,'user456', 7);
INSERT INTO Prestazione VALUES('user789',1,'user123', 5);

--INSERT nella tabella potranno essere effettuate solamente in data posteriore all'Evento a cui si fa riferimento
-- Implementabile t
INSERT INTO Punti_segnati VALUES ('user123',5,1);
INSERT INTO Punti_segnati VALUES ('user456',5,1);
INSERT INTO Punti_segnati VALUES ('user789',5,1);
INSERT INTO Punti_segnati VALUES ();
INSERT INTO Punti_segnati VALUES ();
------
INSERT INTO Iscrive VALUES ('user123',0,null,'confermato','12/06/1999','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',0,null,'confermato','10/06/1999','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',0,null,'confermato','28/06/1999','giocatore',null,null);

INSERT INTO Iscrive VALUES ('FQ30',1,null,'confermato',current_date,'giocatore',null,null);

