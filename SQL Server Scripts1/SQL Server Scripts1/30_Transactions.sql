--Transaction und Locks

--so kurz wie m�glich

--INS UP  DEL
-

BEGIN TRAN
select @@TRANCOUNT

select * from customers
update customers set city = 'Bonn' 
where customerid = 'ALFKI'

COMMIT --best�tigt eine TX


ROLLBACK --macht TX r�ckg�ngig


select * into kunden from customers


--Ohne IX: wird alles gesperrt
--Sperrniveau: Zeile, Seite, Block,  Partition, Tabelle



begin tran
update kunden set city = 'Bonn' where customerid = 'ALFKI'
select @@TRANCOUNT
select * from kunden
commit
rollback


--ISOLATION LEVEL
--�ndern hindert Lesen
set transaction isolation level read committed
set transaction isolation level read uncommitted

--Lesen hindert das �ndern (update /delete)
set transaction isolation level repeatable read

--Lesen hindert nun auch INS UP DEL
set transaction isolation level serializable







--PK als Gr IX..

--PK hat welche Aufgabe: Beziehungen 

--eindeutig kann auch NGR IX eindeutig

--USER A

use northwind;

--jeder I U D ist immer eine TX, aber du kannst nicht mehr r�ckg�ngig machen

begin tran

--Anweisungen

commit  --fixiert
rollback --R�ckg�ngig

begin tran
update customers set city = 'MUC' where customerid = 'ALFKI'
update orders set freight = freight *1.01

select * from customers --zustand f�r Stadt ist unklar
rollback


--MARK  save (point)
--MARK .. einen restore
--save --bis zu einen Punkt rollback
select * into customers2 from customers

Begin tran t1
update customers2 set city = 'X'
select * from customers2 

begin tran M1 with Mark
update customers2 set city = 'Y'
select * from customers2

--Rollback --alles wird restored bis zum Ausgangspunkt
--commit best�tigt nur die aktuelle Transaction

save transaction Innersave
select * from customers2

begin tran M2 with Mark
update customers2 set city = 'Z'
select * from customers2
commit
rollback tran Innersave --alle bei Y

Rollback

--z�hlt das Transactionlog

--2019 : ADR
























