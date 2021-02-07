---FILTRADO
SELECT empid,firstname,lastname,country,region,city
From hr.Employees
where country='USA';

SELECT empid,firstname,lastname,country,region,city
From hr.Employees
where region<>'wa'or region is null

---ESTA SELECT HACE LO MISMO QUE LA ANTERIOR PERO NO SE RECOMIENDA USARLO EN EL WHERE POR LA SARGABILITY,ES DECIR APLCIAR UNA FUNCION EN EL WHERE IMPLICA BAJAR EL RENDIMIENTO DE LA QUERY
SELECT empid,firstname,lastname,country,region,city
From hr.Employees
where coalesce(region,'unknow') <> 'wa'

---FILTRADO CADENAS
SELECT empid,firstname,lastname
From hr.Employees
where lastname='Davis';


---FILTRADO CADENAS CON LIKE
SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'D%' ---al colocar la N delante nos evitamos la conversion en las cadenas de valores a Nvarchar directo

---FILTRADO CADENAS CON LIKE
SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'%D' 

SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'%D%' 


----FILTRADO LIKE _ INDICA QUE CUALQUIER CARACRTE ANTES O DESPUES O ENTREMEDIO DEPENDE DONDE LO UTILICEMOS

SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'_u%' ---CUALQUIER CARACTER DESPUES TENGA UNA U 

--- LIKE CON LISTA DE CARACTERES POR LISTAS
SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'[DF]%' ---LISTA DE CARACTERES CUALQUIER COSA QUE EMPIECE POR D O F 

--- LIKE CON LISTA DE CARACTERES POR RANGOS
SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'[C-E]%' ---POR RANGO ENTRE C Y E


--- LIKE CON LISTA DE CARACTERES EXCLUYENDO POR RANGOS
SELECT empid,firstname,lastname
From hr.Employees
where lastname LIKE N'[^C-E]%' ---Y CON EL SOMBRERO ^ DECIMOS LOS QUE NO ESTEN EN RANGO ENTRE C Y E

---MEJOR MANERA DE BUSCAR FECHAS ES CON FORMATO 'AÑOMESDIA'
SELECT orderid,orderdate,empid,custid
FROM Sales.Orders
WHERE orderdate='20070212' ---EL MOTOR CONVIERTE ESTA CADENA A DATETIME INTERNAMENTE


---OPTIMIZAR CONSULTAS FUNCION EN PREDICADO WHERE VS OPERADORES 
SELECT orderid,orderdate,empid,custid
FROM Sales.Orders
WHERE YEAR(orderdate)='2007'AND MONTH(orderdate)=2;

----ESTA QUERY ES MAS SARGABLE QUE LA DE ARRIBA CUANDO UTILIZAMOS FUNCIONES EN EL PREDICADO
SELECT orderid,orderdate,empid,custid
FROM Sales.Orders
WHERE orderdate>='20070201'AND orderdate<'20070301';

---MISMA CONSULTA AHORA CON BETWEEN NO SE RECOMEINDA TAMPOCO
SELECT orderid,orderdate,empid,custid
FROM Sales.Orders
WHERE orderdate BETWEEN '20070201' AND '20070301';

