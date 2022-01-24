--Warum nicht Tabellen kleiner machen..

--Tab UMSATZ wird pro Tag immer größer

---statt Umsatz .. U2022  U2021 U2020

--partition00  bis partion31

--Ziel... die Abfragen select * from umsatz muss klappen""

--part Sicht.. gute Lösung für Lesen
create table u2022 (id int identity, jahr int, spx int)

create table u2021 (id int identity, jahr int, spx int)

create table u2020 (id int identity, jahr int, spx int)

create table u2019 (id int identity, jahr int, spx int)



--VIEW
--hat eine Sicht eig Daten? Eigt nicht!

select * from umsatz

create view Umsatz 
as
select * from u2022
UNION ALL
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019

select * from umsatz where jahr = 2021

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)
--
ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)
--
--
ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)


--
ALTER TABLE dbo.u2022 ADD CONSTRAINT
	CK_u2022 CHECK (jahr=2022)


	select * from umsatz where jahr = 2021

	select * from umsatz where id = 2021

	--SELECT geht perfekt..
	--INS UP DEL

	insert into umsatz(jahr, spx) values (2020, 100)

	--Error fehlender PK--es geht um Eindeutigkeit.. ein DS muss in der Sicht eindeutig sein
	--ID + Jahr

		insert into umsatz(id, jahr, spx) values (1,2020, 100)


		--PARTITIONIERUNG

		--Dateigruppe(= eine oder mehr DAteien)

		create table t2 (id int)-- mdf Datei

		create table t2 (id int) ON HOT





		-- mehr DAteigruppen: bis100		bis200			bis5000     rest




		--Part Funktion

		----------------------100]------------------200]----------------------------------------
		--             1								2											3


		create partition function fZahl(int)
		as
		RANGE LEFT FOR VALUES (100,200)


		select $partition.fzahl(117)



		--Part Scheme
		create partition scheme schZahl 
		as
		partition fzahl to (bis100, bis200, rest)
		---                                 1       2       3



		create table ptab (id int identity, zahl int, spx char(4100)) ON schZahl(zahl)

set statistics io, time on


declare @i as int = 1
begin tran
		while @i<=20000
			begin
					insert into ptab (zahl, spx) values(@i, 'XY')
					set @i+=1
			end
	commit


	select * from ptab where zahl = 117 --100 Seiten
		select * from ptab where id = 117 --20000 Seiten
			select * from ptab where zahl = 1117 --19800 Seiten


	--Grenzen anpassen  Neue Grenze bei 5000 und Grenze bei 100 löschen


	--DGruppen Tabelle, f() schema

	----------100------------200-----------------5000---------------------------


	--DGruppen neue Dgruppe  bis5000
	--Tabelle niee!!, 
	--f()  neue Grenze
	--schema ja.. neue Dgruppe angeben

	alter partition scheme schZahl next used bis5000
	--scheme kennt 4 

	select $partition.fzahl(zahl), min(zahl), max(zahl), count(*)
	from ptab group by $partition.fzahl(zahl)

	--------------------------------200----------------------5000-------------------------------
	alter partition function fzahl()  split range(5000)

select * from ptab where zahl = 1117

--Grenze entfernen.. 100
-----------x100!----------200-----------------------5000---------------------

	--DGruppen ..nix
	--Tabelle niee!!,  nix und nimmer
	--f()  Grenze entfernen
	--schema .. nix

	alter partition function fzahl() merge Range(100)


select * from ptab where left(spx,1) = 1 --kompletter Durchlauf


--kann man Daten archivieren?


--Wie läufts gerade?


CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [rest])

CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)


drop table archiv
create table archiv(id int not null, zahl int, spx char(4100)) on bis200

alter table ptab switch partition 1 to archiv

select * from archiv 

select * from ptab

--wenn man mit ca 100MB/sek Daten auf der HDD verschieben kann
--wie lange würde das Verschieben ins Archiv dauern, wenn es sich um 1 GB handeln würde

--keine 10 Sekunden.. dauert ms.. es wird nichts verschoben, sondern Part wir din Tabelle umbenannt






--jahresweise
		create partition function fZahl(datetime)
		as
		RANGE LEFT FOR VALUES ('31.12.2021 23:59:59.999','','')

		-- a bis m   n bis r   s bis z
		-------------------------m]maier----------------------------s
				create partition function fZahl(varchar(50))
		as
		RANGE LEFT FOR VALUES ('n','')


		create partition scheme schZahl 
		as
		partition fzahl all to ([PRIMARY])
		---                                 1       2       3





















