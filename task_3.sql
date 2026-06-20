/*добавьте сюда запрос для решения задания 3*/
SELECT
	r.restaurant_name, 
	COUNT(DISTINCT rmwd.manager_uuid) - 1 AS manager_changes
FROM cafe.restaurants AS r
JOIN cafe.restaurant_manager_work_dates AS rmwd USING(restaurant_uuid)
GROUP BY r.restaurant_name
ORDER BY manager_changes DESC 
LIMIT 3; 
