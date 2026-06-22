-- Phase 10: Real-World Case Studies (Loss-to-Revenue Reconciliation Query)
-- Joins logs, handles unmonetized rows, tiers traffic health, and catches leakages over 10%

SELECT 
    PR.publisher_id,
    PR.geo_region,
    COUNT(PR.auction_id) AS total_ad_requests,
    COUNT(ASI.impression_id) AS logged_impressions,
    
    -- Phase 3: Data Cleaning fallback for unrendered impressions
    COALESCE(ASI.log_status, 'Dropped Bid / No Render') AS clean_delivery_status,
    
    -- Phase 4: Conditional Logic to bucket supply health row-by-row
    CASE 
        WHEN COUNT(ASI.impression_id) = 0 THEN 'High Leakage/Tag Malfunction'
        WHEN COUNT(ASI.impression_id) < COUNT(PR.auction_id) * 0.90 THEN 'At Risk (Low Fill Rate)'
        ELSE 'Optimized Supply Tier'
    END AS inventory_health_tier,
    
    -- Diagnostic Metric: Quantifying exact percentage gap of lost supply revenue
    ((COUNT(PR.auction_id) - COUNT(ASI.impression_id)) * 100.0 / COUNT(PR.auction_id)) AS l2r_discrepancy_rate

FROM Publisher_Requests PR
-- Phase 2: LEFT JOIN guarantees we retain missing match items for investigation
LEFT JOIN Ad_Server_Impressions ASI 
    ON PR.auction_id = ASI.auction_id

GROUP BY 
    PR.publisher_id, 
    PR.geo_region,
    ASI.log_status

-- Case Study 2: Isolate inventory segments bleeding cash above 10% operational threshold
HAVING ((COUNT(PR.auction_id) - COUNT(ASI.impression_id)) * 100.0 / COUNT(PR.auction_id)) > 10.0

ORDER BY l2r_discrepancy_rate DESC;
