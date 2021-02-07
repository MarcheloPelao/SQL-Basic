---INNER JOIN
SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
FROM Production.Suppliers as S 
INNER JOIN Production.Products as P 
ON S.supplierid=P.supplierid
WHERE S.country =N'Japan';

SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
FROM Production.Suppliers as S 
INNER JOIN Production.Products as P 
ON S.supplierid=P.supplierid AND S.country =N'Japan';

--query para buscar al jefe de la misma tabla 
SELECT E.empid,
E.firstname+N' '+E.lastname as emp,
M.firstname+N' '+M.lastname as mgr
FROM HR.Employees AS E
INNER JOIN HR.Employees AS M
ON E.mgrid=M.empid;

---MISMA CONSULTA QUE ANTERIOR PERO CON UN LEFT OUTER JOIN NO ELIMINA REGISTROS COMO EL INNER JOIN SIN EMBARGO LOS COLOCA NULOS CUANDO NO CUMPLE LA CONDICION
SELECT E.empid,
E.firstname+N' '+E.lastname as emp,
M.firstname+N' '+M.lastname as mgr
FROM HR.Employees AS E
LEFT OUTER JOIN HR.Employees AS M
ON E.mgrid=M.empid;


---RIGHT OUTER JOIN toma los de la derecha y si los de la izquierda no están los deja nulls 
SELECT E.empid,
E.firstname+N' '+E.lastname as emp,
M.firstname+N' '+M.lastname as mgr
FROM HR.Employees AS E
RIGHT OUTER JOIN HR.Employees AS M
ON E.mgrid=M.empid;

---LEFT OUTER JOIN
SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
FROM Production.Suppliers as S 
LEFT OUTER JOIN Production.Products as P 
ON S.supplierid=P.supplierid
WHERE S.country =N'Japan';

---está query es distinta a la de arriba ya que trae todo lo de la tabla pero como no hace match con japan los deja en blanco los campos.
SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
FROM Production.Suppliers as S 
LEFT OUTER JOIN Production.Products as P 
ON S.supplierid=P.supplierid and S.country =N'Japan';

---MAS DE UN JOIN ENTRE TABLAS

SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
,C.categoryname
FROM Production.Suppliers as S 
LEFT OUTER JOIN Production.Products as P
ON S.supplierid=P.supplierid
INNER JOIN Production.Categories AS C 
ON C.categoryid=P.categoryid
WHERE S.country=N'Japan';

---JOIN CON PRECEDENCIA ()
SELECT
S.companyname as supplier
,S.country
,P.productid
,P.productname
,P.unitprice
,C.categoryname
FROM Production.Suppliers as S 
LEFT OUTER JOIN (Production.Products as P
INNER JOIN Production.Categories AS C 
ON C.categoryid=P.categoryid)--CON ESTO LE DAMOS PRECEDENCIA AL INNER JOIN PARA QUE LO EJECUTE ANTES DEL LEFT 
ON S.supplierid=P.supplierid
WHERE S.country=N'Japan';
