select * from customers

select * from hr.slf
select * from hr.projekte


select * from projekte
select * from slf


alter view hr.v3
as
select employeeid, country from dbo.employees where country = 'USA'

select * from v3


select * from dbo.employees


select city as Stadt, sum(freight) as SummeFracht
from kundeumsatz
where city = 'Graz' 
group by city having sum(freight) >1
order by city


select city as Stadt, sum(freight) as SummeFracht
from kundeumsatz k
--where k.City = 'Graz'  --??
group by city having city = 'GRAZ'
order by Stadt


--Logischen Fluss

---> FROM--> JOIN --> WHERE --> GROUP BY --> HAVING
-->  SELECT (ALIASE; MATHE) --> ORDER BY  --> TOP DISTINCT



--BAD VIEWS


create view v1
as
select c.CompanyName, c.CustomerID
			 ,o.OrderID, o.Freight, o.OrderDate
			, od.UnitPrice, od.Quantity
		   , p.ProductID, p.ProductName
from customers c inner join orders o on c.CustomerID=o.CustomerID
											inner join [Order Details] od on od.OrderID= o.OrderID
											inner join products p on p.ProductID=od.ProductID


--Abfrage: wir sichen alle Firmen (Companyname) und deren Frachtkosten
--deren Frachtkosten kleiner als 10 sind

--wieviele Zeilen kommen raus?

--357  78   176

--nciht zwekentfremden
select CompanyName ,Freight from v1 where freight < 10


select c.CompanyName ,o.Freight
from customers c inner join orders o on c.CustomerID=o.CustomerID
										where freight < 10
										order by 1

drop table slf 
drop view v2

create table slf ( id int , stadt int, land int)
create table hr.slf ( id int , stadt int, land int)


select * from slf

insert into slf
select 1,10,100
UNION ALL
select 2,20,200
UNION ALL
select 3,30,300

select * from slf


alter view v2 with schemabinding
as
select id, stadt, fluss  from dbo.slf


select * from v2



alter table slf add fluss int
update slf set fluss = ID *1000



alter table slf drop column land

kjhjkdah

löschmich
delme
v25





create table hr.projekte (id int)


select * from slf




