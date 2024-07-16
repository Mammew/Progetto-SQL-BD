set search_path to 'UniGeSocialSport';

INSERT INTO Utente (Username, premium, genere,corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user123', true,'M','Informatica', 'Rossi', 'Mario', 123456789, 'password123', 1234567, 'Torino', '1990-01-01',true);

--FQ30 utente che è sempre stato rifiutato
INSERT INTO Utente (Username, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('FQ30','M','Matematica statistica', 'Queirolo', 'Federico', 163456789, 'password123', 1337567, 'Genova', '2002-12-30');

-- simple non ha mai partecipato a un evento non può valutare ( è stato rifiutato)
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('simple2', true,'F','Giurisprudenza', 'Francesca', 'Totti', 128456789, 'password123', 1034567, 'Torino', '1999-01-01');


-- 2. Insert with optional fields set to default
INSERT INTO Utente (Username,premium ,genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user456', true, 'M','Informatica', 'Bianchi', 'Anna', 987654321, 'secure_password', 9876543, 'Milano', '1995-07-14', true);

-- 3. Insert with boolean field set to true
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user789', true,'M','Giurisprudenza', 'Verdi', 'Giuseppe', 222333444, 'pass1234', 2223334, 'Roma', '2000-12-31');

--- CHAT
--- tutti dovrebbero avere il campo affidabile perchè l'utente premium vede quel campo su tutti da controllare

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user001', false, 'M', 'Economia', 'Rossi', 'Luigi', 333222111, 'password001', 1010101, 'Napoli', '1992-03-15', true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user002', true, 'M', 'Ingegneria', 'Bianchi', 'Stefano', 444555666, 'password002', 2020202, 'Firenze', '1994-08-21');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user003', false, 'M', 'Fisica', 'Verdi', 'Marco', 555663777, 'password003', 3030303, 'Bologna', '1991-11-05');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user004', true, 'M', 'Chimica', 'Gialli', 'Filippo', 666747888, 'password004', 4040404, 'Palermo', '1993-02-19');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user005', false, 'M', 'Biologia', 'Neri', 'Franco', 977888999, 'password005', 5050505, 'Venezia', '1995-05-30');

--- altri sette utenti maschi

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user006', true, 'M', 'Matematica', 'Ferrari', 'Andrea', 888999000, 'password006', 6060606, 'Roma', '1990-04-12', true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user007', false, 'M', 'Informatica', 'Rossi', 'Alberto', 959000111, 'password007', 7070707, 'Milano', '1992-07-18');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user008', true, 'M', 'Storia', 'Bianchi', 'Davide', 111222333, 'password008', 8080808, 'Torino', '1994-10-02');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user009', false, 'M', 'Filosofia', 'Verdi', 'Giorgio', 222933444, 'password009', 9090909, 'Firenze', '1996-01-25');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user010', true, 'M', 'Lettere', 'Neri', 'Paolo', 333444555, 'password010', 1010201, 'Bologna', '1991-12-15');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user011', false, 'M', 'Scienze Politiche', 'Gialli', 'Luca', 404555666, 'password011', 1111111, 'Napoli', '1993-03-05');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user012', true, 'M', 'Economia', 'Blu', 'Matteo', 855666777, 'password012', 1212128, 'Palermo', '1995-06-23');

--- altri 2 utenti maschi bonus
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user025', false, 'M', 'Ingegneria Civile', 'Ferrari', 'Luca', 999000111, 'password025', 2525252, 'Firenze', '1993-04-20', true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user026', true, 'M', 'Medicina', 'Moretti', 'Andrea', 911222333, 'password026', 2626262, 'Napoli', '1995-12-12');


--- 6 utenti donne
INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user013', true, 'F', 'Chimica', 'Marini', 'Chiara', 666777838, 'password013', 1313131, 'Venezia', '1990-05-14', true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user014', false, 'F', 'Chimica', 'Ricci', 'Sofia', 177888999, 'password014', 1414141, 'Genova', '1992-08-22');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user015', true, 'F', 'Fisica', 'Esposito', 'Giulia', 818999000, 'password015', 1515151, 'Roma', '1994-11-09');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user016', false, 'F', 'Medicina', 'Conti', 'Martina', 199000111, 'password016', 1616161, 'Napoli', '1996-02-28');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user017', true, 'F', 'Farmacia', 'Moretti', 'Valentina', 115222333, 'password017', 1717171, 'Milano', '1991-09-17');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user018', false, 'F', 'Ingegneria', 'Barbieri', 'Elena', 222336444, 'password018', 1818181, 'Firenze', '1993-12-21');

