# SCHEMA LOGS - RAW & AUXILIARY TABLES

**Last Updated:** [YYYY-MM-DD]
**Purpose:** Các bảng phụ, raw logs ít dùng hơn schema_core

> Hướng dẫn: Điền các tables phụ trợ mà bạn cần khi schema_core không đủ.

---

## 1. [TÊN TABLE — vd: RAW FIREBASE EVENTS]

### Table Name
```
[org_prefix].[project_id]_[DATASET].[TABLE_NAME]
```

### Khi nào dùng?
- [Use case 1]
- [Use case 2]

### Schema
| Column | Type | Description |
|--------|------|-------------|
| ... | ... | ... |

---

## TEMPLATE: Thêm table mới

```markdown
## N. [TÊN TABLE]

### Table Name
- Full path đến table

### Khi nào dùng?
- Use cases cụ thể

### Schema
- Các columns quan trọng

### Query Example
- Ví dụ query cơ bản
```
