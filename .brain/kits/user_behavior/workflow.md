# WORKFLOW: User Behavior Analysis

**Kit:** user_behavior | **Version:** 3.1

---

## OVERVIEW

| Type | Câu hỏi | Ví dụ |
|------|---------|-------|
| `not_do_desired` | User KHÔNG làm action mong muốn? | Không chat, không mua IAP |
| `do_undesired` | User LÀM action không mong muốn? | Exit app, uninstall |
| `do_abnormal` | User có hành vi bất thường? | Spam click, loop behavior |
| `not_use_feature` | User KHÔNG dùng feature? | Không dùng voice chat |

---

## STEP 1: CLARIFY

| Thông tin | Bắt buộc? |
|-----------|-----------|
| Project ID | Có |
| Date range | Có |
| Question type (1 trong 4 ở trên) | Có (suy từ câu hỏi) |
| Target action | Có |
| Cohort filter (session, version, day) | Không (default = all) |
| Journey events | Không (suggest từ app context) |

**Nếu thiếu journey events:** Đọc app context (`.brain/contexts/`), suggest journey, confirm với user.

---

## STEP 2: SETUP

```bash
mkdir -p analyses/YYYYMMDD_ten_phan_tich/queries
mkdir -p analyses/YYYYMMDD_ten_phan_tich/data
```

Đọc `knowledge/schema_core.md` → xác định tên tables.

---

## STEP 3: BUILD & EXECUTE QUERIES

Chạy lần lượt. Mỗi query: Build SQL → lưu `queries/` → Execute `run_query.py` → lưu `data/`. Lỗi → Self-Healing (CLAUDE.md).

### 3A. Funnel Analysis
**Output:** `data/01_funnel_results.csv`
**Tìm gì:** Drop rate > 30% → major issue.

### 3B. Drop-off Analysis
**Output:** `data/02_dropoff_results.csv`
**Tìm gì:** Top 5 events có nhiều drops. Pattern: nhiều user drop cùng chỗ.

### 3C. Success Rate by Event
Chạy cho: Screens (`SCREEN_ACTIVE_DEFAULT`), Actions, Ads.
**Output:** `data/03_success_rate_by_event.csv`
**Tìm gì:** ±10% so với baseline.

### 3D. Success Rate by User Attributes
Chạy cho: `country`, `traffic_source_medium`, `mobile_brand_name`, `operating_system_version`.
**Output:** `data/04_success_rate_by_attributes.csv`
**Tìm gì:** Segments success rate thấp + user_count lớn.

### 3E. Sequence Patterns
So sánh path success vs dropped users.
**Output:** `data/05_sequence_patterns.csv`

---

## STEP 4: QUESTION-TYPE SPECIFIC LOGIC

| Type | Điều chỉnh |
|------|------------|
| `not_do_desired` | Focus blockers ngăn user đến target action |
| `do_undesired` | Đảo logic: is_success = 1 = user LÀM action không muốn. Focus triggers |
| `do_abnormal` | Thêm anomaly: action_count > AVG + 2*STDDEV |
| `not_use_feature` | So sánh users dùng vs không dùng — khác biệt ở đâu? |

---

## STEP 5: REPORT

Tạo `REPORT.md`:
- Summary: 3-5 key findings, mỗi finding 1 dòng
- Funnel Breakdown: bảng Step / Users / % of Total / % of Previous
- Insights: Finding + evidence + hypothesis
- Recommendations: Action cụ thể + expected impact
- Data Files: links to `queries/` và `data/`

---

## DECISION POINTS

| Nếu... | Thì... |
|--------|--------|
| Journey > 5 steps | Chia nhỏ sub-funnels |
| Có so sánh segments | Separate queries hoặc GROUP BY |
| User hỏi "tại sao?" | Đưa hypotheses, suggest queries validate |
| Drop-off > 50% tại 1 step | Flag "critical bottleneck" |
| Data anomaly (0% conversion) | Flag data quality issue |