--- 6 utenti donne

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user019', true, 'F', 'Architettura', 'Greco', 'Federica', 339444555, 'password019', 1919191, 'Bologna', '1995-04-07');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN, affidabile)
VALUES ('user020', true, 'F', 'Psicologia', 'Bianchi', 'Laura', 434555666, 'password020', 2050202, 'Pisa', '1990-03-25', true);

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user021', false, 'F', 'Scienze Politiche', 'Rossi', 'Alessia', 555666777, 'password021', 2121212, 'Palermo', '1992-07-15');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user022', true, 'F', 'Economia', 'Gallo', 'Sara', 666777888, 'password022', 2222222, 'Cagliari', '1994-11-30');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user023', false, 'F', 'Lettere', 'Fontana', 'Elisa', 777888999, 'password023', 2323232, 'Ancona', '1996-02-10');

INSERT INTO Utente (Username, premium, genere, corso_di_studi, cognome, nome, telefono, password, matricola, luogoN, dataN)
VALUES ('user024', true, 'F', 'Giurisprudenza', 'Conti', 'Beatrice', 788999000, 'password024', 2424242, 'Trento', '1998-09-05');


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
INSERT INTO Torneo VALUES ('Roland garros', '25/08/2023','user123' ,'Torneo Tennis su terra rossa');
INSERT INTO Torneo VALUES ('FIVB',' 25/08/2024', 'user789', 'Torneo Pallavolo');
INSERT INTO Torneo VALUES ('Europeo', '1/08/2024', 'user789', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('NBA', '10/05/2024', 'user123', 'Torneo Basket indor');
INSERT INTO Torneo VALUES ('Mondiale', '1/05/2023', 'user789', 'Torneo Calcio a 7');
INSERT INTO Torneo VALUES ('FIBA', '1/08/2025', 'user123', 'Torneo Basket indor');
INSERT INTO Torneo VALUES ('World Volleyball Championship', '02/10/2024', 'user456', 'Campionato mondiale di pallavolo');
INSERT INTO Torneo VALUES ('Wimbledon', '05/07/2024', 'user123', 'Torneo di tennis su erba');
INSERT INTO Torneo VALUES ('Champions League', '10/07/2024', 'user789', 'Torneo di calcio europeo');
INSERT INTO Torneo VALUES ('Euroleague', '15/07/2024', 'user456', 'Torneo di basket europeo');
INSERT INTO Torneo VALUES ('US Open', '25/07/2025', 'user123', 'Torneo di tennis su cemento');
INSERT INTO Torneo VALUES ('Serie A', '30/07/2024', 'user456', 'Campionato di calcio italiano');
INSERT INTO Torneo VALUES ('NBA Finals', '01/08/2024', 'user789', 'Finali del campionato di basket NBA');
INSERT INTO Torneo VALUES ('Olympics', '10/06/2024', 'user456', 'Giochi olimpici di pallavolo');
INSERT INTO Torneo VALUES ('French Open', '10/08/2024', 'user123', 'Torneo di tennis su terra battuta');
---
INSERT INTO Squadra VALUES(1, 'Boston', 'NBA', 'user123', 16, 5, 'verde','aperto');
-- iscritta a un evento spot
INSERT INTO Squadra VALUES(2, 'NonTroppoAtletici',null,'user123', 12, 6, 'bianco','aperto');
INSERT INTO Squadra VALUES(3, 'Cardedu', 'Roland garros', 'user789', 1, 1, null,'aperto');
-- squadra 4 aperta per candidature non ancora iscritta a nessun evento
INSERT INTO Squadra VALUES(4, 'SanfruBeach', 'US Open', 'user456', 1, 1, null,'aperto');
-- squadra 5 aperta per candidature non ancora iscritta a nessun evento
INSERT INTO Squadra VALUES(5, 'Boston', 'FIBA', 'user123', 26, 11, 'rosso','aperto');
-- squadra 6 aperta per candidature non ancora iscritta a nessun evento
INSERT INTO Squadra VALUES(6, 'SanfruBeach', 'Mondiale', 'user789', 26, 11, 'rosso','aperto');
INSERT INTO Squadra VALUES(7, 'Los Angeles', 'NBA', 'user789', 16, 5, 'viola','aperto');
INSERT INTO Squadra VALUES(8, 'Team Italy', 'Mondiale', 'user456', 10, 5, 'azzurro', 'aperto');
INSERT INTO Squadra VALUES(9, 'Team USA', 'Olympics', 'user456', 12, 6, 'bianco', 'aperto');
INSERT INTO Squadra VALUES(10, 'FC Barcelona', 'Champions League', 'user789', 18, 7, 'blaugrana', 'aperto');
INSERT INTO Squadra VALUES(11, 'Real Madrid', 'Champions League', 'user789', 18, 7, 'bianco', 'aperto');
INSERT INTO Squadra VALUES(12, 'VolleyClub Milano', 'Olympics', 'user456', 12, 6, 'blu', 'aperto');
INSERT INTO Squadra VALUES(13, 'Alghero', 'Roland garros', 'user456', 1, 1, null,'aperto');
INSERT INTO Squadra VALUES(14, 'VolleyClub Genova', null, 'user456', 12, 6, 'blu', 'aperto');
------

-- Squadra 1 gioca NBA minimo giocatori 7
--- le squadre devono essere tutte al maschile o tutte al femminile 
--- devo creare più utenti
-- questi utenti sonon tutti maschi
INSERT INTO Candidatura VALUES('user123', 1,'accettato');
INSERT INTO Candidatura VALUES('user456', 1,'accettato');
INSERT INTO Candidatura VALUES('user789', 1,'accettato');
INSERT INTO Candidatura VALUES('user001', 1,'accettato');
INSERT INTO Candidatura VALUES('user002', 1,'accettato');
INSERT INTO Candidatura VALUES('user003', 1,'accettato');
INSERT INTO Candidatura VALUES('user004', 1,'accettato');


INSERT INTO Candidatura VALUES('FQ30', 1,'rifiutato');

--- squadra 7 gioca sempre a NBA
INSERT INTO Candidatura VALUES('user006', 7,'accettato');
INSERT INTO Candidatura VALUES('user007', 7,'accettato');
INSERT INTO Candidatura VALUES('user008', 7,'accettato');
INSERT INTO Candidatura VALUES('user009', 7,'accettato');
INSERT INTO Candidatura VALUES('user010', 7,'accettato');
INSERT INTO Candidatura VALUES('user011', 7,'accettato');
INSERT INTO Candidatura VALUES('user012', 7,'accettato');

INSERT INTO Candidatura VALUES('FQ30', 7,'rifiutato');
INSERT INTO Candidatura VALUES('simple2', 7,'rifiutato');

-- Squadre 3 e 13 roland garros
INSERT INTO Candidatura VALUES('user123', 3,'accettato');
INSERT INTO Candidatura VALUES('FQ30' , 13,'accettato');


-- Squadra 6 gioca a calcio Mondiale
INSERT INTO Candidatura VALUES('user123', 6,'accettato');
INSERT INTO Candidatura VALUES('user456', 6,'accettato');
INSERT INTO Candidatura VALUES('user789', 6,'accettato');
INSERT INTO Candidatura VALUES('user001', 6,'accettato');
INSERT INTO Candidatura VALUES('user002', 6,'accettato');
INSERT INTO Candidatura VALUES('user003', 6,'accettato');
INSERT INTO Candidatura VALUES('user004', 6,'accettato');

--Squadra 8 gioca a calcio Mondiale
INSERT INTO Candidatura VALUES('user006', 8,'accettato');
INSERT INTO Candidatura VALUES('user007', 8,'accettato');
INSERT INTO Candidatura VALUES('user008', 8,'accettato');
INSERT INTO Candidatura VALUES('user009', 8,'accettato');
INSERT INTO Candidatura VALUES('user010', 8,'accettato');
INSERT INTO Candidatura VALUES('user011', 8,'accettato');
INSERT INTO Candidatura VALUES('user012', 8,'accettato');

--Squadra 9 gioca a Olympics 6 giocatrici
INSERT INTO Candidatura VALUES('user013', 9,'accettato');
INSERT INTO Candidatura VALUES('user014', 9,'accettato');
INSERT INTO Candidatura VALUES('user015', 9,'accettato');
INSERT INTO Candidatura VALUES('user016', 9,'accettato');
INSERT INTO Candidatura VALUES('user017', 9,'accettato');
INSERT INTO Candidatura VALUES('user018', 9,'accettato');

-- Squadra 12 gioca agli Olympics 6 giocatrici
INSERT INTO Candidatura VALUES('user019', 12,'accettato');
INSERT INTO Candidatura VALUES('user020', 12,'accettato');
INSERT INTO Candidatura VALUES('user021', 12,'accettato');
INSERT INTO Candidatura VALUES('user022', 12,'accettato');
INSERT INTO Candidatura VALUES('user023', 12,'accettato');
INSERT INTO Candidatura VALUES('user024', 12,'accettato');

-- Squadra 10 gioca a calcio Champions League
INSERT INTO Candidatura VALUES('user123', 10,'accettato');
INSERT INTO Candidatura VALUES('user456', 10,'accettato');
INSERT INTO Candidatura VALUES('user789', 10,'accettato');
INSERT INTO Candidatura VALUES('user001', 10,'accettato');
INSERT INTO Candidatura VALUES('user002', 10,'accettato');
INSERT INTO Candidatura VALUES('user003', 10,'accettato');
INSERT INTO Candidatura VALUES('user025', 10,'accettato');

--Squadra 11 gioca a calcio Champions League
INSERT INTO Candidatura VALUES('user006', 11,'accettato');
INSERT INTO Candidatura VALUES('user007', 11,'accettato');
INSERT INTO Candidatura VALUES('user008', 11,'accettato');
INSERT INTO Candidatura VALUES('user009', 11,'accettato');
INSERT INTO Candidatura VALUES('user010', 11,'accettato');
INSERT INTO Candidatura VALUES('user011', 11,'accettato');
INSERT INTO Candidatura VALUES('user026', 11,'accettato');

-- ultime due squadre non hanno nessuno contro cui giocare nel torneo da gestire

--Squadra 2  pallavolo maschi evento spot
INSERT INTO Candidatura VALUES('user123', 2,'accettato');
INSERT INTO Candidatura VALUES('user008', 2,'accettato');
INSERT INTO Candidatura VALUES('user456', 2,'accettato');
INSERT INTO Candidatura VALUES('user001', 2,'accettato');
INSERT INTO Candidatura VALUES('user002', 2,'accettato');
INSERT INTO Candidatura VALUES('user003', 2,'accettato');

-- Squadra 14 pallavolo machi spot
INSERT INTO Candidatura VALUES('user004', 14,'accettato');
INSERT INTO Candidatura VALUES('user005', 14,'accettato');
INSERT INTO Candidatura VALUES('user006', 14,'accettato');
INSERT INTO Candidatura VALUES('user007', 14,'accettato');
INSERT INTO Candidatura VALUES('user009', 14,'accettato');
INSERT INTO Candidatura VALUES('user010', 14,'accettato');


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

----
INSERT INTO Evento VALUES (1, '22/06/2024 13:00:00', '20/06/2024 11:00:00', 'false' , 1, null, 'basket Puggia', 'user123');
INSERT INTO Evento VALUES (2, '22/06/2024 14:00:00', '21/06/2024 11:00:00', 'TRUE' , 3, 'Roland garros', 'tennis Puggia', 'user123');
INSERT INTO Evento VALUES (3, '23/06/2024 16:00:00', '22/06/2024 11:00:00', 'false' , 2, 'FIVB', 'pallavolo Puggia', 'user789');
INSERT INTO Evento VALUES (4, '24/06/2024 17:00:00', '22/06/2024 11:00:00', 'false' , 4, 'Mondiale', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (5, '30/06/2024 11:00:00', '22/06/2024 11:00:00', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (6, '29/06/2024 12:00:00', '22/06/2024 11:00:00', 'false' , 1, 'NBA', 'basket Puggia', 'user789');
INSERT INTO Evento VALUES (7, '01/07/2024 19:00:00', '30/06/2024 11:00:00', 'true', 2, 'World Volleyball Championship', 'pallavolo Puggia', 'user456');

--EVENTO CHE CHIUDO PERCHè NON è ARRIVATO AL NUMERO MINIMO DI PARTECIPANTI
INSERT INTO Evento VALUES (8, '05/04/2024', '03/04/2024', 'false', 3, 'Wimbledon', 'tennis Puggia', 'user123');

INSERT INTO Evento VALUES (9, '15/07/2024 15:00:00', '13/07/2024 11:00:00', 'true', 4, 'Champions League', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (10, '15/07/2024 18:00:00', '14/07/2024 11:00:00', 'false', 1, 'Euroleague', 'basket Puggia', 'user456');
INSERT INTO Evento VALUES (11, '20/07/2024 20:00:00', '19/07/2024 11:00:00', 'true', 2, 'FIVB', 'pallavolo Puggia', 'user789');

INSERT INTO Evento VALUES (15, '10/08/2025 18:00:00', '08/08/2025 11:00:00', 'true', 2, 'Olympics', 'pallavolo Puggia', 'user456');
INSERT INTO Evento VALUES (16, '15/08/2024 15:00:00', '13/08/2024 11:00:00', 'false', 4, 'Mondiale', 'calcio Gambaro', 'user789');
INSERT INTO Evento VALUES (17, '30/07/2025 18:00:00', '28/07/2025 11:00:00', 'TRUE' , 3, 'US Open', 'tennis Puggia', 'user123');
---- No Squadre in questo Evento
INSERT INTO Evento VALUES (19, '30/07/2025 18:00:00', '25/07/2025 11:00:00', 'false' , 3, 'US Open', 'tennis Puggia', 'user123');
-- Eventi per far partecipare a tutte le categorie l'Utente 'user123'
INSERT INTO Evento VALUES (21, '20/06/2024 13:00:00', '18/06/2024 11:00:00', 'false' , 2, null, 'pallavolo Puggia', 'user123');
-- Inserimento di un Evento in un Impianto occupato nell'ora del nuovo Evento attivazione Trigger trova nuovo Impianto
INSERT INTO Evento VALUES (20, '30/07/2025 18:00:00', '25/07/2025 11:00:00', 'false' , 3, 'US Open', 'tennis Puggia', 'user123');

--PARTECIPAZIONI
--Partecipazione di Boston (Squadra_ID = 1) all evento NBA (Evento_ID = 5)
INSERT INTO Partecipa VALUES (1, 5, 85);

-- Partecipazione di Los Angeles (Squadra_ID = 7) all'evento NBA (Evento_ID = 5)
INSERT INTO Partecipa VALUES (7, 5, 72);

-- Partecipazione di Cardedu (Squadra_ID = 3) all'evento Roland Garros (Evento_ID = 2)
INSERT INTO Partecipa VALUES (3, 2, 3);

-- Partecipazione di Cardedu (Squadra_ID = 13) all'evento Roland Garros (Evento_ID = 2)
INSERT INTO Partecipa VALUES (13, 2, 2);

-- Partecipazione di SanfruBeach Mondiale (Squadra_ID = 6) all'evento Mondiale (Evento_ID = 4)
 INSERT INTO Partecipa VALUES (6, 4, 1);

 -- Partecipazione di Team Italy (Squadra_ID = 8) all'evento Mondiale  (Evento_ID = 4)
INSERT INTO Partecipa VALUES (8, 4, 2);

-- Partecipazione di Los Angeles (Squadra_ID = 7) all'evento NBA (Evento_ID = 6)
INSERT INTO Partecipa VALUES (7, 6, 35);

-- Partecipazione di Bostom (Squadra_ID = 1) all'evento NBA (Evento_ID = 6)
INSERT INTO Partecipa VALUES (1, 6, 78);

-- Partecipazione di Team USA (Squadra_ID = 9) all'evento Olympics (Evento_ID = 15)
INSERT INTO Partecipa VALUES (9, 15, 75);

-- Partecipazione di VolleyClub Milano (Squadra_ID = 12)  all'evento Olympics (Evento_ID = 15)
INSERT INTO Partecipa VALUES (12, 15, 82);

-- Partecipazione di FC Barcelona (Squadra_ID = 10) all'evento Champions League (Evento_ID = 9)
INSERT INTO Partecipa VALUES (10, 9, 4);

-- Partecipazione di Real Madrid (Squadra_ID = 11) all'evento Champions League (Evento_ID = 9)
INSERT INTO Partecipa VALUES (11, 9, 2);

-- eventi per avere l'utente che partecipa a tutte le categore
INSERT INTO Partecipa VALUES (2, 21, 67); -- Insert della Squadra NonTroppoAtletici (FIVB) all' evento 21 spot
INSERT INTO Partecipa VALUES (14, 21, 60); -- evento 21 di pallavolo

/***********************************************************************************************************************/
--INSERT INTO Prestazione VALUES();
INSERT INTO Prestazione VALUES('user123',4,'user456', 7);
INSERT INTO Prestazione VALUES('user123',4,'user789', 8);
INSERT INTO Prestazione VALUES('user456',4,'user123', 8);
INSERT INTO Prestazione VALUES('user456',4,'user789', 7);
INSERT INTO Prestazione VALUES('user789',4,'user123', 6);
INSERT INTO Prestazione VALUES('user789',4,'user456', 7);
INSERT INTO Prestazione VALUES('user006',4,'user008', 5);
INSERT INTO Prestazione VALUES('user009',4,'user123', 6);
INSERT INTO Prestazione VALUES('user010',4,'user456', 7);
INSERT INTO Prestazione VALUES('user011',4,'user456', 7);
INSERT INTO Prestazione VALUES('user012',4,'user123', 5);

--INSERT nella tabella potranno essere effettuate solamente in data posteriore all'Evento a cui si fa riferimento
-- Implementabile t
INSERT INTO Punti_segnati VALUES ('user123',4,1);
INSERT INTO Punti_segnati VALUES ('user006',4,1);
INSERT INTO Punti_segnati VALUES ('user007',4,1);


------ iscrivo tutti gli utenti delle Squadre agli eventi
-- Dato che l'inseriemento delle tuple in Iscrive per gli Utenti, facenti parte di una Squadra di un Torneo è automatico avverrà tramite 
-- routine alla stessa ora nel giorno della data_Limite del Torneo

--squadra 1 gioca evento 5 Boston NBA
INSERT INTO Iscrive VALUES ('user123',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user001',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user002',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user003',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user004',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);

-- Squadra 7 evento 5 Los Angeles NBA
INSERT INTO Iscrive VALUES ('user006',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user007',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user008',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user009',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user010',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user011',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user012',5,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);

--squadra 6 gioca evento 4 Sanfubeach Mondiale 
INSERT INTO Iscrive VALUES ('user123',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user001',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user002',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user003',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user004',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);

-- Squadra 8 evento 4 Tema Italy Mondiale
INSERT INTO Iscrive VALUES ('user006',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user007',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user008',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user009',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user010',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user011',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user012',4,null,'confermato','1/05/2023 11:00:00','giocatore',null,null);

--squadra 10 gioca evento 9 FCBarcellona Champions League 
INSERT INTO Iscrive VALUES ('user123',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user001',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user002',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user003',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user025',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);

-- Squadra 11 evento 9 Tema Real Madrid Champions League
INSERT INTO Iscrive VALUES ('user006',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user007',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user008',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user009',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user010',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user011',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user026',9,null,'confermato','10/07/2024 11:00:00','giocatore',null,null);

--squadra 1 gioca evento 6 Boston NBA
INSERT INTO Iscrive VALUES ('user123',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user789',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user001',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user002',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user003',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user004',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);

-- Squadra 7 evento 6 Los Angeles NBA
INSERT INTO Iscrive VALUES ('user006',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user007',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user008',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user009',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user010',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user011',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user012',6,null,'confermato','10/05/2024 11:00:00','giocatore',null,null);

-- Squadre 3 e 13 Roland Garros evento 2
INSERT INTO Iscrive VALUES ('user123',2,null,'confermato','25/08/2023 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('FQ30',2,null,'confermato','25/08/2023 11:00:00','giocatore',null,null);


--Squadra 9 gioca a Olympics 6 giocatrici
INSERT INTO Iscrive VALUES ('user013', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user014', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user015', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user016', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user017', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user018', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);

-- Squadra 12 gioca agli Olympics 6 giocatrici

INSERT INTO Iscrive VALUES ('user019', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user020', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user021', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user022', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user023', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user024', 15,null,'confermato','10/06/2024 11:00:00','giocatore',null,null);

-- Pallavolo squadre maschili evento spot
INSERT INTO Iscrive VALUES ('user123',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user008',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user456',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user001',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user002',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user003',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);

INSERT INTO Iscrive VALUES ('user004',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user005',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user006',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user007',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user009',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);
INSERT INTO Iscrive VALUES ('user010',21,null,'confermato','16/06/2024 12:00:20','giocatore',null,null);

/***********************************************************************************************************************/
-- Inserimento di 3 user nell evento 19 attivazione TRIGGER chiusura Evento e TRIGGER che blocca Iscrizioni ad Eventi 'chiusi'
--INSERT INTO Iscrive VALUES ('user013',19,null,'confermato','25/08/2023 11:00:00','giocatore',null,null);
--INSERT INTO Iscrive VALUES ('user014',19,null,'confermato','25/08/2023 11:00:00','giocatore',null,null);
-- Questa INSERT fa sollevare l'eccezione
--INSERT INTO Iscrive VALUES ('user015',19,null, 'confermato','25/08/2023 11:00:00','giocatore',null,null);
/***********************************************************************************************************************/
