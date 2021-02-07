---SUB QUERIES
SELECT productid,productname,unitprice
From Production.Products
WHERE unitprice=
(SELECT MIN(unitprice)
From Production.Products);

---NO SE PUEDE EJECUTAR PORQUE EL = NO ACEPTA MÁS VALORES, POR LO TANTO DEBEMOS CAMBIARLO POR EL OPERADOR IN
SELECT productid,productname,unitprice
From Production.Products
WHERE unitprice=
(SELECT unitprice 
From Production.Products
where unitprice <=6);

SELECT productid,productname,unitprice
From Production.Products
WHERE unitprice IN
(SELECT unitprice 
From Production.Products
where unitprice <=6);

---SUB QUERIES CORRELACIONADAS: EN ESTE EJEMPLO NOS DEVUUELVE EL VALOR MINIMO DE LA CATEGORIA CON LA SUB QUERIE

SELECT productid,productname,unitprice
From Production.Products AS P1
WHERE unitprice=
(SELECT MIN(unitprice)
From Production.Products AS P2
WHERE P2.categoryid=P1.categoryid);

SELECT productid,productname,unitprice
From Production.Products AS P1
WHERE unitprice=
(SELECT MAX(unitprice)
From Production.Products AS P2
WHERE P2.categoryid=P1.categoryid);

--SUBQUERIES CON EXISTS
select custid,companyname
from Sales.Customers AS C 
where   EXISTS 
(SELECT * 
FROM Sales.Orders as O
where O.custid=C.custid
AND O.orderdate='20070212'); 

---comprbando el resultado
SELECT * 
FROM Sales.Orders as O
where O.orderdate='20070212'

--SUBQUERIES CON NOT EXISTS

select custid,companyname
from Sales.Customers AS C 
where   NOT EXISTS 
(SELECT * 
FROM Sales.Orders as O
where O.custid=C.custid
AND O.orderdate='20070212')
ORDER BY custid;

---TABLE EXPRESSIONS 
---MANERAS DE ESTRUCTURAR MEJOR LAS QUERIES Y DEVUELVEN UNA TABLA
---ESTA QUERY CUENTA LAS VECES QUE APARECE UNA CATEGORIA Y SE REINICIA CUANDO APARECE UNA NUEVA 
SELECT ROW_NUMBER() OVER(PARTITION BY categoryid
ORDER BY unitprice,productid) AS ROWNUM,
categoryid,productid,productname,unitprice
FROM Production.Products;

--CONSTRUYENDO TABLA DERIVADA, DE CADA CATEGORIA TRAEME LOS DOS PRIMEROS RESULTADOS
SELECT categoryid,productid,productname,unitprice
FROM (SELECT ROW_NUMBER() OVER(PARTITION BY categoryid
ORDER BY unitprice,productid) AS ROWNUM,
categoryid,productid,productname,unitprice
FROM Production.Products) AS D
WHERE ROWNUM <=2;

---CTE OJO QUE CUANDO SE EJECUTA UNA VEZ DESAPARECE 
WITH CTE_C AS 
(
    SELECT ROW_NUMBER() OVER(PARTITION BY categoryid
    ORDER BY unitprice,productid) AS ROWNUM,
    categoryid,productid,productname,unitprice
    FROM Production.Products
)

--SELECT * FROM CTE_C SI HUBIESE TENEIDO ACTIVADO ESTE SELECT Y QUIERO EJECUTAR LOS 3 EL ULTIMO NO SE EJECUTA YA QEU CON ESTE
--EJECUTA LA CTE_C UNA VEZ

SELECT categoryid,productid,productname,unitprice
FROM CTE_C
WHERE ROWNUM <=2;

---RECURSIVIDAD DE LAS CTEs
WITH EmpsCTE as 
(
select empid,mgrid,firstname,lastname,0 as distance
from HR.Employees
where empid=9
union all 
select M.empid,M.mgrid,M.firstname,M.lastname,S.distance + 1 as distance 
from EmpsCTE as S
join HR.Employees as M
on S.mgrid=M.empid
)
select empid,mgrid,firstname,lastname, distance
from EmpsCTE;

---VISTAS 
IF OBJECT_ID('Sales.RankedProducts','V') is not NULL DROP VIEW Sales.RankedProducts; ---este comando borrar la vista en caso que exista
GO
CREATE VIEW Sales.RankedProducts
AS 
SELECT 
ROW_NUMBER() OVER(PARTITION BY categoryid
ORDER BY unitprice,productid) AS ROWNUM,
categoryid,productid,productname,unitprice
FROM Production.Products
GO
)---ESTE NO VA 


---FUNCIONES  
IF OBJECT_ID('HR.Getmanagers','IF') is not NULL DROP FUNCTION HR.Getmanagers; ---este comando borrar la vista en caso que exista
GO
CREATE FUNCTION HR.Getmanagers (@empid as int) RETURNS TABLE
AS 
RETURN 
WITH EmpsCTE as 
(
select empid,mgrid,firstname,lastname,0 as distance
from HR.Employees
where empid=@empid
union all 
select M.empid,M.mgrid,M.firstname,M.lastname,S.distance + 1 as distance 
from EmpsCTE as S
join HR.Employees as M
on S.mgrid=M.empid
)
SELECT empid,mgrid,firstname,lastname,distance
FROM EmpsCTE;

SELECT * FROM HR.Getmanagers(9) 
SELECT * FROM HR.Getmanagers(5) 

---OPERADOR APPLY
---cross apply
SELECT S.supplierid,S.companyname AS supplier,A.*---muestrame todos los campos de A
FROM Production.Suppliers AS S 
CROSS APPLY (SELECT productid,productname,unitprice
from Production.Products as P 
WHERE P.supplierid=S.supplierid
ORDER BY unitprice,productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A 
WHERE S.country=N'Japan';
---outer apply
SELECT S.supplierid,S.companyname AS supplier,A.*---muestrame todos los campos de A
FROM Production.Suppliers AS S 
OUTER APPLY (SELECT productid,productname,unitprice
from Production.Products as P 
WHERE P.supplierid=S.supplierid
ORDER BY unitprice,productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY) AS A 
WHERE S.country=N'Japan';


SELECT productid,productname,unitprice 
FROM Production.Products
ORDER BY unitprice,productid
OFFSET 0 ROWS FETCH FIRST 2 ROWS ONLY;

--- OPERADOR INTERSECT - UNION - UNION ALL - EXCEPT
---intersect datos que estan presentes en las dos tablas 
SELECT country,region,city
FROM HR.Employees
INTERSECT
select country,region,city
from Sales.Customers

---UNION ME TRAE TODO DE LAS DOS CONSULTAS PERO QUITA LOS DUPLICADOS
SELECT country,region,city
FROM HR.Employees
UNION
select country,region,city
from Sales.Customers

---UNION ALL TARE TODO DE LAS DOS TABLAS HASTA LOS REPETIDOS 
SELECT country,region,city
FROM HR.Employees
UNION ALL
select country,region,city
from Sales.Customers

---EXCEPT ME TRAE TODO LO DE LA PRIMERA TABLA QUE NO ESTÁ EN LA DERECHA 
SELECT country,region,city
FROM HR.Employees
EXCEPT
select country,region,city
from Sales.Customers

