--Warum sind F() schlecht


--aus Tabelle Kundeumsatz suchen wie alle Best aus dem Jahr 1996


select * from KundeUmsatz
where  orderdate between '1.1.1996'  and '31.12.1996 23:59:59.999'


select * from KundeUmsatz
where  year(orderdate) = 1996



--RngSumme





select dbo.fRNgSumme(10248)--- 440


select * from [Order Details]


create function fRngSumme (@BestId int) returns money
as
BEGIN
	return(select sum(unitprice*quantity) from [order details] where orderid = @BestId)
END


select dbo.fRngSumme(10248)

select dbo.fRngSumme(orderid) , * from orders

alter table orders add RngSumme as dbo.fRngSumme(orderid)


select * from orders where RngSumme < 100




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
ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 110

alter table kundeumsatz add freight2 money


update kundeumsatz 
	set freight2 = 
		freight * RAND(convert(varbinary, newid()))*100

--select freight, count(*) from o2 group by freight
ALTER DATABASE [Northwind] SET COMPATIBILITY_LEVEL = 150
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






















