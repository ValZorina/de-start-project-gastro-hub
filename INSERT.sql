/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
INSERT INTO cafe.restaurants (restaurant_name, menu, restaurant_type)
SELECT DISTINCT 
	rs.cafe_name, 
	rm.menu,
	rs.type::cafe.restaurant_type
FROM raw_data.sales AS rs
LEFT JOIN raw_data.menu AS rm USING (cafe_name);

INSERT INTO cafe.managers (manager_name, manager_phone)
SELECT DISTINCT
	manager,
	manager_phone
FROM raw_data.sales rs;

INSERT INTO cafe.restaurant_manager_work_dates (restaurant_uuid, manager_uuid, first_day, last_day)
SELECT
	r.restaurant_uuid,
	m.manager_uuid,
	MIN(rs.report_date) AS first_day,
	MAX(rs.report_date) AS last_day
FROM raw_data.sales AS rs
JOIN cafe.restaurants AS r ON r.restaurant_name = rs.cafe_name
JOIN cafe.managers AS m ON m.manager_name = rs.manager
	AND m.manager_phone = rs.manager_phone
GROUP BY r.restaurant_uuid, m.manager_uuid;

INSERT INTO cafe.sales (date, restaurant_uuid, avg_check)
SELECT
	rs.report_date,
	r.restaurant_uuid,
	rs.avg_check
FROM raw_data.sales AS rs
JOIN cafe.restaurants AS r ON r.restaurant_name = rs.cafe_name;
