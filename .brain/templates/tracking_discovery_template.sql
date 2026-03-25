-- Tracking Discovery Template
-- Kiểm tra tables & columns tồn tại cho evaluate_tracking kit

-- Step 1: Discovery tables & columns
SELECT
  '{project_id}' AS project_id,
  table_name,
  column_name
FROM `{org_prefix}.{project_id}_CACHED_Events_02.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name IN ({event_names_uppercase_list})
ORDER BY table_name, column_name;

-- Step 2: Row counts per event
SELECT '{project_id}' AS project_id, '{EVENT_NAME}' AS event, COUNT(*) AS row_count
FROM `{org_prefix}.{project_id}_CACHED_Events_02.{EVENT_NAME}`
WHERE event_date >= "{start_date}";

-- Step 3: Param values (chạy cho từng event)
SELECT {params_columns_list}, COUNT(*) AS cnt
FROM `{org_prefix}.{project_id}_CACHED_Events_02.{EVENT_NAME}`
WHERE event_date >= "{start_date}"
GROUP BY {params_columns_group_by}
ORDER BY cnt DESC;
