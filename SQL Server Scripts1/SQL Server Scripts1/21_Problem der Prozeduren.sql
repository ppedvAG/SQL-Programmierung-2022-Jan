--Prozeduren


--a)Adhoc
--b) Sichten
--c)f()
--d) Proc

--cbad
--a				b						c								d	
----------------------------------------------
--langs                                              schnell

--in der Regel: Proc am schnellsten
-- f() am dümmsten
--Sichten und adhoc gleich

--Proc  wie batchdatei

--beim ersten Aufruf wird die Proc kompiliert..
----> der Plan wird fix hinterlegt


select * from customers where customerid  = ALFKI

exec gpSucheKunden 'ALFKI' -- 1 Treffer
exec gpSucheKunden 'A' -- 4 Treffer  alle mit A beginnend
exec gpSucheKunden '%' -- alle 



create or alter proc gpSucheKunden @cid varchar(5)
as
select * from customers where customerid like @cid +'%'

exec gpSucheKunden 'ALFKI' 
exec gpSucheKunden 'A'


declare @var as varchar(150) --weil in der Tab die Spalte auch ein varchar(50)

--where sp = @var


set statistics io, time on
select * from kundeumsatz where id < 2


--NIX_ID
select * from kundeumsatz where id < 2 --4

select * from kundeumsatz where id < 1000000


create proc gpId @id int
as
select * from kundeumsatz where id <@id

exec gpId 2

exec gpId 2 --Seek oder Scan--
exec gpId 1000000 --Seek oder Scan--
exec gpId 1000000 --Seek oder Scan-----> Seek mit 1 MIo Seiten  wtf!!!

dbcc showcontig('kundeumsatz') --
dbcc freeproccache

exec gpId 1000000 


exec gpId 2


create proc gpId @id int
as
If @id < 10000 exec gpIDwenige --immer seek
else
exec gpid2 --scan
select * from kundeumsatz where id <@id




