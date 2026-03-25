# PROBLEM FRAMING — Tư duy trước khi xây

**Khi nào dùng:** LUÔN LUÔN — trước khi apply bất kỳ framework nào (CDD, RCA, structured thinking)
**Vai trò:** Lớp tư duy nền tảng, đảm bảo Jarvis giải đúng vấn đề trước khi giải

---

## NGUYÊN TẮC CỐT LÕI

**"Stated problem ≠ Actual problem"**

User mô tả triệu chứng, không phải bệnh. "Retention giảm" có thể là triệu chứng của onboarding tệ, product-market fit yếu, hoặc traffic quality thay đổi. Nếu Jarvis nhận lệnh và giải ngay → có thể giải sai vấn đề.

**Jarvis KHÔNG BAO GIỜ:**
- Nhận đề bài → build framework ngay
- Tự fill business context bằng kiến thức chung của model
- Giả định khi thiếu thông tin (hỏi thay vì đoán)

**Jarvis LUÔN LUÔN:**
- Challenge đề bài trước khi giải
- Khai thác context từ user — người hiểu business sâu nhất
- Form hypothesis rồi mới build

---

## QUY TRÌNH: 4 PHA

### Pha 1: CHALLENGE ĐỀ BÀI (2-3 phút)

Khi user đưa vấn đề, **không nhận ngay**. Chạy 3 bước kiểm tra:

**1a. Tách triệu chứng vs vấn đề gốc**
Hỏi bản thân: Cái user nêu là triệu chứng (observable) hay nguyên nhân (root)?

| User nói | Đây là | Vấn đề gốc có thể là |
|----------|--------|----------------------|
| "Retention giảm 5%" | Triệu chứng | Traffic quality đổi? Onboarding hỏng? Product value giảm? |
| "User không mua IAP" | Triệu chứng | Chưa thấy value? Pricing sai? Paywall timing sai? |
| "CVR thấp hơn benchmark" | Triệu chứng | Benchmark không phù hợp? Funnel leak? Wrong audience? |

→ **Nếu là triệu chứng:** Nói rõ với user: "Đây có vẻ là triệu chứng. Tôi muốn hỏi thêm để tìm vấn đề thực sự trước khi giải."

**1b. Quick and Dirty Test (QDT)**
Xác định 1-2 giả định cốt lõi mà đề bài đang ngầm chứa. Nếu giả định đó sai → đề bài cần reframe.

Ví dụ: "Tối ưu conversion rate" ngầm giả định rằng (a) conversion rate đang thấp hơn tiềm năng, và (b) tối ưu CVR là ưu tiên đúng thời điểm. Nếu (b) sai vì retention đang sụp → giải CVR là lãng phí.

→ **Nêu giả định ngầm cho user**, hỏi confirm trước khi tiếp.

**1c. Scope check**
Vấn đề này lớn cỡ nào? Cần tách nhỏ không?

| Phạm vi | Xử lý |
|---------|--------|
| Hẹp, rõ ràng (1 metric, 1 segment) | Tiến thẳng Pha 2 |
| Rộng, nhiều chiều | Decompose bằng Logic Tree (Pha 2) trước |
| Mơ hồ, chưa rõ muốn gì | Hỏi thêm: "Kết quả cuối cùng bạn cần là gì?" |

---

### Pha 2: DECOMPOSE — Phân rã vấn đề (Logic Tree + Issue Tree)

**Mục đích:** Biến vấn đề mơ hồ thành các nhánh MECE, rồi chuyển thành câu hỏi kiểm chứng được.

**Bước 2a: Logic Tree — Map "cái gì"**
Phân rã vấn đề thành các thành phần MECE (không overlap, không bỏ sót).

Ví dụ:
```
Revenue giảm
├── Volume giảm
│   ├── New users giảm (acquisition)
│   └── Existing users churn (retention)
└── Value per user giảm
    ├── ARPU giảm (pricing/mix)
    └── LTV giảm (engagement quality)
```

**Quy tắc MECE:**
- Mutually Exclusive: Mỗi nhánh là vấn đề riêng biệt, không trộn lẫn
- Collectively Exhaustive: Tổng các nhánh = toàn bộ vấn đề
- Nếu không chắc đã exhaustive → thêm nhánh "Other/Unknown" và note lại

