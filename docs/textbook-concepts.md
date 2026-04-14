# Khái niệm Textbook — Liên kết Lý thuyết ↔ Thực hành

> 📖 **Textbook:** Paul Ammann & Jeff Offutt, *Introduction to Software Testing*, 2nd Edition.
>
> Tài liệu này giải thích cách các khái niệm trong textbook được **áp dụng trực tiếp** trong bài tập manual testing này.

---

## 1. Input Domain Modeling — IDM (Ch.6)

### Tại sao phải "mô hình hóa" trước khi viết Test Case?

Nhiều sinh viên viết TC theo cảm tính: nghĩ ra kịch bản nào thì viết kịch bản đó. Kết quả: **bỏ sót** nhiều trường hợp quan trọng.

**IDM** (Input Domain Modeling) là phương pháp **hệ thống hóa** việc chọn dữ liệu kiểm thử:

```
Yêu cầu (REQ) → Xác định Đặc tính → Chia Phân vùng → Chọn Giá trị đại diện → Viết TC
```

### 3 bước IDM

| Bước | Mô tả | Ví dụ: Đăng nhập (REQ-01) |
|---|---|---|
| **1. Đặc tính** (Characteristic) | Thuộc tính ảnh hưởng đến hành vi | "Email có tồn tại trong DB?" |
| **2. Phân vùng** (Block/Partition) | Chia thành nhóm có hành vi giống nhau | Block 1: Có, Block 2: Không |
| **3. Giá trị** (Value) | Chọn đại diện từ mỗi phân vùng | Có: `librarian@library.com` / Không: `noone@email.com` |

### Áp dụng trong bài tập

File `submissions/test-cases.md` đã có **bảng IDM mẫu** cho REQ-01, REQ-03, REQ-04/05. Nhóm cần:
1. Đọc bảng IDM mẫu → hiểu cách phân tích
2. **Tự bổ sung** bảng IDM cho REQ-05 → REQ-08
3. **Mỗi TC phải ánh xạ** ngược về ít nhất 1 dòng trong bảng IDM

### Kỹ thuật kết hợp

| Kỹ thuật | Khi nào dùng | Ví dụ trong bài |
|---|---|---|
| **EP** (Phân lớp tương đương) | Chia input thành nhóm rời rạc | Email: hợp lệ / không hợp lệ / rỗng |
| **BVA** (Phân tích giá trị biên) | Input là dải số có giới hạn | Mượn sách: 0, 1, 2, **3** (giới hạn), 4 |
| **Decision Table** (Bảng quyết định) | Nhiều điều kiện kết hợp | Trạng thái thành viên × Trạng thái sách × Số sách đang mượn |

---

## 2. RIPR Model — Hiểu tại sao test phát hiện hoặc bỏ sót lỗi (Ch.2)

Dù là manual hay automation, mô hình RIPR giải thích **khi nào test tìm được bug**:

| Bước | Ý nghĩa | Ví dụ: TC tìm kiếm sách |
|---|---|---|
| **R** — Reachability | Bạn phải **chạm tới** chức năng cần test | Phải đăng nhập trước, vào tab Sách |
| **I** — Infection | Dữ liệu đầu vào phải **gây ra trạng thái sai** | Nhập "công nghệ" (chữ thường) vào ô lọc |
| **P** — Propagation | Trạng thái sai phải **lan truyền ra kết quả** | Danh sách sách hiển thị không đúng |
| **R** — Revealability | Bạn phải **quan sát và nhận ra** kết quả sai | So sánh kết quả thực tế với kết quả mong đợi |

### Áp dụng cho Manual Testing

- **R** = Tiền điều kiện + Bước thực hiện (đi đúng đường đến chức năng)
- **I** = Dữ liệu đầu vào (chọn giá trị test phù hợp từ IDM)
- **P** = Bước quan sát (giao diện có cập nhật không?)
- **R** = Kết quả mong đợi (bạn **biết** kết quả đúng phải là gì → từ SRS)

> 💡 **Bài test của bạn có thể PASS giả** nếu Revealability yếu — ví dụ: "Kết quả mong đợi: Hệ thống hoạt động bình thường" → quá chung chung, không phát hiện được lỗi!

---

## 3. Test Doubles — Tại sao hệ thống không cần server? (Ch.12)

Hệ thống tại https://stqa.rbc.vn sử dụng kiến trúc **Test Double**:

- **Không có server/database thật** — tất cả xử lý trong trình duyệt
- **Dữ liệu seed cố định**: 20 sách, 6 thành viên, 5 phiếu mượn
- **Reset = Refresh trang**: dữ liệu trở về ban đầu → đảm bảo test lặp lại được

### Ý nghĩa cho Manual Tester

| Đặc điểm | Lợi ích cho bạn |
|---|---|
| Dữ liệu cố định | Biết trước BOOK001 → BOOK020, MEM001 → MEM006 |
| Reset dễ dàng | Mỗi lần test = trạng thái sạch (không cần nhờ admin) |
| Không phụ thuộc mạng | Test ổn định — không bị lỗi timeout / server down |
| Bug cố ý | Hệ thống có 7 bug ẩn — bạn tìm được bao nhiêu? |

---

## 4. Mức độ trỪu tượng — Vượt qua Black-box / White-box (Ch.2 §2.4–2.5)

### Góc nhìn mới của textbook

Lâu nay ta chia kiểm thử thành **Black-box** (chỉ nhìn SRS) và **White-box** (nhìn code). Nhưng tác giả cho rằng:

> *"Thus asking whether a coverage criterion is black-box or white-box is the wrong question. One more properly should ask from what level of abstraction is the structure drawn."*
> — Ammann & Offutt, Ch.2, p.58

Trong bài tập này:
- Bạn thiết kế TC từ **SRS** → đó là một **model** ở mức trừu tượng cao
- Nếu bạn đọc **dữ liệu seed** (test-accounts.md) → đó là model ở mức thấp hơn
- Câu hỏi đúng không phải "Black hay White?" mà là **"Model nào? Mức trừu tượng nào?"**

---

## Tóm tắt: Ánh xạ bài tập ↔ textbook

| Hoạt động trong bài | Khái niệm textbook | Chương |
|---|---|---|
| Bảng IDM trong `submissions/test-cases.md` | Input Domain Modeling (IDM) | Ch.6 §6.1–6.3 |
| Kỹ thuật EP, BVA, Decision Table | Input Space Partitioning | Ch.6 |
| Viết "Kết quả mong đợi" rõ ràng | Test Oracle / Revealability | Ch.14, Ch.2 §2.1 |
| Thiết kế TC từ SRS | Model-Driven Test Design (MDTD) | Ch.2 §2.5 |
| Hệ thống chạy không cần server | Test Doubles (Stub/Mock) | Ch.12 |
| Bug report khi TC Fail | Fault Detection — RIPR Model | Ch.2 |
| `group-exercises.md` BT4: FSM vòng đời sách | FSM, State/Transition Coverage | Ch.7 §7.5.2, §7.2.1 |
| `group-exercises.md` BT5: Oracle mạnh/yếu | Null Oracle, Oracle Precision | Ch.14 §14.1 |
| `group-exercises.md` BT6: Regression Selection | Regression Testing, Test Selection | Ch.13 |
| `group-exercises.md` BT7: Kill the Mutant | Mutation Testing, ROR, BVA↔Mutation | Ch.9 §9.1.2, §9.2.2, Ch.6 |
