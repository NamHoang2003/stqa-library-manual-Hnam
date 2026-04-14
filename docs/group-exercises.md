# Bài tập nhóm — Thảo luận & Nghiên cứu sâu

> 📖 **Textbook:** Paul Ammann & Jeff Offutt, *Introduction to Software Testing*, 2nd Edition.
>
> **Mục tiêu:** Hiểu các khái niệm mới: **RIPR Model**, **Model-Driven Test Design**, **Test Oracle**.

---

## Bài tập 1: Cuộc chiến của những chiếc hộp (The "Box" Debate)

> ⏱ **Thời gian:** 15–20 phút | **Chương liên quan:** Ch.2 §2.4–2.5, Ch.6

### Bối cảnh

Chúng ta thường chia kiểm thử thành **Hộp đen** (Black-box — chỉ nhìn SRS) và **Hộp trắng** (White-box — nhìn code). Nhưng tác giả cho rằng ranh giới này **lỗi thời**:

> *"Thus asking whether a coverage criterion is black-box or white-box is the wrong question. One more properly should ask from what level of abstraction is the structure drawn."*
> — Ammann & Offutt, Ch.2, p.58

### Nhiệm vụ nhóm

1. **Mở file** `docs/SRS-library-system.md` — đây là "Black-box model".

2. **Đọc đoạn trích code backend** dưới đây — đây là "White-box model" (code Dart xử lý nghiệp vụ mượn sách):

   ```dart
   // Trích từ library_service.dart — hàm borrowBook()
   ServiceResult<BorrowRecord> borrowBook({required String memberId, required String bookId}) {
     final member = getMemberById(memberId);
     if (member == null) return ServiceResult.error('Không tìm thấy thành viên.');

     // Kiểm tra trạng thái thành viên
     if (member.status == MemberStatus.expired)
       return ServiceResult.error('Thành viên đã hết hạn. Không thể mượn sách.');
     if (member.status == MemberStatus.suspended)
       return ServiceResult.error('Thành viên đang bị tạm ngưng. Không thể mượn sách.');

     final book = getBookById(bookId);
     if (book == null) return ServiceResult.error('Không tìm thấy sách.');
     if (book.status != BookStatus.available)
       return ServiceResult.error('Sách không có sẵn để mượn.');

     // Kiểm tra giới hạn mượn
     final currentBorrowCount = _records
         .where((r) => r.memberId == memberId && r.status == BorrowStatus.borrowing)
         .length;
     if (currentBorrowCount >= maxBooksPerMember)  // maxBooksPerMember = 3
       return ServiceResult.error('Đã đạt giới hạn mượn tối đa (3 sách).');

     // Tạo phiếu mượn, cập nhật trạng thái sách
     final record = BorrowRecord(
       memberId: memberId, bookId: bookId,
       borrowDate: DateTime.now(),
       dueDate: DateTime.now().add(Duration(days: 14)),  // borrowDurationDays = 14
     );
     return ServiceResult.ok(record);
   }
   ```

3. **Thiết kế 6 giá trị test cho tính năng "Mượn sách":**

   | # | Nguồn gốc | Test Value (Mô tả) | Dữ liệu cụ thể |
   |---|---|---|---|
   | 1 | Từ SRS (Black-box) | `<!-- Nhóm tự điền -->` | |
   | 2 | Từ SRS (Black-box) | | |
   | 3 | Từ SRS (Black-box) | | |
   | 4 | Từ Code (White-box) | | |
   | 5 | Từ Code (White-box) | | |
   | 6 | Từ Code (White-box) | | |

4. **Câu hỏi thảo luận:**

   a. Các giá trị test từ SRS và từ Code có **khác nhau** không? Có trùng nhau không?

   b. Tại sao hỏi *"Test này là Black-box hay White-box?"* lại là **câu hỏi sai**? Ta nên hỏi gì thay thế?

   c. **Gợi ý:** SRS là một **model** ở mức trừu tượng cao, code Dart là **model** ở mức thấp — cả hai đều là model. Câu hỏi đúng: *"Test được thiết kế từ model nào?"*

