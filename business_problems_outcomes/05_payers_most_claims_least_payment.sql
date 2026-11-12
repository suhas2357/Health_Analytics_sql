-- KPI 5: Payers with Most Claims but Least Payment
-- Objective: Identify payers who handle the most claims but contribute the least financially.

SELECT 
    PayerName,
    COUNT(*) AS total_claims,
    ROUND(SUM(Insurance_Payment), 2) AS total_paid
FROM facttable f
JOIN dimpayer p ON f.dimPayerPK = p.dimPayerPK
GROUP BY PayerName
ORDER BY total_claims DESC, total_paid ASC
LIMIT 10;