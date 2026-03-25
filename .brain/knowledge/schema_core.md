# SCHEMA CORE - BIG QUERY TABLES

**Project ID:** `[ĐIỀN_PROJECT_ID]`
**Org Dataset Prefix:** `[ĐIỀN_ORG_PREFIX]`

> Hướng dẫn: Điền schema các BigQuery tables chính mà bạn dùng thường xuyên nhất.
> Mỗi table ghi rõ: tên đầy đủ, columns, types, và ví dụ values.

---

## 1. [TÊN TABLE 1 — vd: AD TRACKING]

**Table:** `[org_prefix].[project_id]_[DATASET].[TABLE_NAME]`

| Column | Type | Description | Example |
|--------|------|-------------|---------|
| `user_pseudo_id` | STRING | Firebase anonymous user ID | `ABC123XYZ` |
| `event_date` | DATE | Partition key (YYYYMMDD) | `20260114` |
| `event_timestamp` | INT64 | Unix timestamp (microseconds) | `1736841600000000` |
| ... | ... | ... | ... |

---

## 2. [TÊN TABLE 2 — vd: SCREEN TRACKING]

**Table:** `[org_prefix].[project_id]_[DATASET].[TABLE_NAME]`

| Column | Type | Description | Example |
|--------|------|-------------|---------|
| ... | ... | ... | ... |

---

## 3. [TÊN TABLE 3 — vd: FEATURE TRACKING]

**Table:** `[org_prefix].[project_id]_[DATASET].[FEATURE_NAME_UPPERCASE]`

**Base Columns** (luôn có): `user_pseudo_id`, `event_date`, `event_timestamp`, `version`, `number_day_install`, `params_session_number`
**Feature-Specific Columns:** Bắt đầu bằng `params_*`, khác nhau theo table.

**Discover feature params:**
```sql
SELECT column_name
FROM `[org_prefix].[project_id]_[DATASET].INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = '[FEATURE_NAME_UPPERCASE]'
  AND STARTS_WITH(column_name, 'params_')
```

---

## 4. JOIN STRATEGIES

- **Event-to-Event:** JOIN trên `user_pseudo_id`, dùng `event_timestamp` để match timeline
- **Cross-table user mapping:** Dùng `[user_id_mapping_table]` để map IDs
- **Temporal proximity:** `ABS(t1.event_timestamp - t2.event_timestamp) < 60000000` (within 60s)

---

## CONVENTIONS

1. **ALWAYS filter by `event_date`** partition → cost optimization
2. **Timezone:** `[+XX]` ([Tên timezone]). Date format: `"YYYY-MM-DD"`
3. **Project IDs are CASE SENSITIVE**
4. **Timestamp conversion:** `timestamp_micros(SAFE_CAST(event_timestamp AS INT64))`
5. **Session number casting:** `SAFE_CAST(params_session_number AS INT64)`
6. **Performance:** Use `LIMIT` for exploratory. Filter partitions first. Avoid `SELECT *`.
