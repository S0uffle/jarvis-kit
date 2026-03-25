# FIRST RUN — Hướng dẫn cho Agent

> File này dành cho Claude Code đọc khi phát hiện kit chưa cấu hình.
> User KHÔNG cần đọc file này.

---

## Dấu hiệu kit chưa cấu hình

Bất kỳ điều kiện nào sau đây:
- `[ĐIỀN_PROJECT_ID]` còn trong `CLAUDE.md`
- `schema_core.md` còn nguyên template (chưa điền table thật)

---

## SETUP FLOW

### Bước 1: Check & cài Python

1. Kiểm tra `python3` (hoặc `py -3` trên Windows) có sẵn không
2. Nếu có → kiểm tra version >= 3.13
3. Nếu version < 3.13 → **hướng dẫn user cài Python >= 3.13:**
   - macOS: `brew install python@3.13`
   - Ubuntu: `sudo apt install python3.13 python3.13-venv`
   - Windows: download từ https://www.python.org/downloads/ → check "Add to PATH"
   - Nói rõ: cài song song, không ảnh hưởng bản Python hiện tại
4. Nếu hoàn toàn không có Python → báo user cài trước, dừng setup

### Bước 2: Tạo venv & cài dependencies

1. Chạy setup script phù hợp OS:
   - macOS/Linux: `./setup.sh`
   - Windows: `setup.bat`
2. Verify venv tạo thành công (`.venv/` tồn tại)
3. Nếu script fail → đọc error, thử fix (quyền execute, Python version), báo user nếu không tự fix được

### Bước 3: Authenticate BigQuery

1. Kiểm tra gcloud đã authenticate chưa:
   ```bash
   gcloud auth application-default print-access-token 2>/dev/null
   ```
2. Nếu chưa → **hướng dẫn user chạy 2 lệnh** (bước này cần user tự làm vì mở browser):
   ```bash
   gcloud auth login
   gcloud auth application-default login
   ```
3. Đợi user confirm xong → verify lại bằng lệnh ở bước 1

### Bước 4: Hỏi BigQuery Project ID

Chỉ hỏi **1 thông tin duy nhất**:
- **BigQuery Project ID** — project dùng để kết nối (VD: `analytics-ikame-app`)

Dataset prefix, schema, app context → không hỏi ở đây. Jarvis sẽ discovery hoặc hỏi khi cần (qua "Update context" hoặc lần query đầu tiên).

### Bước 5: Cấu hình kit

Dùng Project ID user cung cấp để:
1. Thay `[ĐIỀN_PROJECT_ID]` trong `CLAUDE.md` bằng project ID thực tế
2. Điền Project ID vào `schema_core.md`

**KHÔNG làm những việc sau ở bước này** (chuyển sang "Update Context"):
- ~~Tạo app context~~
- ~~Discovery schema chi tiết~~

### Bước 6: Verify

Chạy 1 query đơn giản để xác nhận kết nối OK:
```bash
python3 .brain/tools/run_query.py --project {project_id} --query "SELECT 1 AS test"
```

Nếu trả về kết quả → báo user: **"Setup hoàn tất! Jarvis đã sẵn sàng query BigQuery."**

Nếu lỗi → áp dụng Self-Healing Protocol (check project ID, permissions).

Sau khi verify xong, hướng dẫn user:
- Bắt đầu dùng ngay (VD: "Pull DAU 7 ngày gần nhất")
- Khi cần bổ sung context → gõ **"Update context"**

---

## UPDATE CONTEXT FLOW

> Khi user nói "Update context" hoặc Jarvis cần context cụ thể mà chưa có.

### Bước 1: Hiển thị menu cho user

Báo user có thể update những gì:

```
Bạn có thể update các context sau:

1. 📱 App context     — Tạo/cập nhật thông tin app (tên, platform, stage, business model, pricing...)
2. 🗄️ Schema          — Discovery tables & columns từ BigQuery, điền vào schema_core.md
3. 📖 Business glossary — Thêm terms/metrics đặc thù của team
4. ⚠️ Constraints     — Data quality issues, tracking gaps, sample size limits

Chọn số (hoặc nhiều số, VD: "1,2") hoặc mô tả bạn muốn update gì.
```

### Bước 2: Thực hiện theo lựa chọn

#### 1. App context
1. Kiểm tra `.brain/contexts/` có file nào ngoài `_TEMPLATE_*` chưa
   - Chưa có → hỏi tên app, platform → tạo file mới từ `_TEMPLATE_app_context.md`
   - Đã có → hỏi user muốn cập nhật file nào
2. Hỏi thông tin theo sections của template (gom tối đa 3 câu/lượt):
   - Product overview (tên, platform, stage, core value)
   - Business model (revenue streams, pricing, trial)
   - Key metrics hiện tại
   - Constraints
3. Điền vào file context. Sections user chưa cung cấp → giữ nguyên placeholder

#### 2. Schema discovery
1. Hỏi user confirm: "Tôi sẽ query INFORMATION_SCHEMA để tìm tables và columns. Chạy không?"
2. Nếu đồng ý:
   - Query `INFORMATION_SCHEMA` để list datasets & tables liên quan
   - Discover columns của các tables quan trọng
   - Điền kết quả vào `schema_core.md`
3. Báo user kết quả tìm được

#### 3. Business glossary
1. Hỏi user: "Team bạn có dùng terms/metrics nào đặc thù không? (VD: 'active user' tính thế nào, 'churn' định nghĩa ra sao)"
2. Thêm vào `.brain/knowledge/business_glossary.md` section 4

#### 4. Constraints
1. Hỏi user về:
   - Data quality issues đã biết
   - Tracking gaps (events/features chưa track)
   - Sample size concerns
2. Ghi vào app context file (section Constraints) hoặc `lessons_learned.md`

---

## Nguyên tắc

- **Tự làm được → tự làm.** Chỉ hỏi user khi cần input (project ID, app info) hoặc cần action mà agent không làm được (gcloud auth).
- **Gom câu hỏi.** Tối đa 3 câu/lượt, không hỏi lẻ tẻ.
- **Báo progress.** Mỗi bước xong → báo ngắn gọn, không cần giải thích dài.
- **Setup = tối giản.** Chỉ cần Jarvis query được BigQuery là xong. Context bổ sung → "Update context".
