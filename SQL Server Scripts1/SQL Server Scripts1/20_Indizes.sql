--Pl�ne verstehen:

-- SEEK  Herauspicken 
--SCAN ..alles durchsuchen m�ssen (A bis Z)

--bei allen Suchen mit Where sollte also g�nstiger Weise ein Seek sein

select * from orders where orderid like '%10248'

--SEEK ..besser mit Indizes

select * from ptab where zahl = 1117
select * from ptab where id = 1117

--Indexarten

--Clustered IX gruppierte Index !
--NON Clustered Index ..nicht gr IX !
----------------------------------------
--eindeutige Index ! 
--zusammengesetzter IX !
--IX mit eingeschl Spalten !
--gefilterter IX
--abdeckender IX !
--ind Sicht !
--part Index !
--hypoth (realer) IX
-----------------------------------------
--Columnstore Index (gr n gr)



/*
NON CL IX

zus�tzliche Menge an Datenseiten in sortierter Form
bis zu ca 1000 NON CL IX pro Tabelle m�glich
je mehr wir Treffer (rel viel) haben, desto schlechter
Wechsel von IX Seek zu SCAN
rel viel ? 40% 

Abfragen mit  :  = ,  ID Abfragen,  PK
sind g�nstig f�r den NON CL IX


Oft ist der PK als CL IX ttale Verschwendung


CL IX = Tabelle in sortierter Form
nur noch CL IX SCAN aber nie wiede reinen Table Scan (HEAP)
nur 1 CL IX pro Tabelle
super cool f�r Bereichsabfragen, aber auch f�r eindeutige 
*/

--SCAN:   TABLE  CL IX SCAN
select * from best --CL IX SCAN

set statistics io, time on
--Table Scan , weil kein IX
--CL IX auf Orderdate


select id  from kundeumsatz where id = 100 --53324  188ms 43ms Dauer

--besser: NIX_ID -->IX  SEEK 
select id  from kundeumsatz where id = 100  --0ms 3 Seiten IX mit 3 Ebenen


--IX Seek mit Lookup
select id , freight from kundeumsatz where id = 100  --0ms 3 Seiten + 1 Lookup

select id , freight from kundeumsatz where id < 100 

select id , freight from kundeumsatz where id < 9500 --hier schon scan

--was wenn freight im IX w�re--Lookup vermeiden
--zusammengesetzter IX kann aber nur 16 Spalten haben (max 900byte)
--NIX_ID_FR
select id , freight from kundeumsatz where id < 900000


--nie * Abfragen
--kaum eine Spalte dazu : Lookup-- Table Scan
select id , freight, Lastname from kundeumsatz where id <12000

--besser als ein zusammengesetzter IX ist oft ein IX mit eingeschlossenen Spalten
--Um Lookups zu vermeiden (wg SELECT) empfiehlt es sich weiter Spalten in den IX
--mit aufzunehmen ohnen den Baum zu belasten
--NIX_ID_i_FRLN

select * from kundeumsatz where city = 'Berlin'


--
select	country, sum(unitprice*quantity) 
from	 kundeumsatz
where	city = 'Berlin'
group by country




--NIX_CI_FR_i_CYUPQU
select	country, sum(unitprice*quantity) 
from	 kundeumsatz
where	city = 'Berlin' and freight < 1
group by country


--bei or ist der QueryOptimizer draussen.. hier 2 Indizes
select	country, sum(unitprice*quantity) 
from	 kundeumsatz
where	city = 'Berlin' or freight < 1
group by country

--selektive Spalten zuerst..
select * from kundenumsatz
where country = 'USA' and City = 'New York'












--ind Sicht

select country, count(*) as Anzahl
from kundeumsatz
group by country


create or alter  view vdemo
as
select country, count(*) as Anzahl
from kundeumsatz
group by country

select * from vdemo



create or alter  view vdemo with schemabinding
as
select country, COUNT_BIG(*) 
as anzahl
from dbo.kundeumsatz
group by country

select * from orders where orderid = 100000