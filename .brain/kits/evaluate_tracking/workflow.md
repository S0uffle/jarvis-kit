# WORKFLOW: EVALUATE TRACKING DATA

**Kit:** evaluate_tracking | **Version:** 2.1

---

## OVERVIEW

| Type | Ví dụ |
|------|-------|
| `completeness` | Tracking plan đã implement đầy đủ chưa? |
| `consistency` | Android và iOS tracking giống nhau không? |
| `correctness` | Param values đúng so với plan không? |

---

## STEP 1: CLARIFY

| Thông tin | Bắt buộc? |
|-----------|-----------|
| Tracking plan file (xlsx/csv) | Có |
| Project ID(s) | Có |
| Events cần check | Có (parse từ plan) |
| Date range | Có (ít nhất start_date) |

**Parse tracking plan:** `python3 -c "import openpyxl; ..."`

---

## STEP 2: SETUP

```bash
mkdir -p analyses/YYYYMMDD_evaluate_tracking/queries
mkdir -p analyses/YYYYMMDD_evaluate_tracking/data
```

Table naming: `{org_prefix}.{project_id}_CACHED_Events_02.{EVENT_NAME_UPPERCASE}`
> Lấy `{org_prefix}` từ `knowledge/schema_core.md`

---

## STEP 3-5: DISCOVERY → ROW COUNTS → PARAM VALUES

**SQL Templates:** `queries/tracking_discovery_template.sql`

**Step 3 output:** `data/01_discovery_tables.csv` — Tables + columns tìm thấy vs plan → liệt kê THIẾU
**Step 4 output:** `data/02_row_counts.csv` — 0 rows = ❌ chưa implement
**Step 5 output:** `data/03_{event}_{project}.csv` — Distinct values vs plan → THIẾU/THỪA

---

## STEP 6: CROSS-PLATFORM COMPARISON (nếu nhiều projects)

| Dimension | So sánh |
|-----------|---------|
| Columns | Cả 2 platforms có cùng params? |
| Param values | Values consistent? (casing, naming) |
| Data completeness | Params bị empty ở 1 platform? |

---

## STEP 7: REPORT

`REPORT.md` gồm: Tổng quan (bảng event/rows/status), Chi tiết từng event (columns ✅/❌, values plan vs thực tế), Sai lệch cross-platform, Action items (Critical ❌ + Warning ⚠️).

---

## COMMON ISSUES

| Pattern | Nguyên nhân |
|---------|------------|
| Table có nhưng 0 rows | Chưa implement tracking code |
| Param column luôn empty | Chưa gửi value |
| Value = "null" (string) | Bug: gửi string "null" |
| Khác casing giữa platforms | Chưa normalize |
| Values ngôn ngữ khác | Gửi localized UI text thay vì key |
