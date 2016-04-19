-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'password1';
-- CREATE DATABASE janey_yard_sales; USE janey_yard_sales;
-- CREATE USER 'jifdw'@'localhost' IDENTIFIED BY 'password1';
-- GRANT ALL ON janey_yard_sales.* TO 'jifdw'@'localhost';

CREATE TABLE product (
  product_id INT NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  product_description VARCHAR(1000),
  product_number VARCHAR(32) NOT NULL,
  product_price NUMERIC(15,2) NOT NULL,
  -- purchasing related info
  product_added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  product_cost NUMERIC(15,2) NOT NULL,
  product_vendor VARCHAR(200),
  PRIMARY KEY (product_id)
);

CREATE TABLE product_group (
  product_group_id INT NOT NULL,
  product_group_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (product_group_id)
);

CREATE TABLE product_group_product (
  product_group_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (product_group_id, product_id),
  FOREIGN KEY (product_group_id) REFERENCES product_group(product_group_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

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



INSERT INTO product ( product_id, product_name, product_number, product_price, product_cost ) VALUES ( 201, 'Hydraulic Box Stacker', 'BSH72', 309.95, 248.00 );
INSERT INTO product ( product_id, product_name, product_number, product_price, product_cost ) VALUES ( 204, 'Crush Proof Baby Crib', 'BCCP39', 224.95, 179.00 );

INSERT INTO product_group ( product_group_id, product_group_name ) VALUES ( 501, 'Box Stackers' );
INSERT INTO product_group ( product_group_id, product_group_name ) VALUES ( 504, 'Baby Furniture' );

INSERT INTO product_group_product ( product_group_id, product_id ) VALUES ( 501, 201 );
INSERT INTO product_group_product ( product_group_id, product_id ) VALUES ( 504, 204 );


INSERT INTO customer ( customer_id, customer_first_name, customer_last_name, customer_address1, customer_city, customer_state, customer_zip ) VALUES ( 1001, 'John', 'Johnson', '1234 Local Road', 'Anytown', 'PA', '15003' );

INSERT INTO salesorder ( salesorder_id, customer_id, salesorder_status ) VALUES ( 3001, 1001, 'NEW' );

INSERT INTO salesorder_product ( salesorder_id, product_id, salesorder_product_price ) VALUES ( 3001, 204, 224.95 );
