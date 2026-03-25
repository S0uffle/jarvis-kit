# Rules: REPORT-BS.md — Báo cáo cho Business

> File này hướng dẫn Jarvis cách gen REPORT-BS.md từ REPORT.md.
> Chỉ gen khi user đã OK REPORT.md và yêu cầu rõ ràng.

---

## Khi nào gen

1. REPORT.md đã hoàn thành
2. User xác nhận REPORT.md OK
3. User yêu cầu gen REPORT-BS.md

KHÔNG tự gen. KHÔNG gợi ý gen. Chờ user.

---

## Ngôn ngữ

### Nguyên tắc chính
- Câu văn viết **tiếng Việt hoàn chỉnh**
- Thuật ngữ English chỉ dùng khi nằm trong **whitelist** bên dưới
- Metric viết tắt phải giải nghĩa lần đầu xuất hiện: "PRS (tỷ lệ bắt đầu trả phí)"
- KHÔNG trộn English tùy ý vào câu Việt. Nếu một từ không có trong whitelist → dịch sang tiếng Việt

### Whitelist — Thuật ngữ English được phép dùng

**Metrics & KPIs:**
CVR, PRS, LTV, ROAS, CPI, CPA, DAU, retention, churn rate, renewal rate, conversion rate, pay rate, activation

**User segments:**
new user, old user, organic user, paid user, trial user, free user, cohort, install cohort

**Monetization:**
trial, subscription, IAP, paywall, pricing, revenue, renewal, cancellation, grace period, premium, free tier, billing retry, discounted offer

**Product & UX:**
onboarding, screen, splash, home, funnel, drop, session, engagement, aha moment, feature discovery, feature gate

**Marketing & Acquisition:**
campaign, creative, adgroup, traffic source, A/B test, spend, installs, user acquisition (UA), top countries

**Framework & Analysis:**
CDD, RCA, lever, benchmark, hypothesis, validation, trend, signals

**Time & Cohort:**
Day 0, Day 3, Day 7, D14, D30, D60

**Tên riêng:**
Tên app, tên feature (DeepSearch, Chat AI...), tên tool (Adjust, BigQuery...) → giữ nguyên English.

---

## Nội dung

### Mỗi insight phải kèm minh chứng
- Không nói suông. Kết luận nào cũng phải có số liệu hoặc bảng đi kèm.


### Lưu ý quan trọng gắn liền với data
- Nếu data có hạn chế (sample nhỏ, anomaly, tracking chưa chuẩn) → ghi ngay cạnh bảng/số liệu đó.
- KHÔNG gom hết caveats xuống cuối report — người đọc sẽ rút kết luận sai trước khi thấy lưu ý.

### Kết thúc bằng next actions
- Mỗi action: **làm gì**, **ai nên làm/quyết định**, **mức ưu tiên**
- Gắn với insight cụ thể trong report, không liệt kê chung chung

---

## Không làm

- KHÔNG thêm insight mới so với REPORT.md — chỉ chuyển ngữ và format lại
- KHÔNG bỏ bớt insight — nếu REPORT.md có thì REPORT-BS.md phải có
- KHÔNG thêm section methodology, data files, SQL reference — đó là cho DA
- KHÔNG dùng jargon ngoài whitelist mà không giải thích