---

## Bài tập 2: Phá án cùng mô hình RIPR (The RIPR Detective)

> ⏱ **Thời gian:** 15 phút | **Chương liên quan:** Ch.2 §2.1, Ch.14

### Kịch bản giả định

Nhóm bạn đang kiểm thử tính năng "Tìm kiếm sách" (TC-05: tìm kiếm không có kết quả). Bạn nhập từ khóa `"xyz_khong_ton_tai"` vào ô tìm kiếm. Kết quả:

- **Kết quả mong đợi**: Danh sách rỗng, không hiển thị sách nào
- **Kết quả thực tế**: Giao diện vẫn **hiển thị sách từ lần tìm trước** (lỗi UI!)
- **Kết quả test**: Bạn ghi **PASS** vì "không có thông báo lỗi"

→ Bug đã tồn tại và hiển thị trên giao diện, nhưng bạn không phát hiện!

### Nhiệm vụ nhóm

1. **Vẽ sơ đồ 4 bước RIPR:**

   ```
   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
   │ Reachability │ → │  Infection   │ → │ Propagation  │ → │ Revealability│
   │   Chạm tới   │   │ Nhiễm trạng  │   │ Lan truyền   │   │  Bộc lộ lỗi  │
   │              │   │  thái lỗi    │   │  ra output   │   │  cho tester  │
   └──────────────┘   └──────────────┘   └──────────────┘   └──────────────┘
          ✅                 ✅                 ✅                 ❌ ← GÃY!
   ```

2. **Câu hỏi thảo luận:**

   a. Bug đã **Reach** → **Infect** → **Propagate** ra UI. Vậy **bước nào** bị gãy? Tại sao?

   b. **Revealability** bị gãy vì **Test Oracle yếu**: "Kết quả mong đợi" quá chung chung. Hãy viết lại KQ mong đợi sao cho **rõ ràng, kiểm chứng được**:

   | | Trước (yếu) | Sau (mạnh) |
   |---|---|---|
   | KQ mong đợi | "Không có lỗi" | `<!-- Nhóm viết lại -->` |

   c. Nếu bạn làm **automation** (bài A2), dòng `assert` trong code tương đương với điều gì trong manual testing? (Gợi ý: "Kết quả mong đợi" = Test Oracle)

---

## Bài tập 3: Ai bảo vệ phần mềm? (Test Suite vs SRS)

> ⏱ **Thời gian:** 15 phút | **Chương liên quan:** Ch.4 §4.2

### Bối cảnh

Theo góc nhìn Agile và TDD:

> *"In agile methods, test cases are the de facto specification for the system."*
> — Ammann & Offutt, Ch.4, p.99

### Nhiệm vụ nhóm

1. **Xem xét 12 Test Case** (TC-01 → TC-12) được mô tả trong SRS:

   | Nhóm chức năng | TCs | Chức năng |
   |---|---|---|
   | Đăng nhập | TC-01, TC-02, TC-03 | Đăng nhập thành công/thất bại |
   | Tìm kiếm & Lọc | TC-04 ~ TC-07 | Tìm theo tên/tác giả, lọc thể loại |
   | Mượn & Trả | TC-08, TC-09, TC-10 | Mượn sách, xem danh sách, trả sách |
   | Chức năng chung | TC-11, TC-12 | Đăng xuất, chuyển ngôn ngữ |

