# Bài tập nhóm — Thảo luận & Nghiên cứu sâu

> 📖 **Textbook:** Paul Ammann & Jeff Offutt, *Introduction to Software Testing*, 2nd Edition.
>
> **Mục tiêu:** Hiểu các khái niệm mới: **RIPR Model**, **Model-Driven Test Design**, **Test Oracle**.

---

## Bài tập 1: Cuộc chiến của những chiếc hộp (The "Box" Debate)

> ⏱ **Thời gian:** 15–20 phút | **Chương liên quan:** Ch.2 §2.4–2.5, Ch.6

### Bối cảnh

Chúng ta thường chia kiểm thử thành **Hộp đen** (Black-box — chỉ nhìn SRS) và **Hộp trắng** (White-box — nhìn code). Nhưng tác giả cho rằng ranh giới này **lỗi thời**:

> *"A more useful question is: what is the level of abstraction of the model from which tests are designed?"*

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

> *"Test cases are the de facto specification — they define what the system actually does."*

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

## Phụ lục: Ánh xạ bài tập ↔ textbook

| Bài tập | Khái niệm chính | Chương |
|---|---|---|
| BT1: Box Debate | MDTD, Level of Abstraction | Ch.2 §2.4–2.5, Ch.6 |
| BT2: RIPR Detective | RIPR Model, Test Oracle, Revealability | Ch.2 §2.1, Ch.14 |
| BT3: Test as Guardian | Test Harness, De facto Specification | Ch.4 §4.2 |
