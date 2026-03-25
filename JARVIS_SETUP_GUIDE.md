# JARVIS — Hướng Dẫn Setup

---

## Bước 1: Cài phần mềm cần thiết

| Phần mềm | Cài đặt |
|-----------|---------|
| **VSCode** | https://code.visualstudio.com/ |
| **Claude Code extension** | Mở VSCode → Extensions → tìm "Claude Code" → Install. Cần có subscription Claude. |
| **gcloud CLI** | macOS: `brew install google-cloud-sdk` · Windows/Linux: https://cloud.google.com/sdk/docs/install |

## Bước 2: Mở Jarvis

1. Copy folder `jarvis-kit/` vào máy (hoặc giữ nguyên vị trí hiện tại)
2. Mở folder `jarvis-kit/` trong VSCode
3. Mở Claude Code (icon Claude trên sidebar, hoặc `Cmd+Shift+P` → "Claude Code")

## Bước 3: Nói với Claude Code

Gõ:

```
Setup Jarvis
```

Claude Code sẽ tự động:
- Kiểm tra & hướng dẫn cài Python nếu chưa có
- Tạo environment, cài dependencies
- Hướng dẫn bạn authenticate BigQuery (cần bạn chạy 1-2 lệnh trong terminal)
- Hỏi bạn **BigQuery Project ID** và **Dataset prefix**
- Cấu hình kit
- Verify kết nối

**Bạn chỉ cần trả lời câu hỏi của Claude Code** — nó sẽ làm hết phần còn lại.

---

## Sau khi Setup xong

Thử hỏi Jarvis:

```
Pull DAU 7 ngày gần nhất
```

```
Giúp tôi phân tích tại sao retention giảm
```

Nếu Jarvis chạy đúng → setup thành công.

---

## Bổ sung Context (tùy chọn, làm bất kỳ lúc nào)

Sau khi setup, bạn có thể bổ sung thêm context để Jarvis hiểu sâu hơn về product. Gõ:

```
Update context
```

Jarvis sẽ hiển thị menu các loại context có thể update:

| # | Loại | Mô tả | Khi nào nên update |
|---|------|-------|-------------------|
| 1 | **App context** | Tên app, platform, stage, business model, pricing, key metrics | Lần đầu dùng hoặc khi product thay đổi chiến lược |
| 2 | **Schema** | Discovery tables & columns từ BigQuery | Lần đầu dùng hoặc khi data pipeline thay đổi |
| 3 | **Business glossary** | Terms/metrics đặc thù của team (VD: "active user" tính thế nào) | Khi Jarvis hiểu sai metric hoặc dùng sai định nghĩa |
| 4 | **Constraints** | Data quality issues, tracking gaps, sample size limits | Khi phát hiện vấn đề data cần Jarvis lưu ý |

Bạn có thể chọn 1 hoặc nhiều loại cùng lúc. Không cần điền hết — bổ sung dần qua quá trình phân tích.

---

## Tips

- **Không cần điền hết ngay:** Jarvis sẽ hỏi khi cần thông tin chưa có. Bổ sung dần qua quá trình phân tích.
- **Edit tables trong .md files:** Cài extension **Markdown Table Editor** (by octop162) trong VSCode để edit table Markdown dễ hơn.
- **Khi update kit version mới:** Chỉ ghi đè phần Core (CLAUDE.md, frameworks, kits, tools). Phần Custom (contexts, knowledge, analyses) giữ nguyên. Xem chi tiết trong `VERSION.md`.
- **Muốn hiểu Jarvis hoạt động thế nào:** Đọc `JARVIS_OVERVIEW.md`.
