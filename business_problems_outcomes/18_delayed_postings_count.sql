-- KPI 18: Delayed Postings (Post > Service Date)
-- Objective: Count how many claims were posted later than their actual service date.

SELECT 
    COUNT(*) AS delayed_claims
FROM facttable
WHERE dimDatePostPK > dimDateServicePK;