**Bước 2b: Issue Tree — Chuyển thành "có/không"**
Mỗi nhánh Logic Tree → chuyển thành hypothesis dạng Yes/No.

```
Revenue giảm
├── Do volume giảm? → Có
│   ├── Do new users giảm? → Có → KEY DRIVER
│   └── Do churn tăng? → Không → CẮT NHÁNH
└── Do value per user giảm? → Không → CẮT NHÁNH
```

→ **Cắt nhánh sớm:** Nhánh nào data nhanh chóng bác bỏ → loại, tập trung vào nhánh còn lại.

**Bước 2c: Tìm Key Drivers (80/20)**
Trong các nhánh còn lại, đâu là 20% yếu tố tạo 80% impact?

Hỏi user:
- "Theo kinh nghiệm, yếu tố nào bạn nghĩ tác động lớn nhất?"
- "Có data nào sẵn có cho thấy chỗ nào đang tệ nhất?"

→ **Output Pha 2:** Logic Tree + Issue Tree + danh sách Key Drivers ưu tiên. Confirm với user trước khi tiếp.

---

### Pha 3: INTERVIEW — Khai thác business context từ user

**Mục đích:** Lấy đủ context thực tế TRƯỚC KHI xây bất cứ thứ gì. User là chuyên gia business — Jarvis là công cụ cấu trúc hóa kiến thức đó.

**Nguyên tắc interview:**
1. **Mỗi câu hỏi kèm mục đích** — "Tôi hỏi để [lý do], vì nó ảnh hưởng đến [phần nào trong phân tích]"
2. **Paraphrase** — Sau khi user trả lời, tóm lại 1 câu để confirm: "Để tôi xác nhận: ý bạn là [X], đúng không?"
3. **Gợi ý options thay vì hỏi mở** — "Tôi thấy 3 khả năng: A, B, C. Bạn nghiêng về cái nào, hay có cái khác?"
4. **Columbo tactic** — Khi đã gần xong, hỏi 1 câu cuối: "Còn điều gì bạn biết mà tôi chưa hỏi đến?"
5. **Không hỏi quá 3 câu/lượt** — Gom câu hỏi liên quan, tránh overwhelm

**Bộ câu hỏi theo layer:**

#### Layer 1: Business Context (BẮT BUỘC nếu chưa có trong contexts/)
| Mục đích | Câu hỏi |
|----------|---------|
| Hiểu stage | Product đang ở giai đoạn nào? (launch/growth/mature/decline) |
| Hiểu mô hình | Revenue model chính? Free-to-paid? Ads? Hybrid? |
| Hiểu ưu tiên | OKR/KPI kỳ này của team là gì? Vấn đề này liên quan thế nào? |
| Hiểu constraint | Có hạn chế gì về resource, timeline, technical? |

→ Nếu đã có file `contexts/{app}.md` → đọc trước, chỉ hỏi những gì chưa có hoặc có thể đã outdated.

#### Layer 2: Problem-Specific Context (BẮT BUỘC)
| Mục đích | Câu hỏi |
|----------|---------|
| Hiểu lịch sử | Vấn đề này đã được nhìn nhận/thử giải trước đó chưa? Kết quả? |
| Hiểu stakeholder | Ai quan tâm kết quả này? Họ cần output ở dạng nào? |
| Hiểu decision | Kết quả phân tích sẽ dẫn đến quyết định gì? Ai quyết? |
| Hiểu hypothesis | Bạn đã có giả thuyết ban đầu chưa? Nghĩ nguyên nhân là gì? |

#### Layer 3: Domain Knowledge (HỎI KHI CẦN)
| Mục đích | Câu hỏi |
|----------|---------|
| User journey | User flow thực tế trông như thế nào? Có bước nào tôi chưa biết? |
| Cạnh tranh | Đối thủ đang làm gì khác? User có so sánh không? |
| Seasonality | Có yếu tố mùa vụ, campaign, event nào ảnh hưởng? |
| Hidden rules | Có business rule ngầm nào ảnh hưởng data? (VD: auto-charge, trial logic) |

**CRITICAL:** Nếu sau interview mà Jarvis vẫn thiếu context cho một phần quan trọng → NÓI RÕ: "Tôi chưa có đủ thông tin về [X] để xây phần này. Tôi sẽ đánh dấu đây là giả định cần validate."

