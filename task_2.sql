/*добавьте сюда запрос для решения задания 2*/
CREATE MATERIALIZED VIEW cafe.yearly_avg_check AS
	WITH yearly_avg AS (
		SELECT
			EXTRACT(YEAR FROM date) AS year,
			restaurant_uuid,
			ROUND(AVG(avg_check), 2) AS current_avg
		FROM cafe.sales
		WHERE EXTRACT(YEAR FROM date) != 2023
		GROUP BY year, restaurant_uuid		
	),
	pre_avg_checks AS (
    	SELECT 
    		y.year,
    		r.restaurant_name,
    		r.restaurant_type, 
    		y.current_avg,
    		LAG(y.current_avg) OVER (PARTITION BY r.restaurant_name ORDER BY y.year) AS previous_avg
   		FROM yearly_avg AS y
    	JOIN cafe.restaurants AS r USING (restaurant_uuid)
    )
    SELECT 
    	year,
    	restaurant_name, 
    	restaurant_type,
    	current_avg,
    	previous_avg,
    	ROUND((current_avg - previous_avg)/ previous_avg * 100, 2) AS percentage_change
    FROM pre_avg_checks
    ORDER BY restaurant_name, year;
