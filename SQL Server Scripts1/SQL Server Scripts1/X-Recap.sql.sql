/*
create database ... ? 
autom Vergr��erung... 1MB oder 64MB??.....
LogFile muss andere Vergr��erungsraten (10%..) --> 1000MB  Startgr��e der DAten25%
Startgr��en Wie gro� am Ende der Lebenszeit

--SQL Dienstkonto sollte folgendes Recht haben
Durchf�hren von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausf�hren k�nnen, zum Beispiel eine Remotedefragmentierung.

Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht k�nnen Datentr�ger durchsuchen und Dateien in den Speicher erweitern, der andere Daten enth�lt. Wenn die erweiterten Dateien ge�ffnet werden, kann der Benutzer m�glicherweise die so erlangten Daten lesen und �ndern.

Standardwert: Administratoren


logischen DB Design 
Normalisierung vs Redundanz (=schnell)
Pflege der Redundanz: Trigger (langsam)--> Bi Logik

physikalisches DB Design
Seiten und Bl�cke die Seiten sollte immer sehr voll sein

Ziel bei Tuning vo TSQL--Reduzieren von Seiten

dbcc showcontig()-- nur die top Tabellen


Reduzieren von Seiten bei Abfragen:
"Bessere" Datentyp statt char ein  varchar , muss datetime sein (date)
Kompression (Zeilen , Seiten)--> 40-60% zu erw. Kompression --> CPU Zeit steigt--> RAM Verbrauch sinkt
Partitionierung  (Dateigruppen, F(), PartSchema)   | part Sicht
-- Part Teile einer Tabelle verhalten sich wie Tabellen

CPU
1 oder alle(bis SQL 2014 Standwert: alle Kerne)
seit SQL 2016 beim Setup: max 8 Kerne zuweisen

wann nimmt er mehr als 1 CPU:
Kostenschwellwert default 5 (SQL Dollar)
Tipp: 25 
pro ABfrage option (maxdop 8)


















*/