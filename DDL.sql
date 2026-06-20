/*Добавьте в этот файл все запросы, для создания схемы сafe и
 таблиц в ней в нужном порядке*/
CREATE SCHEMA IF NOT EXISTS cafe;

CREATE TYPE cafe.restaurant_type AS ENUM
	('coffee_shop', 'restaurant', 'bar', 'pizzeria');

CREATE TABLE cafe.restaurants(
	restaurant_uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
	restaurant_name VARCHAR NOT NULL,
	menu JSONB,
	restaurant_type cafe.restaurant_type
	);

CREATE TABLE cafe.managers (
	manager_uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	manager_name TEXT NOT NULL,
	manager_phone VARCHAR
);

CREATE TABLE cafe.restaurant_manager_work_dates (
	restaurant_uuid UUID,
	manager_uuid UUID, 
	first_day DATE NOT NULL, 
	last_day DATE,
	PRIMARY KEY (restaurant_uuid, manager_uuid)
);

CREATE TABLE cafe.sales (
	date DATE NOT NULL, 
	restaurant_uuid UUID, 
	avg_check NUMERIC(10,2) NOT NULL,
	PRIMARY KEY (date, restaurant_uuid)
);