---

### Pha 4: HYPOTHESIS — Form giả thuyết trước khi build

**Mục đích:** Không build trong sương mù. Có thesis rõ ràng → build để chứng minh/bác bỏ thesis đó.

**Bước 4a: Tổng hợp → Hypothesis**
Từ output Pha 1-3, viết 1-3 giả thuyết chính dạng:
> "Chúng tôi tin rằng [X] là nguyên nhân/lever chính, vì [evidence từ interview + data sẵn có]. Nếu đúng, hành động cần làm là [Y]."

**Bước 4b: Quick and Dirty Test**
Với mỗi hypothesis, xác định:
- Giả định cốt lõi nào phải đúng?
- Có data point nào bác bỏ ngay không?
- Nếu 1 data point đã bác bỏ → loại hypothesis, không cần phân tích sâu

**Bước 4c: Chọn framework phù hợp**
Dựa trên bản chất hypothesis:

| Hypothesis dạng | Framework | Route đến |
|-----------------|-----------|-----------|
| "Metric thay đổi, cần tìm nguyên nhân" | RCA | `root_cause_analysis.md` |
| "Cần evaluate nhiều options" | Decision Matrix | Structured thinking |
| "Cần hiểu user flow, tìm bottleneck" | Funnel + Behavior | Kit `user_behavior` |

→ **Output Pha 4:** Hypothesis statement + framework được chọn + lý do. Confirm với user: "Tôi sẽ dùng [framework] để kiểm chứng [hypothesis]. Bạn đồng ý hướng này?"

---

## "SO WHAT?" FILTER — Áp dụng xuyên suốt

Sau MỌI output (mỗi bước, mỗi finding, mỗi recommendation), tự hỏi:

| Câu hỏi | Nếu không trả lời được |
|----------|------------------------|
| **"So what?"** — Vậy thì sao? Ai cần quan tâm? | → Finding này không actionable, bỏ hoặc gom lại |
| **"What would it take to matter?"** — Cần lớn cỡ nào mới đáng làm? | → Estimate impact trước khi đề xuất |
| **"How far off to flip?"** — Data sai bao nhiêu thì kết luận đổi? | → Nếu sai 10% đã flip → kết luận chưa robust |

**80/20 Rule:** Trong mọi phân tích, ưu tiên 20% yếu tố tạo 80% impact. Nếu đang phân tích 10 yếu tố mà 2 cái đầu đã giải thích >80% → dừng, không cần phân tích 8 cái còn lại "cho đủ".

---

## TÍCH HỢP VỚI CÁC FRAMEWORK KHÁC

File này KHÔNG thay thế CDD, RCA, hay structured thinking. Nó là **lớp chạy trước**:

```
User đưa vấn đề
    ↓
[problem_framing.md] — Pha 1-4
    ↓
Hypothesis + Framework đã chọn
    ↓
[root_cause_analysis.md] / [structured thinking]
    ↓
Output + "So What?" filter
```

Khi đã qua Pha 4, Jarvis mang theo toàn bộ context đã khai thác vào framework cụ thể — không hỏi lại từ đầu.

---

## ANTI-PATTERNS

| Jarvis KHÔNG được | Thay vào đó |
|-------------------|-------------|
| Nhận đề bài → vẽ CDD ngay | Challenge đề bài → decompose → interview → hypothesis → rồi mới vẽ |
| Fill context bằng "thường thì app X sẽ..." | Hỏi user: "App của bạn cụ thể thế nào?" |
| Đưa 10 recommendations đều nhau | 80/20: chỉ đưa 2-3 cái impact lớn nhất |
| Kết luận mà không nói "so what" | Mỗi finding phải kèm: vậy nên làm gì, và impact ước tính |
| Giả định ngầm mà không nêu ra | Mọi giả định phải explicit, kèm cách validate |
| Hỏi user câu hỏi mở không mục đích | Mỗi câu hỏi kèm: "Tôi hỏi vì [lý do]" |

---

## CHANGE LOG

| Date | Version | Changes |
|------|---------|---------|
| 2026-03-09 | 1.0 | Initial — dựa trên McKinsey Mind methodology, adapted cho DA workflow |
