SELECT country,YEAR(hiredate) as yearhired,COUNT(*) AS numemployees
FROM HR.Employees
WHERE hiredate >= '20030101'
GROUP BY country, YEAR(hiredate)
HAVING COUNT(*) > 1
ORDER BY country, yearhired DESC;

SELECT GETDATE()

SELECT 4+4+8

CREATE TABLE HR.EmployeeTest
(
    IdEmployee INT IDENTITY (1,1) NOT NULL,
    [Name] VARCHAR(10)
)

INSERT INTO HR.EmployeeTest
