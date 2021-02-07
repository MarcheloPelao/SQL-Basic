---FUNCION ORDER BY ASC

SELECT empid,firstname,lastname,city, MONTH(birthdate) AS BIRTH_MONTH
FROM HR.Employees
WHERE country=N'USA'AND region=N'WA'
ORDER BY city ASC;

---FUNCION ORDER BY DESC

SELECT empid,firstname,lastname,city, MONTH(birthdate) AS BIRTH_MONTH
FROM HR.Employees
WHERE country=N'USA'AND region=N'WA'
ORDER BY city DESC;

---ORDER BY POR MÁS DE UN CAMPO

SELECT empid,firstname,lastname,city, MONTH(birthdate) AS BIRTH_MONTH
FROM HR.Employees
WHERE country=N'USA'AND region=N'WA'
ORDER BY city , empid;

---FUNCION TOP traeme los 3 ultimo con la clausula order by desc le indico eso

SELECT TOP(3) orderid,orderdate,custid,empid
FROM Sales.Orders
ORDER BY orderdate DESC;

---FUNCION OFFSET PARA SELECCIONAR POR TRAMOS 
SELECT  orderid,orderdate,custid,empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET 0 ROWS FETCH NEXT 25 ROWS ONLY;---MUESTRAME LAS PRIMERAS 25 FILAS

SELECT  orderid,orderdate,custid,empid
FROM Sales.Orders
ORDER BY orderdate DESC, orderid DESC
OFFSET 25 ROWS FETCH NEXT 25 ROWS ONLY;---MUESTRAME DESDE FILA 25 Y 25 MÁS 

