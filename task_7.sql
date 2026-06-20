/*добавьте сюда запросы для решения задания 6*/
LOCK TABLE cafe.managers IN SHARE MODE;

ALTER TABLE cafe.managers ADD COLUMN manager_phone_upd VARCHAR[];

UPDATE cafe.managers
SET manager_phone_upd = ARRAY[
    CONCAT('8-800-2500-', ROW_NUMBER() OVER (ORDER BY manager_name) + 99),
    manager_phone
];

ALTER TABLE cafe.managers DROP COLUMN manager_phone;

COMMIT;
