--DB Design


--Pflicht: Wie hoch ist die Auslatung der Seiten und Blöcke einer Tabelle bzw Datenbank
--Seiten
/*
Max 700 DS pro Seiten
1 Seite = 8192 bytes
1 DS max 8060 bei festen Längen
1 Seiten max 8072 nutzbarer Teil für DS

8 Seiten am Stück = Block

----------!
SQL liest Seiten/Blockweise in RAM von HDD im Verhältnis:     1:1 !!!!!!!!
----------!


*/

---Kunden
--Fax1 Fax2 Fax3  Frau1 Frau2 Frau3 Frau4 Rel

NULL kostet Platz


1 MIO DS a 4100
--> 1 MIO Seiten 8 GB 

1 MIO DS a 4000  1 MIO 100bytes
500.000 Seiten  4GB
12.500 Seiten --> 110MB

4,1 GB HDD und RAM




--80 % Seitenauslastung


/*
Datentyp anpassen  statt char einen varchar   n.. nur dort wo notwendig
									muss datetime sein
Spalten explzit auslagern in andere Tabellen


Kompression

Partitionieren

TAB A   TAB B
10000    100000

Abfrage .. immer 10 Zeiln als Ergebnis














*/


