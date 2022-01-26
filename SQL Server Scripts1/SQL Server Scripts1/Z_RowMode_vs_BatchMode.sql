set statistics io, time on
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = OFF;

--BatchMode. eigtl dem ColumnStore vorbehalten..
--Seit SQL 1019 auch in RowStore verfügbar..
--fall ColStore nicht verwendet werden soll
--nicht bei im tabellen
--auch nicht bei XML oder sparse columns
--Cursor

set statistics io, time on
select customerid, sum(unitprice*quantity) from kundeumsatz group by customerid
