/*добавьте сюда запрос для решения задания 4*/
SELECT 
	restaurant_name,
	nr_of_pizzas
FROM (
	SELECT
		r.restaurant_name, 
		COUNT(*) AS nr_of_pizzas,
		DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS ranked
	FROM cafe.restaurants AS r,
		jsonb_each_text(r.menu -> 'Пицца') 
	WHERE r.restaurant_type = 'pizzeria'
	GROUP BY r.restaurant_name
) AS p
WHERE ranked = 1
ORDER BY restaurant_name;
