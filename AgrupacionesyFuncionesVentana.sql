---AGRUPACIONES
---BASICA COUNT ASUME AGRUPACION 
SELECT COUNT(*) AS NUMORDERS
FROM Sales.Orders;

SELECT shipperid, COUNT(*) AS NUMORDERS
FROM Sales.Orders
GROUP BY shipperid ;

SELECT shipperid, YEAR(shippeddate) AS shippedyear,
count(*) as numberorder
FROM Sales.Orders
GROUP BY shipperid, YEAR(shippeddate) ;

---FILTRADO CON WHERE

SELECT shipperid, YEAR(shippeddate) AS shippedyear,
count(*) as numberorder
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY shipperid, YEAR(shippeddate) ;

---FILTRADO CON HAVING
SELECT shipperid, YEAR(shippeddate) AS shippedyear,
count(*) as numberorder
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY shipperid, YEAR(shippeddate) 
HAVING COUNT(*)>100;

---OPERADORES MATEMATICOS

SELECT shipperid,
count(*) as numberorder,
COUNT(shippeddate) as shippdorders,
MIN(shippeddate) as firstshipdate,
MAX(shippeddate) as lastshipdate,
SUM(val) as totalvalue,
avg(val) as avgvalues
FROM Sales.OrderValues
WHERE shippeddate IS NOT NULL
GROUP BY shipperid;

---DISTINC COUNT
SELECT shipperid,COUNT(DISTINCT shippeddate) as numshippingdate
FROM Sales.Orders
GROUP BY shipperid;
---JOINS
SELECT S.shipperid,S.companyname, count(*) as numorders
FROM Sales.Shippers as S 
join Sales.Orders as O 
ON S.shipperid=O.shipperid
GROUP BY S.shipperid,S.companyname;

SELECT S.shipperid,S.companyname, count(*) as numorders
FROM Sales.Shippers as S 
join Sales.Orders as O 
ON S.shipperid=O.shipperid
GROUP BY S.shipperid,S.companyname;

---GROUPING SETS
SELECT shipperid,YEAR(shippeddate) as shipyear, COUNT(*) as numorders
FROM Sales.Orders
GROUP BY GROUPING SETS
(
(shipperid,YEAR(shippeddate)),
(shipperid),
(YEAR(shippeddate)),
()
)

---GROUP BY CUBE AGRUPA POR POSIBLES COMBINACIONES
SELECT shipperid,YEAR(shippeddate) as shipyear, COUNT(*) as numorders
FROM Sales.Orders
GROUP BY CUBE (shipperid,YEAR(shippeddate));

---GROUP BY ROLLUP HACE LOS TOTALES POR JERARQUIAS
SELECT shipcountry,shipregion,shipcity, COUNT(*) as numorders
FROM Sales.Orders
GROUP BY ROLLUP (shipcountry,shipregion,shipcity);

---GROUPING
SELECT 
shipcountry,GROUPING(shipcountry) as grpcountry,
shipregion,GROUPING(shipregion) as grpregion,
shipcity,GROUPING(shipcity) as grpcity,
COUNT(*) AS numoreder
FROM Sales.Orders
group by rollup (shipcountry,shipregion,shipcity); 

---PIVOT UNPIVOT

---PIVOT
---primero construimos un CTE    
with PivotData as 
(
SELECT
custid,--grouping columns
shipperid,--spreadind column
freight--agreggation column
from Sales.Orders
)

select custid,[1],[2],[3] ---creo 3 columnas 
from PivotData ---llamo a la CTE
PIVOT(SUM(freight) FOR shipperid in ([1],[2],[3])) AS P; --CON ESTO HAGO EL PIVOT Y SUMO PRO FRIGHT DONDE SHIPPER ID ES 1,2,3

---UNPIVOT
select custid, shipperid,freight
from Sales.FreightTotals
UNPIVOT(freight FOR shipperid in ([1],[2],[3])) AS U;


---FUNCIONES DE VENTANA
select custid,orderid,val,
sum(val) over(PARTITION by custid) as csttotal,
sum(val) OVER() as grantotal
from Sales.OrderValues;


select custid,orderid,val,
ROW_NUMBER() OVER(order by val) as rownumb,
RANK() OVER(order by val) as ranking,--cuando tiene valores duplicados se salta la nuemracion ej: linea 40
DENSE_RANK() over(order by val) as densrank,--no se salta la nuemracion del ranking aunque exista valores duplicados
NTILE(100) OVER(order by val) as ntile100 ---agrupaciones de los diferentes valores
from Sales.OrderValues;


---FUNCIONES OFF SET

select custid,orderid,orderdate,val,
LAG(val) over(PARTITION by custid
order by orderdate,orderid) as prev_val,---valor pasado
LEAD(val) over(PARTITION by custid 
order by orderdate, orderid) as next_val ---valor futuro o valor actual
from Sales.OrderValues;

---TRAE EL PRIMER VALOR Y EL ULTIMO UNA ESPECIE DE RANGO ENTRE VALORES 
select custid,orderid,orderdate,val,
FIRST_VALUE(val) OVER(PARTITION by custid
order by orderdate, orderid
rows between unbounded preceding
and current row) as first_value,
LAST_VALUE(val) OVER(PARTITION by custid
order by orderdate, orderid
rows between current row
and unbounded following) as last_value
from Sales.OrderValues;
