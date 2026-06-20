/*добавьте сюда запрос для решения задания 5*/
WITH menu_cte AS (
	SELECT
		r.restaurant_name, 
		'Пицца' AS meal_type,
		pizza.key AS pizza_name,
		pizza.value::INT AS pizza_price
	FROM cafe.restaurants AS r,
		jsonb_each_text(r.menu -> 'Пицца') AS pizza
	WHERE r.restaurant_type = 'pizzeria'
),
menu_with_rank AS (
	SELECT 
		restaurant_name,
		meal_type,
		pizza_name,
		pizza_price,
		ROW_NUMBER() OVER(PARTITION BY restaurant_name ORDER BY pizza_price DESC) AS ranged_pizza
	FROM menu_cte
)
SELECT 
	restaurant_name,
	meal_type,
	pizza_name,
	pizza_price
FROM menu_with_rank
WHERE ranged_pizza = 1
ORDER BY restaurant_name;
