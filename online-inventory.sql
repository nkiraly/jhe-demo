CREATE EXTENSION redis_fdw;


CREATE SERVER online_inventory
  FOREIGN DATA WRAPPER redis_fdw 
  OPTIONS (host '127.0.0.1', port '6379');


CREATE USER MAPPING FOR PUBLIC
  SERVER online_inventory
  OPTIONS (password 'janeyg1');


CREATE FOREIGN TABLE online_inventory_rft_hash (
  key    TEXT,
  field  TEXT,
  value  TEXT,
  expiry INT
) SERVER online_inventory
  OPTIONS (tabletype 'hash');


SELECT * FROM online_inventory_rft_hash;
