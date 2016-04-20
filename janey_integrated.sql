CREATE ROLE janey_is WITH LOGIN PASSWORD 'password1';

CREATE DATABASE janey_integrated OWNER = janey_is;


-- compare yard inventory to online inventory quantities
SELECT *
FROM yard_sales.inventory
JOIN online_inventory.inventory ON ( yard_sales.inventory.inventory_no = online_inventory.inventory.field )
WHERE key = 'inventory' AND
  quantity != value::int
ORDER BY inventory_no;



-- compare yard inventory to online sales cost
SELECT *
FROM yard_sales.inventory
JOIN online_sales.product ON ( yard_sales.inventory.inventory_no = online_sales.product.product_number )
WHERE
  cost  != product_cost
ORDER BY inventory_no;
