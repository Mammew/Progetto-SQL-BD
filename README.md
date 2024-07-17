# Progetto-SQL-BD
## Per la creazione e popolamento del DB
Si esegue prima il file _script.sql_

Si esugua poi il file _trigger_funz.sql_

Si esugue per ultimo _popolamentoDB.sql_ 
- Il popolamento non risulta vasto in quanto è stato scritto a mano. E' stato creato un insieme di dati consistenti sia per quanto riguarda i trigger implementati ma anche e sopratutto per quelli che non sono stati sviluppati.

Naturalmente viene fatto eseguire prima il file _trigger_funz.sql_ del file _popolamentoDB.sql_ cosi da esser sicuri che i dati siano consistenti. vengono forniti (sia nel file del popolamento che in quello delle funzioni), sotto forma di commenti, delle INSERT o delle query che verificano il funzionamento di TRIGGER, FUNCTION, ecc...
  
## INFO sui dati delle INSERT INTO
|Evento	|Squadre	|Categoria	    |Torneo             |
|-------|-----------|---------------|-------------------|
|5      |1, 7	    |1 (Basket)	    |NBA                |
|2	    |3, 13	    |3 (tennis)	    |Roland Garros      |
|4	    |6, 8	    |4 (calcio)	    |Mondiale           |
|6	    |1, 7	    |1		        |NBA                |
|15	    |9, 12	    |2 (pallavolo)  |Olympics           |
|9	    |10, 11	    |4		        |Champions League   |
|21	    |2, 14	    |2		        |null               |


## Eventi senza Squadre

|Evento	|Categoria	   |Torneo      |
|-------|--------------|------------|
|1	    |1 (Basket)	   |null        |
|3	    |2 (pallavolo) |FIVB        |
|7	    |2 		       |World volley|
|8	    |3 (tennis)	   |Wimbledon   |
|10	    |1		       |Euroleague  |
|11	    |2		       |FIVB        |
|16	    |4 (calcio)	   |Mondiale    |
|17	    |3		       |US Open     |
|19	    |3		       |US Open     |


## Info sui dati
### (Alcune) INSERT

Nell'Evento 19 ci sono iscrizioni commentate per l'attivazione del trigger. Quest'ultimo non permette l'iscrizione ad un Evento quando chiuso. In questo caso si chiude al raggiungimento di 2 partecipanti, di conseguenza, il 3° non può iscriversi.
Il funzionamente del trigger si vede anche negli eventi che raggiungono il numero di partecipanti iscritti previsto dalla Categoria. (Evento: 2, 4, 5, 6, 9, 15, 21).

L'Evento 20 è stato creato per l'attivazione del trigger che gestisce gli impianti se occupati in quello slot di tempo.

### Utenti
- user123 ha preso parte ad un evento di tutte le categorie
- simple2 è sempre stato rifiutato
- FQ30 è stato sia rifiutato che accettato
- Tutti gli altri sono sempre stati accettati e fanno parte di almeno 1 Squadra