-- add mysql_fdw extension to the database
CREATE EXTENSION mysql_fdw;

-- specify mysql connection details as FDW server
CREATE SERVER yard_sales_server
  FOREIGN DATA WRAPPER mysql_fdw
  OPTIONS (host '127.0.0.1', port '3306');

-- map janey_is access as mysql user jifdw
CREATE USER MAPPING FOR janey_is
  SERVER yard_sales_server
  OPTIONS (username 'jifdw', password 'password1');
CREATE USER MAPPING FOR pgsql
  SERVER yard_sales_server
  OPTIONS (username 'jifdw', password 'password1');

CREATE SCHEMA yard_sales;

-- map yard sales foreign table product
CREATE FOREIGN TABLE yard_sales.product (
  product_id INT,
  product_name VARCHAR(100),
  product_description VARCHAR(1000),
  product_number VARCHAR(32),
  product_price NUMERIC(15,2),
  -- purchasing related info
  product_added_date TIMESTAMP,
  product_cost NUMERIC(15,2),
  product_vendor VARCHAR(200)
) SERVER yard_sales_server
  OPTIONS (dbname 'janey_yard_sales', table_name 'product');


CREATE TABLE customer (
  customer_id INT NOT NULL,
  customer_first_name VARCHAR(100),
  customer_last_name VARCHAR(100),
  customer_create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  customer_address1 VARCHAR(100),
  customer_address2 VARCHAR(100),
  customer_city VARCHAR(100),
  customer_state VARCHAR(100),
  customer_zip VARCHAR(100),
  PRIMARY KEY (customer_id)
);

CREATE TABLE salesorder (
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
  salesorder_zip VARCHAR(100),
  PRIMARY KEY (salesorder_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE salesorder_product (
  salesorder_id INT NOT NULL,
  product_id INT NOT NULL,
  salesorder_product_price NUMERIC(15,2) NOT NULL,
  PRIMARY KEY (salesorder_id, product_id),
  FOREIGN KEY (salesorder_id) REFERENCES salesorder(salesorder_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);




-- select etc from table to get data from mysql
SELECT * FROM salesorder;
