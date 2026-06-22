# programmatic-adops-l2r-audit
# Programmatic Yield Optimization & Loss-to-Revenue (L2R) Data Audit

## 📌 Project Overview
In programmatic advertising supply chains, systemic tracking mismatches, unrendered creatives, and invalid traffic (IVT) drop fill rates, leading to substantial **Loss-to-Revenue (L2R)** leakage. 

This repository contains an end-to-end relational SQL data auditing pipeline engineered to ingest large-scale programmatic ad server logs, reconcile publisher auction requests against logged ad server impressions, and isolate system discrepancies exceeding standard operational thresholds (>10%).

---

## 🏢 Business Problem Context
A portfolio of premium publisher domains experienced an intermittent drop in Revenue Per Mille (RPM) alongside severe inventory fill rate degradation. Because downstream ad server logs were disconnected from initial upstream auction records, internal business intelligence dashboards could not isolate the root causes of the leakage. 

This project bridges that programmatic visibility gap by standardizing delivery logging and quantifying exactly where financial value is dropping out of the auction cycle.

---

## 🛠️ Tech Stack & Database Architecture
- **Language:** SQL (Structured Query Language)
- **Concepts Applied:** Relational Database Design, Referential Integrity Constraints, Multi-table Joins, Data Cleaning & Type Formatting, Conditional Analytics, Aggregate Metrics Filtering.

The structural foundation relies on two core production tables enforcing relational rules:
1. `Publisher_Requests`: Captures all incoming supply-side ad requests.
2. `Ad_Server_Impressions`: Logs real-time display and ad render responses.
