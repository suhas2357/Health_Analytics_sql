-- KPI 19: Avg CPT Units by Procedure Type
-- Objective: Analyze average number of CPT units billed by procedure type to understand intensity or frequency of services.

SELECT 
    CptGrouping,
    ROUND(AVG(CPTUnits), 2) AS avg_units
FROM facttable f
JOIN dimcptcode c ON f.dimCPTCodePK = c.dimCPTCodePK
GROUP BY CptGrouping
ORDER BY avg_units DESC;
