-- KPI 14: Diagnosis Groups by Claim Volume + Avg AR
-- Objective: Analyze diagnosis groups based on claim count and their average outstanding balance (AR).

SELECT 
    d.DiagnosisCodeGroup,
    COUNT(*) AS total_claims,
    ROUND(AVG(f.AR), 2) AS avg_ar
FROM facttable f
JOIN dimdiagnosiscode d ON f.dimDiagnosisCodePK = d.dimDiagnosisCodePK
GROUP BY d.DiagnosisCodeGroup
ORDER BY total_claims DESC;
