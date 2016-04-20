-- add redis_fdw extension to the database
CREATE EXTENSION redis_fdw;

-- specify redis connection details as FDW server
CREATE SERVER online_inventory_server
  FOREIGN DATA WRAPPER redis_fdw 
  OPTIONS (host '127.0.0.1', port '6379');

-- map public access to specify redis password
CREATE USER MAPPING FOR PUBLIC
  SERVER online_inventory_server
  OPTIONS (password 'janeyg1');

-- schema for online_inventory foreign tables
CREATE SCHEMA online_inventory;

-- map inventory hash table as a foreign table
CREATE FOREIGN TABLE online_inventory.inventory (
  key    TEXT,
  field  TEXT,
  value  TEXT,
  expiry INT
) SERVER online_inventory_server
  OPTIONS (tabletype 'hash');


-- select etc from table to get data from redis
-- NOTE: you must specify WHERE key for fdw to be able to pull the hash list data
SELECT * FROM online_inventory.inventory where key = 'inventory';
