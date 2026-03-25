# Jarvis Kit — Version & Update Guide

**Current Version:** 1.0
**Release Date:** 2026-03-24

---

## Cấu trúc: Core vs Custom

Khi nhận bản update, chỉ cần cập nhật phần **Core**. Phần **Custom** là riêng của bạn, không bị ghi đè.

### Core (do team Jarvis maintain — update khi có version mới)

| File / Folder | Vai trò |
|---------------|---------|
| `CLAUDE.md` | Routing logic, workflow rules |
| `.brain/frameworks/` | Frameworks tư duy (Problem Framing, RCA) |
| `.brain/kits/` | Workflow cho bài toán có pattern |
| `.brain/templates/` | SQL & analysis templates |
| `.brain/tools/` | Scripts thực thi |
| `setup.sh`, `setup.bat` | Setup scripts |
| `requirements.txt` | Python dependencies |

### Custom (DA tự điền — giữ nguyên khi update)

| File / Folder | Vai trò |
|---------------|---------|
| `.brain/contexts/*.md` | Business context per app |
| `.brain/knowledge/schema_core.md` | Schema BigQuery của bạn |
| `.brain/knowledge/schema_logs.md` | Tables phụ |
| `.brain/knowledge/business_glossary.md` section 4 | Product-specific terms |
| `.brain/knowledge/lessons_learned.md` | Lessons từ analyses thực tế |
| `analyses/` | Output phân tích |

### Cách update

1. Download version mới
2. Copy các files/folders trong phần **Core** vào kit của bạn, ghi đè
3. Giữ nguyên phần **Custom**
4. Đọc changelog bên dưới để biết có gì mới

---

## Changelog

### v1.0 (2026-03-24)
- Initial release
- Frameworks: Problem Framing, Root Cause Analysis
- Kits: User Behavior, Evaluate Tracking
- Templates: Funnel, Tracking Discovery, CVR Analysis
- Tools: BigQuery runner, MD→DOCX converter
- Hỗ trợ macOS, Linux, Windows (venv-based)