2. **Câu hỏi thảo luận:**

   a. Nếu file `SRS-library-system.md` **bị xóa mất**, liệu một lập trình viên mới có thể **chỉ nhìn** vào TC-08 ~ TC-10 để code lại tính năng mượn/trả sách không? Vì sao?

   b. Liệt kê **những thông tin nghiệp vụ** mà TC-08 (Mượn sách) cho biết:

   | # | Thông tin (đọc được từ test) | Nguồn |
   |---|---|---|
   | 1 | `<!-- Nhóm tự điền -->` | |
   | 2 | | |
   | 3 | | |

   c. **Giới hạn**: Góc nhìn "Test là tài liệu" yếu ở đâu?
      - Kịch bản người dùng thao tác sai (negative) mà chưa nghĩ tới?
      - Yêu cầu phi chức năng (hiệu suất, bảo mật)?
      - Nghiệp vụ thay đổi mà test chưa cập nhật?

   d. **Kết luận nhóm:** SRS và Test Suite nên **cùng tồn tại** hay chỉ cần 1 trong 2? Giải thích.

---

## Bài tập 4: Vòng đời cuốn sách — Đồ thị trạng thái / The Book Lifecycle FSM

> ⏱ **Thời gian:** 20 phút | **Chương liên quan:** Ch.7 §7.5.2 (p.223–234)
>
> 🌐 **Song ngữ / Bilingual:** Thuật ngữ gốc tiếng Anh được giữ nguyên trong ngoặc.

### Bối cảnh / Context

Mỗi cuốn sách trong hệ thống trải qua các trạng thái khác nhau — đây chính là một **Finite State Machine (FSM)**:

> *"A Finite State Machine is a graph whose nodes represent states... and edges represent transitions among the states."*
> — Ammann & Offutt, Ch.7 §7.5.2, p.224

### Bước 1: Trạng thái (States) và Chuyển tiếp (Transitions)

| Ký hiệu | Trạng thái | State (EN) | Ví dụ trong seed data |
|----------|-----------|------------|----------------------|
| **S1** | Có sẵn | Available | BOOK001, BOOK002 |
| **S2** | Đang mượn | Borrowed | BOOK003 |
| **S3** | Quá hạn | Overdue | Khi quá 14 ngày chưa trả |
| **S4** | Thất lạc | Lost | BOOK007 |

| Ký hiệu | Sự kiện | Trigger (EN) | Từ → Đến |
|----------|---------|-------------|-----------|
| **T1** | Mượn sách | Borrow | S1 → S2 |
| **T2** | Trả sách (đúng hạn) | Return (on time) | S2 → S1 |
| **T3** | Kiểm tra quá hạn | Check overdue | S2 → S3 |
| **T4** | Trả sách (trễ hạn) | Return (late) | S3 → S1 |
| **T5** | Đánh dấu thất lạc | Mark as lost | S3 → S4 |

### Bước 2: Vẽ sơ đồ FSM trên giấy

```
                    T1: Mượn sách                T3: Quá hạn
              ┌─────────────────┐         ┌──────────────────┐
              │                 ▼         │                  ▼
         ┌─────────┐       ┌─────────┐       ┌─────────┐       ┌─────────┐
   ●───→ │   S1    │       │   S2    │       │   S3    │       │   S4    │
         │ Có sẵn  │ ◀──── │Đang mượn│       │ Quá hạn │ ────→ │Thất lạc │
         │Available│  T2:  │Borrowed │       │ Overdue │  T5:  │  Lost   │
         └─────────┘ Trả   └─────────┘       └────┬────┘ Lost  └─────────┘
              ▲              sách                  │
              │                                    │
              └────────────────────────────────────┘
                        T4: Trả sách trễ hạn
```

### Bước 3: Test Paths cho Edge Coverage

Suy ra test paths để **mỗi transition được thực hiện ít nhất 1 lần** (Transition Coverage = Edge Coverage, Ch.7 §7.2.1):

| Test Path | Chuỗi trạng thái | Transitions bao phủ |
|-----------|------------------|---------------------|
| TP1 | S1 → S2 → S1 | `<!-- Nhóm tự điền -->` |
| TP2 | `<!-- Nhóm tự điền -->` | |
| TP3 | | |

### Bước 4: Ánh xạ với Test Case

