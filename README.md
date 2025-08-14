# Finance Intelligence Suite — SQL Layer

This repository contains the SQL layer that powers the **Finance Intelligence Suite** in Power BI.  
It models operational data staged in a **relational database** into conformed dimensions and two fact streams—**Milestones** and **Subscriptions**—and exposes them as reusable SQL views for analytics.

---

## Overview

- **Goal:** Provide a clean, queryable semantic layer for revenue recognition, cost attribution, and payment behavior analysis.  
- **Scope:** Conformed dimensions (Customers, Products, Contracts/Projects, Parts) + two fact streams (Milestones, Subscriptions).  
- **Outputs:** SQL views designed for direct consumption by **Power BI** (Import or DirectQuery).

---

## Data Preparation Summary

Operational data is staged in a relational database, then standardized into conformed dimensions (Customers, Products, Contracts/Projects, Parts) and two fact streams (Milestones and Subscriptions). Modeling is delivered via SQL views consumed by Power BI:

- **`vw_orders_details`** — Order–project–product grain that enriches orders with **customer & product segments** and **aggregates milestone revenue/cost** by joining `order_details` → `contract_master` (project→contract), `product_list` (product→segment), `customer_list` (customer_number), and `milestone_tracking` (project_id & product_id), with grouping on order, project, product, and `date_sold`.  
- **`vw_milestone_tracking`** — Milestone **line-level** fact with **part catalog** and **product** enrichment, linked back to valid orders; exposes `cost`, `revenue`, `milestone_date`, and `cost_line_item` for performance-obligation analysis.  
- **`vw_pmts_milestones`** — Normalized **invoicing/payment** events (terms, due amounts, received amounts) joined to customer segments; filtered to classified customers for stable payment-behavior metrics.  
- **`vw_product_details`** — Product dimension **enriched with cost line-item mapping** (product×segment → cost_line_item) to support cost attribution.  
- **`vw_subscription_tracking`** — Monthly **subscription stream** with date normalization, product/part enrichment, and order linkage; exposes `monthly_revenue` and `monthly_cost`.

Together these views form a star-style semantic layer that separates **milestone (ASC 606)** and **subscription** revenue, enabling contract-level drilldowns, segment slicing, cost mapping, and payment-timing analytics in Power BI.

---

## View Catalog (Concise)

- **`vw_orders_details`** — Order grain + customer & product segments + milestone revenue/cost aggregation.  
- **`vw_milestone_tracking`** — Milestone facts with part/product enrichment; suitable for performance-obligation detail.  
- **`vw_pmts_milestones`** — Payments and invoicing joined to segments; supports payment-timing analysis.  
- **`vw_product_details`** — Product dimension with cost line-item mapping for attribution.  
- **`vw_subscription_tracking`** — Monthly subscription facts with normalized dates and product/part linkage.

---


