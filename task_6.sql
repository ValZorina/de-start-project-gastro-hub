/*добавьте сюда запросы для решения задания 6*/
BEGIN;

SELECT restaurant_uuid
FROM cafe.restaurants
WHERE menu -> 'Кофе' ? 'Капучино'
FOR UPDATE;

UPDATE cafe.restaurants
SET menu = jsonb_set(
    menu,
    '{Кофе,Капучино}',
    ROUND((menu -> 'Кофе' ->> 'Капучино')::NUMERIC * 1.2)::TEXT::jsonb
)
WHERE menu -> 'Кофе' ? 'Капучино';

COMMIT;