| Test Path | TC tương ứng | Đã được cover? |
|-----------|-------------|---------------|
| TP1 (mượn → trả) | `<!-- Nhóm tự điền -->` | |
| TP2 | | |
| TP3 | | |

### Câu hỏi thảo luận

a. **Những transition nào** chưa có TC cover? Hãy viết tiêu đề TC mới cho chúng.

b. Hệ thống có **BUG-07** (off-by-one ở kiểm tra quá hạn) — BUG này nằm ở transition nào?

c. Nếu thêm tính năng "Tìm lại sách" (S4 → S1), FSM thay đổi thế nào?

---

## Bài tập 5: Oracle mạnh vs Oracle yếu / The Oracle Strength Challenge

> ⏱ **Thời gian:** 15 phút | **Chương liên quan:** Ch.14 §14.1 (p.410–413)

### Bối cảnh

> *"Some software organizations only check to see whether the software produces a runtime exception, or crashes. This has been called the null oracle strategy. [...] only between 25% to 56% of software failures result in a crash."*
> — Ammann & Offutt, Ch.14 §14.1, p.412

### Kịch bản: TC-06 — Lọc sách theo thể loại "Công nghệ"

So sánh 3 cấp độ **"Kết quả mong đợi"** (= Test Oracle) cho cùng 1 TC:

| Cấp độ | "Kết quả mong đợi" viết trong TC | Loại Oracle |
|--------|----------------------------------|------------|
| **A** | "Hệ thống không bị lỗi" | Null Oracle |
| **B** | "Hiển thị danh sách sách" | Weak Oracle |
| **C** | "Hiển thị 5 sách: BOOK001, BOOK002, BOOK003, BOOK005, BOOK008 — tất cả ghi 'Công nghệ'" | Strong Oracle |

### Nhiệm vụ nhóm

1. **Phân loại:** Oracle nào phát hiện được BUG-06 (bộ lọc case-sensitive: nhập "công nghệ" → 0 kết quả)?

   | Oracle | Phát hiện BUG-06? | Giải thích |
   |--------|-------------------|------------|
   | A (Null) | `<!-- Nhóm tự điền -->` | |
   | B (Weak) | | |
   | C (Strong) | | |

2. **Nhìn lại TC của nhóm bạn** trong `submissions/test-cases.md`: "Kết quả mong đợi" bạn viết thuộc cấp Oracle nào? Có thể cải thiện không?

3. Theo textbook, **không cần kiểm tra mọi thứ** — chỉ cần kiểm tra output **liên quan trực tiếp đến mục đích test**. Áp dụng nguyên tắc này, Oracle C cho TC-06 nên kiểm tra gì?

---

## Bài tập 6: Ai cần chạy lại test? — Regression Test Selection

> ⏱ **Thời gian:** 15 phút | **Chương liên quan:** Ch.13 (p.406–409)

### Bối cảnh

> *"Regression testing constitutes the vast majority of testing effort... small changes to one part of a system often cause problems in distant parts of the system."*
> — Ammann & Offutt, Ch.13, p.406

### Kịch bản giả định

> **Thay đổi V1.1:** Số lượng sách mượn tối đa giảm từ **3 cuốn** xuống **2 cuốn**.

### Nhiệm vụ nhóm

1. **Phân loại 12 Test Cases:**

   | TC | Mô tả | Sẽ FAIL? | Phải chạy lại? | Lý do |
   |-----|-------|---------|---------------|-------|
   | TC-01 | Đăng nhập thành công | `<!-- Nhóm tự điền -->` | | |
   | TC-02 | Đăng nhập sai mật khẩu | | | |
   | TC-03 | Đăng nhập bỏ trống | | | |
   | TC-04 | Tìm kiếm có kết quả | | | |
   | TC-05 | Tìm kiếm không kết quả | | | |
   | TC-06 | Lọc theo thể loại | | | |
   | TC-07 | Tìm theo tác giả | | | |
   | TC-08 | Mượn sách | | | |
   | TC-09 | Xem sách đang mượn | | | |
   | TC-10 | Trả sách | | | |
   | TC-11 | Đăng xuất | | | |
   | TC-12 | Chuyển ngôn ngữ | | | |

