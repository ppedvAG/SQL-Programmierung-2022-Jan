--Lege eine DB an Name: testdb

create database testdb;

--Wie groß ist die DB jetzt?
--16 MB(8MB Daten und 8 MB Logfile)
--7MB (5MB und 2 MB)


--Wachstumraten einer DB?
--64MB Daten oder Logfile ..ab SQL 2016
--1MB Datenfile   10% Logfile.. bis SQL 2014



use testdb;
GO

create table test1(
								id int identity
							,	spx char(4100)
						    	)


insert into test1
select 'XY'
GO 20000--20000 Batches


--Frage: wie groß wird die Tabelle test1 am Ende sein?
--theoretisch 80MB..
--aber warum so lange


--was soll man dann tun?

--Idee: Wieso nicht die DB so groß machen, wie sie in 3 Jahren sein wird..
--das Logfile sollte nie wachsen...  zu Beginnn 25% der Datendateien


---Warum ist die Tabelle test1 169MB statt 80

--DB Design....Normalisierung -- Redundanz --Generalisierung

/*
PK Primärschlüssel    --->  Beziehung  -->    FK    Fremdschlüssel

PK: 
Aufgabe: Beziehung einzugehen
Bedingung DS wird eindeutig

Beziehung
kontrolliert Datenintegrität

FK..  --xfachdazu passenden Werte

Normalform  1. 2. 3. 4. 5.  BC
select newid()

Kunden 1MIO
KdNr  int identity ... uniqueidentifier  B1AD1AB1-8A8A-4E80-851E-698485D4DF6F
Vorname   varchar(150)  nvarchar(150)
Nachname
GebDat   datetime
PLZ   char(5)
Ort
Strasse
Land
Email
MailDomäne
EmailPräfix



Produkte
PrNr
Bez
Preis money   decimal(4,2)


Bestellung 2 MIO 
BNr
KdNr
BDatum (evtl Spaltn: QU JAHR KW) -----like 'Sch'    left(NAME, 3)='SCH'
Lieferkosten
RSumme


BestPositionen 4MIO
BPNr
BNr
PrNr
Menge
Preis
PosSumme.. eher nicht


--datetime: ms
--date
smalldatetime (sek)
datetime2(ns)
datetimeoffset (ZeitZone)

Otto

varchar(50)  'otto'    4 
char(50)      'otto                                                       ' 50
nchar(50)   'otto                                                       ' 50 *2 = 100
nvarchar(50)  'otto'     4 *2 = 8
text()  ..nicht nehmen!!!







---*/
create table t1 (id int , spx varchar(4100), sp2 char(4100))

--was wäre wenn: 1 MIO DS a 4100 bytes--> 1 MIO Seiten 
--> 1 MIO a 8kb --> 8 GB

--8 GB auf der HDD und im RAM!!!!!!!!!!!!


use testdb

set statistics io, time on-- Anzahl der Seiten , Dauer und CPU Zeit für Abfrage


select * from test1
--logische Lesevorgänge: 20000 * 8 kb = 160MB ---> 160MB in RAM


dbcc showcontig('test1')
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

dbcc showcontig('test1')










*/


delete from customers where customerid  = 'FISSA'



use northwind;

select * from employees
select * from orders --aus dem Jahr 1997 orderdate

--warum falsch...
select * from orders where orderdate >= '1.1.1997' and orderdate <= '31.12.1997 23:59:59.999' --411
select * from orders where orderdate >= '1.1.1997' and orderdate < '1.1.1998' --411
select * from orders where orderdate >= '1.1.1997' and orderdate <= '31.12.1997 23:59:59.997' --411
select * from orders where year(orderdate) = 1997 --408 --immer richtig 


















