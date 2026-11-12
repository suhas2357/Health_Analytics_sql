-- KPI 20: Diagnosis with Most Adjustments
-- Objective: Identify diagnosis groups associated with the highest total adjustments.

SELECT 
    DiagnosisCodeGroup,
    ROUND(SUM(Adjustment), 2) AS total_adjustments
FROM facttable f
JOIN dimdiagnosiscode d ON f.dimDiagnosisCodePK = d.dimDiagnosisCodePK
GROUP BY DiagnosisCodeGroup
ORDER BY total_adjustments DESC
LIMIT 10;
