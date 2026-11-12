-- KPI 17: Hospitals with Highest Patients
-- Objective: Identify hospitals serving the highest number of unique patients and their total associated costs.

SELECT 
    h.LocationName,
    COUNT(DISTINCT f.dimPatientPK) AS unique_patients,
    ROUND(SUM(f.Gross_Expenses), 2) AS total_cost
FROM facttable f
JOIN dimhospital h ON f.dimLocationPK = h.dimLocationPK
GROUP BY h.LocationName
ORDER BY unique_patients DESC;
