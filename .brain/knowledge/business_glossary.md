# BUSINESS GLOSSARY

**Last Updated:** [YYYY-MM-DD]
**Purpose:** Định nghĩa thuật ngữ & công thức KPI dùng chung

---

## 1. USER METRICS

### DAU / WAU / MAU
| Metric | Định nghĩa | Công thức |
|--------|-----------|-----------|
| DAU | Daily Active Users | COUNT(DISTINCT user_pseudo_id) trong 1 ngày |
| WAU | Weekly Active Users | COUNT(DISTINCT user_pseudo_id) trong 7 ngày |
| MAU | Monthly Active Users | COUNT(DISTINCT user_pseudo_id) trong 30 ngày |

### Retention
| Metric | Định nghĩa | Công thức |
|--------|-----------|-----------|
| D1 Retention | % users quay lại ngày 1 | Users active D1 / Users install D0 |
| D7 Retention | % users quay lại ngày 7 | Users active D7 / Users install D0 |
| D30 Retention | % users quay lại ngày 30 | Users active D30 / Users install D0 |

**Lưu ý:**
- D0 = ngày install
- Classic retention: user phải active đúng ngày Dn
- Rolling retention: user active bất kỳ ngày nào >= Dn

### Session Metrics
| Metric | Định nghĩa |
|--------|-----------|
| Session | 1 lần mở app, kết thúc khi app vào background > 30 phút |
| Session Length | Thời gian từ first_open đến last_event trong session |
| Sessions/DAU | Trung bình số sessions mỗi user mỗi ngày |

---

## 2. REVENUE METRICS

### IAP (In-App Purchase)
| Metric | Định nghĩa | Công thức |
|--------|-----------|-----------|
| Revenue | Doanh thu IAP | SUM(revenue_usd) |
| ARPU | Average Revenue Per User | Revenue / DAU |
| ARPPU | Average Revenue Per Paying User | Revenue / Paying Users |
| Conversion Rate | % users mua IAP | Paying Users / Total Users |

### IAA (In-App Advertising)
| Metric | Định nghĩa | Công thức |
|--------|-----------|-----------|
| Ad Revenue | Doanh thu quảng cáo | SUM(ad_revenue) |
| eCPM | Effective Cost Per Mille | (Ad Revenue / Impressions) * 1000 |
| Fill Rate | % ad requests được fill | Filled / Requested |
| Show Rate | % ads được show | Showed / Filled |

---

## 3. ENGAGEMENT METRICS

### Feature Adoption
| Metric | Định nghĩa | Công thức |
|--------|-----------|-----------|
| Feature Adoption Rate | % users dùng feature | Users dùng feature / Total Users |
| Feature Stickiness | Tần suất dùng feature | Sessions có feature / Total Sessions |

### Funnel Metrics
| Metric | Định nghĩa |
|--------|-----------|
| Conversion Rate | % users hoàn thành funnel |
| Drop-off Rate | % users rời đi ở mỗi step |
| Time to Convert | Thời gian từ start đến complete |

---

## 4. PRODUCT-SPECIFIC TERMS

> Điền các thuật ngữ riêng của app/product bạn đang phân tích.

### [Tên App]
| Term | Định nghĩa |
|------|-----------|
| [Term 1] | [Giải thích] |
| [Term 2] | [Giải thích] |

<!-- Thêm app khác bằng cách copy block trên -->

---

## 5. SEGMENTATION

### Cohort Definitions
| Cohort | Định nghĩa |
|--------|-----------|
| Install Cohort | Group by install_date |
| First Action Cohort | Group by ngày làm action đầu tiên |

---

## TEMPLATE: Thêm term mới

```markdown
### [Category Name]
| Term | Định nghĩa | Công thức (nếu có) |
|------|-----------|-------------------|
| Term 1 | Giải thích rõ ràng | Formula nếu là metric |
```
