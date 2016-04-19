-- add mysql_fdw extension to the database
CREATE EXTENSION mysql_fdw;

-- specify mysql connection details as FDW server
CREATE SERVER online_sales_server
  FOREIGN DATA WRAPPER mysql_fdw
  OPTIONS (host '127.0.0.1', port '3306');

-- map janey_is access as mysql user jifdw
CREATE USER MAPPING FOR janey_is
  SERVER online_sales_server
  OPTIONS (username 'jifdw', password 'password1');
CREATE USER MAPPING FOR pgsql
  SERVER online_sales_server
  OPTIONS (username 'jifdw', password 'password1');

-- schema for online_sales foreign tables
CREATE SCHEMA online_sales;

-- map online_sales foreign tables
CREATE FOREIGN TABLE online_sales.product (
  product_id INT,
  product_name VARCHAR(100),
  product_description VARCHAR(1000),
  product_number VARCHAR(32),
  product_price NUMERIC(15,2),
  -- purchasing related info
  product_added_date TIMESTAMP,
  product_cost NUMERIC(15,2),
  product_vendor VARCHAR(200)
) SERVER online_sales_server
  OPTIONS (dbname 'online_sales', table_name 'product');

CREATE FOREIGN TABLE online_sales.customer (
  customer_id INT NOT NULL,
  customer_first_name VARCHAR(100),
  customer_last_name VARCHAR(100),
  customer_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  customer_address1 VARCHAR(100),
  customer_address2 VARCHAR(100),
  customer_city VARCHAR(100),
  customer_state VARCHAR(100),
  customer_zip VARCHAR(100)
) SERVER online_sales_server
  OPTIONS (dbname 'online_sales', table_name 'customer');

CREATE FOREIGN TABLE online_sales.salesorder (
  salesorder_id INT NOT NULL,
  salesorder_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  salesorder_status VARCHAR(64) NOT NULL,
  salesorder_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  salesorder_purchase_salesorder_number VARCHAR(100),
  customer_id INT NOT NULL,
  salesorder_address1 VARCHAR(100),
  salesorder_address2 VARCHAR(100),
  salesorder_city VARCHAR(100),
  salesorder_state VARCHAR(100),
  salesorder_zip VARCHAR(100)
) SERVER online_sales_server
  OPTIONS (dbname 'online_sales', table_name 'salesorder');

CREATE FOREIGN TABLE online_sales.salesorder_product (
  salesorder_id INT NOT NULL,
  product_id INT NOT NULL
) SERVER online_sales_server
  OPTIONS (dbname 'online_sales', table_name 'salesorder_product');



-- select etc from table to get data from mysql
SELECT * FROM online_sales.product ;

SELECT * FROM online_sales.customer ;

SELECT * FROM online_sales.salesorder ;

SELECT * FROM online_sales.salesorder_product ;