2. **Câu hỏi thảo luận:**

   a. TC nào **chắc chắn FAIL** do thay đổi?

   b. TC-08 (mượn bình thường) không FAIL — nhưng vì sao vẫn **phải chạy lại**?

   c. Nếu phải chạy lại tất cả 12 TC **thủ công** (ước tính ~2–3 giờ), bạn sẽ ưu tiên TC nào chạy trước? Theo tiêu chí nào?

---

## Bài tập 7: Tư duy đột biến — Kill the Mutant

> ⏱ **Thời gian:** 15 phút | **Chương liên quan:** Ch.9 §9.1.2 (p.322), §9.2.2 (p.336)

### Bối cảnh

**ROR (Relational Operator Replacement)** — toán tử đột biến thay thế toán tử quan hệ:

> *"Replace each occurrence of one of the relational operators (<, ≤, >, ≥, ==, ≠) by each of the other operators."*
> — Ammann & Offutt, Ch.9 §9.2.2, p.336

### Tình huống 1: BUG-02 — Giới hạn mượn sách

Lập trình viên viết `>` thay vì `>=` (mutant ROR):

```
Code đúng:   if (số_sách_đang_mượn >= 3)  → từ chối mượn thêm
Code lỗi:    if (số_sách_đang_mượn > 3)   → cho mượn cuốn thứ 4!
```

| Số sách đang mượn | Code đúng (`>=`) | Code lỗi (`>`) | Kill mutant? |
|-------------------|-----------------|----------------|-------------|
| 2 | Cho mượn | Cho mượn | Không — cùng KQ |
| 3 | `<!-- Nhóm tự điền -->` | | |
| 4 | | | |

### Tình huống 2: BUG-07 — Kiểm tra quá hạn

```
Code đúng:   if (hôm_nay >= ngày_hẹn)  → quá hạn
Code lỗi:    if (hôm_nay > ngày_hẹn)   → CHƯA quá hạn đúng hôm đó!
```

Sách mượn 1/9, hạn trả 15/9. Ngày nào giết mutant?

| Ngày kiểm tra | Code đúng | Code lỗi | Kill? |
|--------------|----------|---------|-------|
| 14/9 | Chưa quá hạn | Chưa quá hạn | `<!-- Nhóm tự điền -->` |
| **15/9** | | | |
| 16/9 | | | |

### Câu hỏi tổng kết

a. Giá trị test giết mutant luôn nằm ở đâu? (Gợi ý: **giá trị biên** — BVA, Ch.6)

b. Tại sao *"thiết kế test data tốt bằng BVA tự động giết được hầu hết ROR mutants"*?

---

## Phụ lục: Ánh xạ bài tập ↔ textbook

| Bài tập | Khái niệm chính | Chương |
|---|---|---|
| BT1: Box Debate | MDTD, Level of Abstraction | Ch.2 §2.4–2.5, Ch.6 |
| BT2: RIPR Detective | RIPR Model, Test Oracle, Revealability | Ch.2 §2.1, Ch.14 |
| BT3: Test as Guardian | Test Harness, De facto Specification | Ch.4 §4.2 |
| **BT4: Book Lifecycle FSM** | **FSM, State/Transition Coverage, Test Path** | **Ch.7 §7.5.2, §7.2.1** |
| **BT5: Oracle Strength** | **Null Oracle, Oracle Precision, Revealability** | **Ch.14 §14.1** |
| **BT6: Regression Selection** | **Regression Testing, Test Selection, CI** | **Ch.13, Ch.4 §4.2** |
| **BT7: Kill the Mutant** | **Mutation Testing, ROR, BVA ↔ Mutation** | **Ch.9 §9.1.2, §9.2.2, Ch.6** |
