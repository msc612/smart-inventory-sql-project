
-- 1. Products Below Reorder Level
SELECT 
  p.product_name,
  SUM(i.quantity) AS total_stock,
  p.reorder_level
FROM products p
JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_name, p.reorder_level
HAVING SUM(i.quantity) < p.reorder_level;

-- 2. Fastest-Moving Products (Last 30 Days)
SELECT 
  p.product_name,
  SUM(CASE WHEN s.movement_type = 'OUT' THEN s.quantity ELSE 0 END) AS total_moved_out
FROM products p
JOIN stock_movements s ON p.product_id = s.product_id
WHERE s.movement_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY p.product_name
ORDER BY total_moved_out DESC
LIMIT 5;

-- 3. Slow-Moving Products (No Movement in 60+ Days)
SELECT 
  p.product_name
FROM products p
WHERE p.product_id NOT IN (
  SELECT DISTINCT product_id
  FROM stock_movements
  WHERE movement_date >= CURRENT_DATE - INTERVAL '60 days'
);

-- 4. Reorder Flag by Product
SELECT 
  p.product_name,
  SUM(i.quantity) AS total_stock,
  p.reorder_level,
  CASE 
    WHEN SUM(i.quantity) < p.reorder_level THEN 'Reorder'
    ELSE 'Sufficient'
  END AS status
FROM products p
JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_name, p.reorder_level;

-- 5. Current Inventory by Product
SELECT 
  p.product_name,
  SUM(i.quantity) AS total_stock
FROM products p
JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_name
ORDER BY total_stock DESC;
