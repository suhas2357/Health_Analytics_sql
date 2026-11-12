-- KPI 9: Readmission Detection (Multiple Visits)
-- Objective: Detect patients with more than one hospital visit, indicating potential readmissions or recurring conditions.

SELECT 
    PatientNumber,
    COUNT(*) AS total_visits
FROM facttable
GROUP BY PatientNumber
HAVING COUNT(*) > 1
ORDER BY total_visits DESC;
