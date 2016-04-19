CREATE ROLE janey_is WITH LOGIN PASSWORD 'password1';

CREATE DATABASE janey_integrated OWNER = janey_is;

-- psql -U janey_is janey_integrated
