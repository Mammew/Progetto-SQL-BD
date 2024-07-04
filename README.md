# Progetto-SQL-BD
## Per la creazione del DB
    - Si esegue prima il file script.sql
    - Si esugua poi il file trigger_funz.sql
    - Si esugue per ultimo popolamento_DB.sql
  
# INFO sui dati delle INSERT INTO
Evento	Squadre	Categoria	Torneo
5	1, 7	1 (Basket)	NBA
2	3, 13	3 (tennis)	Roland Garros
4	6, 8	4 (calcio)	Mondiale
6	1, 7	1		NBA
15	9, 12	2 (pallavolo)	Olympics
9	10, 11	4		Champions League
21	2, 14	2		null

-- Eventi senza Squadre --
Evento	Categoria	Torneo
1	1 (Basket)	null
3	2 (pallavolo)	FIVB
7	2 		World volley
8	3 (tennis)	Wimbledon
10	1		Euroleague
11	2		FIVB
16	4 (calcio)	Mondiale
17	3		US Open
19 	3		US Open  --> ci sono iscrizioni

-- Info sui dati --
- user123 ha preso parte ad un evento di tutte le categorie
- simple2 è sempre stato rifiutato
- FQ30 è stato sia rifiutato che accettato
- Tutti gli altri sono sempre stati accettati e fanno parte di almeno 1 Squadra