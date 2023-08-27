{{ config(materialized='view') }}             -- this is redundant, and does not need to be set explicitly

SELECT
EmployeeID,
FirstName,
LastName,
Email,
JobTitle,
HireDate,
ManagerID,
Address,
City,
State,
ZipCode,
CONCAT(FirstName, ' ', LastName) AS EmployeeName,
Updated_at
FROM
{{ source('landing', 'employees') }}
