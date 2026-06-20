/*добавьте сюда запрос для решения задания 1*/
CREATE VIEW cafe.top_spots AS 

WITH 
avg_check AS (
	SELECT 
		ROUND(AVG(avg_check),2) AS avg_check,
		restaurant_uuid
	FROM cafe.sales
	GROUP BY restaurant_uuid
),

selected_rests AS ( 
	SELECT 
		r.restaurant_name,
		r.restaurant_type,
		ac.avg_check,
		ROW_NUMBER() OVER(PARTITION BY restaurant_type ORDER BY ac.avg_check DESC) AS row_rests
	FROM avg_check AS ac
	JOIN cafe.restaurants AS r USING (restaurant_uuid)
)

SELECT 
	restaurant_name, 
	restaurant_type,
	avg_check
FROM selected_rests
WHERE row_rests <= 3;
