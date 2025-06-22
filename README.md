
# Smart Inventory Management: Warehouse Optimization with SQL

## Overview
This project simulates a real-world inventory management scenario, using SQL to analyze stock levels, reorder needs, product movement, and warehouse performance. It demonstrates how data analysts can apply SQL to optimize supply chain decisions and prevent overstocking or stockouts.

## What's Included
- `inventory_schema.sql` – Table definitions for `products`, `inventory`, and `stock_movements`
- `inventory_queries.sql` – Analytical SQL queries with business logic
- `products.csv`, `inventory.csv`, `stock_movements.csv` – Sample datasets
- `preview.png` – Visual project cover image

## Key Business Questions Answered
- What products are below their reorder threshold?
- Which items are fast or slow movers?
- What products haven’t moved in 60+ days?
- What’s the reorder status across all items?
- What is the current inventory by product?

## Tech Stack
- PostgreSQL
- pgAdmin
- SQL
- CSV
- Markdown

## Sample SQL Queries

### Products Below Reorder Level
```sql
SELECT 
  p.product_name,
  SUM(i.quantity) AS total_stock,
  p.reorder_level
FROM products p
JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_name, p.reorder_level
HAVING SUM(i.quantity) < p.reorder_level;
```

### Fastest-Moving Products (Last 30 Days)
```sql
SELECT 
  p.product_name,
  SUM(CASE WHEN s.movement_type = 'OUT' THEN s.quantity ELSE 0 END) AS total_moved_out
FROM products p
JOIN stock_movements s ON p.product_id = s.product_id
WHERE s.movement_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY p.product_name
ORDER BY total_moved_out DESC
LIMIT 5;
```

## Use Cases
Ideal for showcasing SQL data analysis skills in:
- Inventory/warehouse analytics
- Supply chain optimization
- Operational dashboards
- Entry-level or mid-level data analyst portfolios
