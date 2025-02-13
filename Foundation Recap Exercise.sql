/*
Foundation Recap Exercise

Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/

SELECT
    *
FROM
    PatientStay ps
;

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards

2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/

-- Write the SQL statement here
SELECT
    ps.AdmittedDate
    ,ps.DischargeDate
    ,ps.Hospital
    ,ps.Ward
    ,ps.PatientId
    ,DATEDIFF(DAY, ps.AdmittedDate,ps.DischargeDate) +1 AS LenghtofStay
FROM
    PatientStay ps
WHERE ps.Hospital IN ('Oxleas','PRUH')
    AND MONTH(ps.AdmittedDate) = 2
    AND ps.AdmittedDate BETWEEN '2024.02.01' AND '2024.02.29'
    AND ps.Ward LIKE '%Surgery'
ORDER BY ps.AdmittedDate DESC , ps.PatientId DESC







/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/

-- Write the SQL statement here

SELECT
    ps.hospital
    ,COUNT(*) AS "Count of patients"
    ,SUM(ps.Tariff) AS [TotalTariff]
FROM
    PatientStay ps
GROUP BY ps.hospital
HAVING SUM(ps.tariff) >50
ORDER BY SUM (ps.tariff) DESC

SELECT * FROM DimHospitalBad

SELECT
    ps.PatientId
    ,ps.AdmittedDate 
    ,h.Hospital
    ,ps.Hospital
    ,h.[Type]
    ,ps.Ethnicity
FROM
    PatientStay ps FULL OUTER JOIN DimHospitalBad h ON ps.hospital = h.Hospital
WHERE ps.Ethnicity is not NULL

SELECT * FROM DimHospital h

SELECT
    ps.PatientId
    ,ps.AdmittedDate 
    ,h.Hospital
    ,ps.Hospital
    ,h.[Type]
    ,ps.Ethnicity
FROM
    PatientStay ps FULL OUTER JOIN DimHospitalBad h ON ps.hospital = h.Hospital
WHERE ps.Ethnicity is not NULL


SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.DischargeDate
    ,ps.Ward
    ,ps.Hospital
    ,ps.Tariff
    ,DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) + 1 AS LengthOfStay
    ,CASE 
       WHEN ps.Tariff >=7 THEN 'High Cost' 
       WHEN ps.Tariff >=4 THEN 'Medium Cost'
       ELSE 'Low cost' END AS CostType

FROM
    PatientStay ps


SELECT
    CASE 
       WHEN ps.Tariff >=7 THEN 'High Cost' 
       WHEN ps.Tariff >=4 THEN 'Medium Cost'
       ELSE 'Low cost' END AS CostType
        ,COUNT(*) as [patients]
        , SUM(ps.tariff) as [Total Tariff]

FROM
    PatientStay ps
WHERE CASE 
       WHEN ps.Tariff >=7 THEN 'High Cost' 
       WHEN ps.Tariff >=4 THEN 'Medium Cost'
       ELSE 'Low cost' END IN ('High Cost', 'Low Cost')
GROUP BY CASE 
    WHEN ps.Tariff >=7 THEN 'High Cost' 
    WHEN ps.Tariff >=4 THEN 'Medium Cost'
    ELSE 'Low cost' END 
;

WITH
    cte
    AS
    (
        SELECT
            CASE
        WHEN ps.Tariff >= 7 THEN 'High Cost'
        WHEN ps.Tariff >= 3 THEN 'Medium Cost'
        ELSE 'Low Cost' END AS CostType
        ,ps.Tariff
        FROM
            PatientStay ps
    )
SELECT
    cte.CostType
    ,COUNT(*) AS NumPatients
    , SUM(cte.Tariff) as Totaltariff
FROM
    cte
    WHERE cte.CostType IN ('high cost', 'Low Cost')
GROUP BY cte.CostType

