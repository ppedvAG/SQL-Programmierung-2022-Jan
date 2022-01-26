--Pläne verstehen:

-- SEEK  Herauspicken 
--SCAN ..alles durchsuchen müssen (A bis Z)

--bei allen Suchen mit Where sollte also günstiger Weise ein Seek sein

select * from orders where orderid like '%10248'

--SEEK ..besser mit Indizes

select * from ptab where zahl = 1117
select * from ptab where id = 1117

--Indexarten

--Clustered IX gruppierte Index ! = Tabelle
--NON Clustered Index ..nicht gr IX !
----------------------------------------
--eindeutige Index ! 
--zusammengesetzter IX ! max 16 Spalten od 900bytes ...where !!!
--IX mit eingeschl Spalten !   SELECT ---> abdeckender IX
--gefilterter IX ab Std.. lohnt nur, wenn Ebenen weniger werden als ohne Filter
--abdeckender IX !
--ind Sicht !
--part Index !
--hypoth (realer) IX
-----------------------------------------
--Columnstore Index (gr n gr)


/*
NON CL IX

zusätzliche Menge an Datenseiten in sortierter Form
bis zu ca 1000 NON CL IX pro Tabelle möglich
je mehr wir Treffer (rel viel) haben, desto schlechter
Wechsel von IX Seek zu SCAN
rel viel ? 40% 

Abfragen mit  :  = ,  ID Abfragen,  PK..bei rel wenigen Ergebniszeilen
sind günstig für den NON CL IX


Oft ist der PK als CL IX ttale Verschwendung


CL IX = Tabelle in sortierter Form
nur noch CL IX SCAN aber nie wiede reinen Table Scan (HEAP)
nur 1 CL IX pro Tabelle
super cool für Bereichsabfragen, aber auch für eindeutige 
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

--was wenn freight im IX wäre--Lookup vermeiden
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

--Klammern setzen
select * from kundeumsatz 
where
		EmployeeID=1
		OR 
		(Freight < 1
		AND
		Country = 'USA')


	select freight , shipcity from kundeumsatz
	where
			country = 'UK'


	select freight , shipcity from kundeumsatz
	where
			country = 'USA'

--Kopie der KundeUmsatz
	select * into ku2 from kundeumsatz

	--KU2 = HEAP

	select top 3 * from ku2 --abfrage AGG where 


	--Lagerwert pro Productname
	--Companyname  startet mit P
	
	--idealer IX: NIX_CN_i_PNUSUP)
	select Productname, sum(unitsinstock*unitprice) as Summe from kundeumsatz
	where companyname like 'P%'
	Group by Productname
	--315   , CPU-Zeit = 15 ms, verstrichene Zeit = 13 ms.

		select Productname, sum(unitsinstock*unitprice) as Summe from ku2
	where companyname like 'P%'
	Group by Productname



	--Cl ColStore IX CSIX
			select Productname, sum(unitsinstock*unitprice) as Summe from ku2
	where companyname like 'P%'
	Group by Productname


select Productname, sum(unitsinstock*unitprice) as Summe from ku2
	where employeeid = 1
	Group by Productname


	--a stimmt     4,3 MB

	--Kompression!!!!  
	--nun Archiv Columnstore Kompression---> 3,0 MB

	--


	--

	delete from ku2 where country ='USA'

	update ku2 set  freight = freight *1.1 where country = 'UK' --=552960 in HEAP delta store

	select * from sys.dm_db_column_store_row_group_physical_stats

	delete from ku2

	select * from ku2



	--inner left right cross  merge nested loop hash
	select * from customers c inner merge join orders o on c.CustomerID=o.CustomerID

	select * from customers c inner  loop join orders o on c.CustomerID=o.CustomerID

	select * from customers c inner hash join orders o on c.CustomerID=o.CustomerID

	GO



	--beste IX Strategie

	--A B C  1000
	/*
	0 = HEAP
	1 = CL IX
	>1 N CL IX
	



	*/

	select * from sys.dm_db_index_usage_stats


