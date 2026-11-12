-- KPI 15: Top 10 Diagnosis by Highest AR
-- Objective: Identify diagnosis groups with the highest average AR to target high-risk or delayed reimbursements.

SELECT 
    d.DiagnosisCodeGroup,
    ROUND(AVG(f.AR), 2) AS avg_ar
FROM facttable f
JOIN dimdiagnosiscode d ON f.dimDiagnosisCodePK = d.dimDiagnosisCodePK
GROUP BY d.DiagnosisCodeGroup
ORDER BY avg_ar DESC
LIMIT 10;
