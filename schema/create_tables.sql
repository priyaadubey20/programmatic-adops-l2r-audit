-- Phase 11: Database Design & Architecture
-- Enforces structural referential integrity between upstream auctions and downstream delivery logs

CREATE TABLE Publisher_Requests (
    auction_id VARCHAR(50) PRIMARY KEY,
    publisher_id VARCHAR(50) NOT NULL,
    geo_region VARCHAR(10) NOT NULL,
    estimated_revenue DECIMAL(10,4) DEFAULT 0.0000
);

CREATE TABLE Ad_Server_Impressions (
    impression_id VARCHAR(50) PRIMARY KEY,
    auction_id VARCHAR(50) NOT NULL,
    log_status VARCHAR(50),
    FOREIGN KEY (auction_id) REFERENCES Publisher_Requests(auction_id)
);
