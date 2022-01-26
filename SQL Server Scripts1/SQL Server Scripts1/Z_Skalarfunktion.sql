--Scalar Function 
--SQL kann zu Beginn der Ausfürhung keinen ordentlichen Plan erstellen
--mit SQL 2019 wird die Planerstellung verzögert um für die Funktion eine bessere Einschätzung zu bekommen
--klappt aber nur beim rel einfachen Funktionen..
--das geht nur bei einfachen Skalawertfunktionen

--geschätzte Anzahl von Zeilen vs tats Anzahl von Zeilen


use northwind;
GO

select * from sys.dm_exec_function_stats

create or alter function dbo.fbrutto
	(
		@Fracht money,
		@MwSt decimal (4,2)
	) returns money
as
Begin
	return (@Fracht*@MwST)
End
--Skalarfunction kann vorab nicht exakt geschätzt werden..
--jetzt versteht SQL Server wie das intern funktioniert

--zB: f(spalte, Wert) --> Spalte * Wert
--... begrenzt machbar
set statistics io, time on

alter table kundeumsatz add freight2 money
update kundeumsatz 
	set freight2 = 
		freight * RAND(convert(varbinary, newid()))*100

--select freight, count(*) from o2 group by freight
ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 110
GO
set statistics io, time on --wieviele Zeilen werden geschätzt ;-) ----   €0Prozent
select * from kundeumsatz
		where 
			dbo.fbrutto(freight2,1.19) < 2
--, CPU-Zeit = 5800 ms, verstrichene Zeit = 6500 ms.
-- kein Parallelismus


ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 150
GO

select * from ku2
		where 
			dbo.fbrutto(freight,1.19) < 2
--870   215

select inline_type, * from sys.sql_modules
where is_inlineable=1


--Bsp mit mehr Daten--->

















select inline_type, * from sys.sql_modules

