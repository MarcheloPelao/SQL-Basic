--FUNCION COALESCE= isnull PARA ENCONTRAR VACIOS Y REEMPLAZARLOS

SELECT TOP (1000) [empid]
      ,[lastname]
      ,[firstname]
      ,[title]
      ,[titleofcourtesy]
      ,[birthdate]
      ,[hiredate]
      ,[address]
      ,[city]
      ,COALESCE([region],'VACIA') AS Region
      ,[postalcode]
      ,[country]
      ,[phone]
      ,[mgrid]
  FROM [HR].[Employees];

 
---FUNCIONES DE TIEMPO

---FUNCION DE TRANSAC SQL PARA DAR EL DÍA Y LA HORA GETDATE()
SELECT GETDATE()

SELECT CURRENT_TIMESTAMP --ES LO MISMO PERO EN STANDAR ANSI

---FUNCION AÑO
SELECT YEAR(CURRENT_TIMESTAMP) 

SELECT YEAR(birthdate) as birthdate
FROM HR.Employees

---DATENAME
SELECT YEAR(birthdate) as birthdate, MONTH(birthdate) as birthdate_Month, DATENAME(MONTH,birthdate) as Name_Month
FROM HR.Employees

---DATEADD ( le agrega un mes al campo que escogamos)

SELECT birthdate,DATEADD(MONTH,1,birthdate) AS Mas_un_Mes
FROM HR.Employees

---DATEDIFF
SELECT [birthdate]
,CURRENT_TIMESTAMP as Fecha_hoy
, DATEDIFF(DAY,birthdate
,CURRENT_TIMESTAMP) as Dias_transcurridos
, DATEDIFF(YEAR,birthdate
,CURRENT_TIMESTAMP) as años_transcurridos
FROM HR.Employees

---CAST CAMBIAR FORMATO DEL DATO

SELECT [birthdate]
FROM HR.Employees

SELECT CAST(birthdate as date) as Fecha
FROM HR.Employees

SELECT CAST(birthdate as time) as Hora
FROM HR.Employees


---FUNCION EN TRANSAC SQL SIMIL DE CAST
SELECT CONVERT(date,birthdate)
FROM HR.Employees

---CONCATENAR
SELECT empid,country,region,city,
country+','+region+','+city+','
FROM HR.Employees

SELECT empid,country,region,city,
CONCAT(country,',',region,',',city,',')
FROM HR.Employees

---FUNCION CHARINDEX
SELECT empid,country,region,city,
country+','+region+','+city+',',CHARINDEX('s',country) as SPOSITION
FROM HR.Employees


---FUNCION LEFT
SELECT lastname,LEFT(lastname,CHARINDEX('E',lastname)) as corte_hasta_E ---corta desde la izquierda hasta encontrar la e
FROM HR.Employees


---FUNCION RIGHT LO MISMO QUE ANTES PERO DESDE LA DERECHA

SELECT lastname,RIGHT(lastname,CHARINDEX('E',lastname)) as corte_hasta_E ---corta desde la la derecha cuando encuentra la primera E hasta el final
FROM HR.Employees

---FUNCION REPLACE
SELECT lastname,REPLACE(lastname,'E','#')as remplazar ---REEMPLAZA LA 'E' POR #
FROM HR.Employees

---FUNCION REPLACE
SELECT lastname,REPLACE(lastname,'ME','##')as remplazar ---TAMBIEN UNA CADENA
FROM HR.Employees

---FUNCION LEN
SELECT lastname,LEN(lastname) AS LARGO
FROM HR.Employees

---FUNCION DATALENGTH
SELECT lastname,LEN(lastname) AS LARGO,DATALENGTH(lastname) AS NUMERO_BYTES
FROM HR.Employees


---FUNCION REPLICATE
SELECT lastname,LEN(lastname) AS LARGO,DATALENGTH(lastname) AS NUMERO_BYTES, REPLICATE('0',10) as repetir
FROM HR.Employees


---FUNCION UPPER
SELECT lastname,UPPER(lastname) AS MAYUSCULA
FROM HR.Employees


---FUNCION LOWER
SELECT lastname,LOWER(lastname) AS MAYUSCULA
FROM HR.Employees



---FUNCION LTRIM
SELECT lastname,'    '+lastname AS ESPACIOS, LTRIM('    '+lastname) as quitar ---quita los espacios desde la izquiierda
FROM HR.Employees

---FUNCION RTRIM
SELECT lastname,'    '+lastname AS ESPACIOS, RTRIM('    '+lastname) as quitar ---quita los espacios desde la DERECHA
FROM HR.Employees


---FUNCION TRIM
SELECT lastname,'    '+lastname AS ESPACIOS, TRIM('    '+lastname) as quitar ---quita los espacios A AMBOS LADOS
FROM HR.Employees


---FUNCION CASE (PARA EVALUAR UN CAMPO)
SELECT productid,productname,unitprice,discontinued,
CASE discontinued
when 0 then 'no'
when 1 then 'si'
else 'Unknow'
END as discontinued_desc
FROM Production.Products;


---FUNCION CASE (PARA EVALUAR UN CAMPO)
SELECT productid,productname,unitprice,discontinued,
CASE 
when unitprice <20.00 then 'low'
when unitprice <40.00 then 'medium'
when unitprice >=40.00 then 'high'
else 'Unknow'
END as PriceRange
FROM Production.Products;

---FUNCION CASE (PARA EVALUAR UN CAMPO)
SELECT productid,productname,unitprice,discontinued,
CASE 
when unitprice <20.00 and productname= 'Product HHYDP' then 'ubber low'
when unitprice <20.00 then 'low'
when unitprice <40.00 then 'medium'
when unitprice >=40.00 then 'high'
else 'Unknow'
END as PriceRange
FROM Production.Products;

---FUNCION nullif / coalesce FUNCIONNAN MAS RAPIDO QUE UN CASE, EL CASE ES LA COMBINACION DE ESTAS DOS FUNCIONES

SELECT nullif(productid,1) --busca el valor 1 y ponle null
FROM Production.Products;

SELECT coalesce(nullif(productid,1),1000) --busca un null y reemplazalo por 1000
FROM Production.Products;



