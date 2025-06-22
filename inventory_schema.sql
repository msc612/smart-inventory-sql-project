
-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    reorder_level INT
);

-- Create inventory table
CREATE TABLE inventory (
    product_id INT,
    warehouse_id INT,
    quantity INT,
    last_updated DATE,
    PRIMARY KEY (product_id, warehouse_id)
);

-- Create stock_movements table
CREATE TABLE stock_movements (
    movement_id INT PRIMARY KEY,
    product_id INT,
    movement_type VARCHAR(10),
    quantity INT,
    movement_date DATE
);
