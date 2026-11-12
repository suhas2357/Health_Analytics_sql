-- KPI 1: Top CPT Codes by Total Expenses
-- Objective: Identify top healthcare procedures by total cost and cost contribution to overall expenses.

SELECT 
    CptDesc,
    SUM(CPTUnits) AS total_units,
    SUM(Gross_Expenses) AS total_cost,
    ROUND(SUM(Gross_Expenses)::numeric / NULLIF(SUM(CPTUnits), 0), 2) AS avg_cost_per_unit,
    ROUND(SUM(Gross_Expenses) * 100.0 / SUM(SUM(Gross_Expenses)) OVER (), 2) AS cost_percent
FROM facttable f
JOIN dimcptcode c ON f.dimCPTCodePK = c.dimCPTCodePK
GROUP BY CptDesc
ORDER BY total_cost DESC
LIMIT 10;