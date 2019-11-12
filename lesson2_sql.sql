CREATE DATABASE example;
USE example;

CREATE TABLE IF NOT EXISTS users (
	id SERIAL,
	name VARCHARACTER(255) not NULL UNIQUE
);

CREATE DATABASE sample;

--  в консоли :

-- mysqldump -u root -p example > example.sql

-- mysql -u root -p sample < example.sql