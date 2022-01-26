--Warum sind F() schlecht


--aus Tabelle Kundeumsatz suchen wie alle Best aus dem Jahr 1996


select * from KundeUmsatz
where  orderdate between '1.1.1996'  and '31.12.1996 23:59:59.999'


select * from KundeUmsatz
where  year(orderdate) = 1996



--RngSumme





select dbo.fRNgSumme(10248)--- 440


select * from [Order Details]












