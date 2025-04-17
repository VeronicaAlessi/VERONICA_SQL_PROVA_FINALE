/*
1)Verificare che i campi definiti come PK siano univoci. 
In altre parole, scrivi una query per determinare l’univocità dei valori di ciascuna PK 
(una query per tabella implementata).
*/
USE PROVA_FINALE_DATABASE;
 
 SELECT JoyID
 , count(JoyID)
 FROM Product
 GROUP BY JoyID
 HAVING JoyID > 1;
 
SELECT TransactionID
, count(TransactionID)
FROM Sales
GROUP BY TransactionID
HAVING TransactionID > 1;

SELECT RegionID
, count(RegionID)
FROM Region
GROUP BY RegionID
HAVING RegionID > 1;

SELECT CategoryID
, count(CategoryID)
FROM Category
GROUP BY CategoryID
HAVING CategoryID > 1;

/*2)Esporre l’elenco delle transazioni indicando nel result set il codice documento, 
la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome 
della regione di venditae un campo booleano valorizzato in base alla condizione 
che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False)*/

select
S.TransactionID
, S.DateTransaction  
, P.JoyName
, C.Category
, R.Country
, R.Region
, CASE 
        WHEN CURRENT_DATE - DateTransaction > 180 THEN TRUE
        ELSE FALSE
    END AS oltre_180_giorni
from Sales as S
inner join Product as P
on S.JoyID = P.JoyID
inner join Region as R
on S.RegionID = R.RegionID
inner join Category as C
on S.JoyID = C.JoyID;

/*3)Esporre l’elenco dei prodotti che hanno venduto, in totale,
una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito. (2014)
(ogni valore della condizione deve risultare da una query e non deve essere inserito a mano). 
Nel result set devono comparire solo il codice prodotto e il totale venduto.
*/

select JoyID
, Quantity
from sales
where Quantity > ( Select 
                  avg (Quantity)
				  from sales
                  where Year(DateTransaction)=2014);

-- 4)Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 

Select
JoyID
, extract(year from DateTransaction) as anno
-- , year(SalesAmount)
, sum(SalesAmount)
From sales
Group by JoyID, DateTransaction;

-- 5)Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.

select
S.JoyID
, extract(year from S.DateTransaction) as anno
, R.Country as Stato
, Sum(SalesAmount) as Tot_fatturato
from sales as S
Left join Region as R
on S.RegionID = R.RegionID
group by S.JoyID, R.Country, S.DateTransaction
order by S.DateTransaction, Tot_fatturato desc;

-- 6)Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
 
Select
Category
, sum(S.Quantity) as Tot_venduto
from Sales as S
Join Product as P 
on S.JoyID = P.JoyID
join Category as C
on S.JoyID = C.JoyID
group by C.Category
order by Tot_venduto desc
limit 1;


-- 7)Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.
-- 1.
Select P.JoyID
,P.JoyName
From Product as P
left join Sales as S
on P.JoyID = S.JoyID
where S.TransactionId is null;
-- 2
Select P.JoyID
,Count(S.JoyID)
From sales as S
right join Product as P
on S.JoyID = P.JoyID
Group by P.JoyID
having Count(S.JoyID)<1;

/*
8)	Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” 
delle informazioni utili (codice prodotto, nome prodotto, nome categoria)
*/

CREATE VIEW Versione_Denormalizzata as (
Select
P.JoyID as Codice
, P.JoyName as Nome
, C.Category as Categoria
From Product as P
join Category as C
on P.JoyID = C.JoyID);

-- 9)Creare una vista per le informazioni geografiche

CREATE VIEW Informazioni_Geografice as (
Select
R.regionID
, R.Region as Regione
, R.Country as Area
, A. addressLine as Via
, A.cap
, A.Province as Provincia
From Region as R
Inner Join Address as A
on R.RegionID = A.RegionID);
