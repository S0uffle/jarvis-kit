# ROOT CAUSE ANALYSIS (RCA)

**Khi nào dùng:** Metric thay đổi bất thường, cần tìm nguyên nhân gốc

---

## 1. RCA LÀ GÌ?

Quy trình có hệ thống để:
- Phát hiện nguyên nhân thực sự (không chỉ triệu chứng)
- Tránh giải quyết sai vấn đề
- Ngăn vấn đề tái diễn

---

## 2. FRAMEWORK: 5 WHYS + MECE

### 5 Whys
Hỏi "Tại sao?" liên tục cho đến khi đến root cause.

```
Retention giảm 5%
  ↓ Why?
User không quay lại sau session 1
  ↓ Why?
User không hoàn thành onboarding
  ↓ Why?
Onboarding quá dài (8 steps)
  ↓ Why?
PM thêm steps mà không test
  ↓ Why?
Không có process review UX changes
  
→ Root cause: Missing UX review process
```

### MECE Decomposition
Tách vấn đề thành các phần không overlap, cover hết.

```
Retention giảm 5%
├── [A] User-side issues (40%)
│   ├── [A1] Onboarding drop (25%)
│   └── [A2] Feature discovery (15%)
├── [B] Technical issues (35%)
│   ├── [B1] Crash rate (20%)
│   └── [B2] Load time (15%)
└── [C] External factors (25%)
    ├── [C1] Seasonality (10%)
    └── [C2] Competition (15%)
```

---

## 3. PROCESS

### Step 1: Define Problem
- Metric nào bị ảnh hưởng?
- Thay đổi bao nhiêu? So với gì?
- Từ khi nào?
- Segments nào bị ảnh hưởng?

### Step 2: Gather Data
- Pull relevant data từ Brain Analyst
- Segment by dimensions (platform, version, country...)
- Look for correlations với other metrics

### Step 3: Generate Hypotheses
Dùng MECE để brainstorm, group thành:
- Product changes
- Technical issues
- User behavior changes
- External factors

### Step 4: Validate Hypotheses
Với mỗi hypothesis:
- Data nào sẽ confirm/reject?
- Có data đó chưa?
- Kết quả validation?

### Step 5: Identify Root Cause
- Hypothesis nào được validate?
- Apply 5 Whys để dig deeper
- Đến actionable root cause

### Step 6: Recommend Actions
- Short-term: Fix ngay được
- Long-term: Prevent tái diễn

---

## 4. VÍ DỤ: D7 RETENTION GIẢM

### Problem Definition
- Metric: D7 Retention
- Change: 20% → 15% (-5pp)
- Timeline: Bắt đầu từ 15/1/2026
- Segment: Chỉ Android, không ảnh hưởng iOS

### Hypotheses (MECE)
| Category | Hypothesis | Probability |
|----------|------------|-------------|
| Product | New onboarding v2 làm user confuse | High |
| Technical | Android update gây crash | Medium |
| External | Competitor launch campaign | Low |

### Validation
| Hypothesis | Data cần | Kết quả |
|------------|----------|---------|
| Onboarding v2 | Funnel comparison v1 vs v2 | ✅ v2 drop 30% higher |
| Android crash | Crashlytics data | ❌ Crash rate stable |
| Competitor | Market research | ❌ No major launch |

### Root Cause (5 Whys)
```
Onboarding v2 có drop rate cao
  ↓ Why?
Step 3 "Connect social" làm 40% user exit
  ↓ Why?
User không muốn connect nhưng không có skip option
  ↓ Why?
PM assume social login is mandatory
  
→ Root cause: Mandatory social connect without skip option
```

### Recommendations
| Priority | Action | Owner | Timeline |
|----------|--------|-------|----------|
| P0 | Add skip button to step 3 | Dev | 2 days |
| P1 | A/B test optional vs mandatory | PM | 1 week |
| P2 | Review all mandatory steps | UX | 2 weeks |

---

## 5. OUTPUT FORMAT

```markdown
## RCA: [Tên vấn đề]

### Problem Definition
- **Metric:** [Tên metric]
- **Change:** [Từ X đến Y]
- **Timeline:** [Từ ngày nào]
- **Segments affected:** [Platforms, versions, countries...]

### Hypotheses
| Category | Hypothesis | Prior Probability |
|----------|------------|-------------------|
| ... | ... | High/Med/Low |

### Validation Results
| Hypothesis | Evidence | Status |
|------------|----------|--------|
| ... | ... | ✅ Confirmed / ❌ Rejected / ⚠️ Inconclusive |

### Root Cause
[5 Whys chain]

### Recommendations
| Priority | Action | Expected Impact | Effort |
|----------|--------|-----------------|--------|
| P0 | ... | ... | ... |

### Open Questions
- [Những gì chưa validate được]
```

---

## 6. COMMON PITFALLS

| Pitfall | Cách tránh |
|---------|-----------|
| Dừng quá sớm ở triệu chứng | Luôn hỏi thêm 1-2 "Why?" |
| Bias toward familiar causes | Dùng MECE để ensure coverage |
| Không validate hypothesis | Luôn tìm data confirm/reject |
| Single root cause thinking | Có thể có multiple contributing factors |
