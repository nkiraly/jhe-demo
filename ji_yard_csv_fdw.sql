-- add file_fdw extension to the database
CREATE EXTENSION file_fdw;

-- specify file_fdw server object
CREATE SERVER yard_sales_csv_server
  FOREIGN DATA WRAPPER file_fdw;

-- schema for yard sales foreign tables
CREATE SCHEMA yard_sales;

-- map yard sales CSV as a foreign table
CREATE FOREIGN TABLE yard_sales.sales (
  saledate      date,
  customer      varchar(100),
  saleprice     NUMERIC(15,2),
  item          varchar(100),
  description   varchar(200)
) SERVER yard_sales_csv_server
OPTIONS ( filename '/home/vagrant/yard-sales.csv', format 'csv' );


CREATE FOREIGN TABLE yard_sales.inventory (
  inventory_no  varchar(50),
  product_group varchar(100),
  product_name  varchar(100),
  cost          NUMERIC(15,2),
  quantity      integer,
  reorder       integer,
  last_ordered  timestamp with time zone
) SERVER yard_sales_csv_server
OPTIONS ( filename '/home/vagrant/yard-inventory.csv', format 'csv' );


-- select etc from table to get data from CSV files

SELECT * FROM yard_sales.sales;

SELECT * FROM yard_sales.inventory;
