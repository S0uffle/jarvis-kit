# JARVIS — Tổng Quan

## Jarvis là gì?

Jarvis là **AI-powered DA Copilot** — một hệ thống prompt engineering chạy trên Claude Code (VSCode), được thiết kế để hỗ trợ Data Analyst trong môi trường Game/App mobile.

Jarvis **không phải** tool cho team. Jarvis là **copilot cá nhân** cho 1 DA, dần thay thế các tác vụ lặp lại để DA tập trung vào decision intelligence và strategic analysis.

---

## Sứ mệnh

Tối ưu **50% công việc cho DA** bằng cách:
- Tự động hóa query, phân tích data, tạo report
- Cung cấp framework tư duy có cấu trúc (RCA, Problem Framing)
- Duy trì knowledge base về schema, business rules, lessons learned
- Đảm bảo consistency qua các bài phân tích

---

## Kiến trúc

```
jarvis-kit/
├── CLAUDE.md                    ← Bộ não: routing + workflow rules
├── .brain/
│   ├── knowledge/               ← Schema, glossary, rules, lessons learned
│   ├── contexts/                ← Business context per app/product
│   ├── frameworks/              ← Frameworks tư duy (RCA, Problem Framing)
│   ├── kits/                    ← Workflow cho bài toán có pattern
│   ├── templates/               ← SQL & analysis templates
│   └── tools/                   ← Scripts thực thi (BigQuery, MD→DOCX)
└── analyses/                    ← Output các bài phân tích
```

### Vai trò từng thành phần

| Thành phần | Vai trò | Ví dụ |
|------------|---------|-------|
| **CLAUDE.md** | Orchestrator — routing logic, workflow rules, prime directives | Nhận câu hỏi → phân loại → route đúng workflow |
| **knowledge/** | Facts về data infrastructure | Schema BigQuery, định nghĩa KPIs, business rules |
| **contexts/** | Business context per product | Mô hình kinh doanh, key metrics, decision log của app |
| **frameworks/** | Frameworks tư duy có cấu trúc | Problem Framing, RCA |
| **kits/** | Workflow step-by-step cho bài toán lặp lại | User behavior analysis, tracking evaluation |
| **templates/** | Templates SQL & phân tích có thể tái sử dụng | Funnel template, CVR analysis template |
| **tools/** | Scripts thực thi | BigQuery query runner, MD→DOCX converter |
| **analyses/** | Output — nơi lưu kết quả phân tích | Queries, data CSVs, reports |

---

## Cơ chế hoạt động

### 1. Auto-Routing

Jarvis **tự phân loại** câu hỏi của user thành 3 mode, không cần user chỉ định:

| Mode | Khi nào | Flow |
|------|---------|------|
| **ANALYST** | Cần query data, tạo report, tìm patterns | Route → kit (nếu match) hoặc quy trình tổng quát |
| **ADVISOR** | Cần suy luận, framework, chiến lược | Problem Framing → route framework (RCA/structured thinking) |
| **COMBINED** | Cần cả data lẫn suy luận | Problem Framing → Analyst lấy data → Advisor interpret |

### 2. Lazy Loading (3 Tier)

Jarvis **không đọc** tất cả files cùng lúc. Chỉ load file khi cần, theo 3 tier:

| Tier | Khi nào load | Files |
|------|-------------|-------|
| **Tier 0** | Luôn có | `CLAUDE.md` (chỉ routing logic) |
| **Tier 1** | Sau khi route xong | Framework files, kit workflows, app context |
| **Tier 2** | Trong quá trình làm | Schema, glossary, rules, templates, past analyses |

Mục đích: tránh tràn context window của AI, chỉ dùng thông tin cần thiết.

### 3. Problem Framing (Advisor)

Mọi bài toán advisory **bắt buộc** đi qua 4 pha trước khi áp dụng framework:

```
Pha 1: CHALLENGE    — Stated problem ≠ Actual problem. Tách triệu chứng vs vấn đề gốc.
Pha 2: DECOMPOSE    — Logic Tree + Issue Tree, cắt nhánh sớm, tìm key drivers.
Pha 3: INTERVIEW    — Khai thác business context từ user, max 3 câu/lượt.
Pha 4: HYPOTHESIS   — Form giả thuyết rõ ràng → chọn framework phù hợp.
```

### 4. Self-Healing

Khi gặp lỗi (SQL syntax, table not found, empty result...), Jarvis tự sửa tối đa 3 lần trước khi hỏi user. Chỉ permission errors mới báo ngay.

---

## Scope công việc

| Nhóm tác vụ | Mô tả | Trạng thái |
|-------------|-------|------------|
| Phân tích nhanh (What & Why) | Query data, tìm pattern, trả lời ad-hoc | Sẵn sàng |
| Framework business phức tạp | RCA, Problem Framing | Sẵn sàng |
| Đánh giá tracking | Validate tracking plan vs actual data | Sẵn sàng |
| User behavior analysis | Funnel, drop-off, success rate, sequence | Sẵn sàng |
| CVR / conversion optimization | Template + lessons learned từ thực tế | Sẵn sàng |

---

## Frameworks có sẵn

| Framework | File | Khi nào dùng |
|-----------|------|-------------|
| **Problem Framing** | `problem_framing.md` | Luôn — trước mọi framework khác (Advisor mode) |
| **Root Cause Analysis** | `root_cause_analysis.md` | Metric thay đổi bất thường, tìm nguyên nhân gốc |

---

## Kits có sẵn

| Kit | File | Khi nào dùng |
|-----|------|-------------|
| **User Behavior** | `kits/user_behavior/workflow.md` | "Tại sao user không làm X?", funnel, retention |
| **Evaluate Tracking** | `kits/evaluate_tracking/workflow.md` | Validate tracking completeness, consistency, correctness |

---

## Prime Directives

1. **Auto-Route** — Tự phân loại, không yêu cầu user chọn
2. **Lazy Load** — Không đọc file trước khi route xong
3. **No Hallucinations** — Không biết → discovery query hoặc hỏi user
4. **Validate Everything** — Check SQL, date format, table names trước khi execute
5. **Follow Workflow** — Có kit/framework → follow step-by-step
6. **Self-Healing** — Tự sửa lỗi trước khi hỏi user (tối đa 3 lần)
7. **Combined Mode** — Cần data + suy luận → analyst trước, advisor sau

---

## Mở rộng

Jarvis được thiết kế để mở rộng dễ dàng:

| Cần thêm | Làm gì |
|-----------|--------|
| App/product mới | Tạo file `.brain/contexts/{app}.md` |
| Workflow mới cho bài toán lặp | Tạo folder `.brain/kits/{kit}/workflow.md` + thêm routing |
| Framework tư duy mới | Tạo file `.brain/frameworks/{framework}.md` + thêm routing |
| Template SQL/analysis | Tạo file `.brain/templates/` |
| Schema mới | Update `knowledge/schema_core.md` hoặc `schema_logs.md` |
