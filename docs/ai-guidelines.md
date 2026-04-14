# Hướng dẫn sử dụng AI — AI Usage Guidelines

> **Nguyên tắc:** Bạn là **Test Oracle**, AI là **thợ gõ**. AI có thể sinh kịch bản nhanh, nhưng **bạn chịu trách nhiệm đánh giá đúng/sai**. Theo mô hình RIPR đã học, bug chỉ bộc lộ (Revealability) khi Oracle đủ mạnh — và AI thường sinh ra Oracle rất yếu.

---

## 2 Cái bẫy khi dùng AI cho kiểm thử thủ công

### Bẫy 1: Weak Oracle — AI viết Expected Result hời hợt

AI thường sinh expected result mơ hồ kiểu *"Hệ thống hoạt động bình thường"* hoặc *"Trang hiển thị kết quả"* — đó là **Null Oracle** (Ch.14). Bug thật sẽ lọt qua vì bạn không biết **cụ thể** phải kiểm tra gì.

**Ví dụ:**
```
❌ AI thường sinh ra — Null Oracle:
   Expected Result: "Hệ thống xử lý yêu cầu thành công"

✅ Bạn phải sửa lại — Strong Oracle (lấy từ SRS):
   Expected Result: "Hiển thị thông báo 'Mượn sách thành công',
   số sách đang mượn tăng thêm 1, trạng thái sách chuyển sang 'Đang mượn'"
```

**Đối chiếu:** Mỗi Expected Result phải **trích dẫn được từ SRS** — nếu không tìm thấy trong SRS, đó là dấu hiệu Oracle quá yếu hoặc quá mạnh.

### Bẫy 2: AI bịa Test Data — Không khớp hệ thống thật

AI không biết hệ thống thư viện có **Seed Data** cụ thể (tài khoản, sách, thành viên). Nếu AI bịa ra `user: admin@test.com` mà hệ thống không có → test case viết xong mà không chạy được.

**Quy tắc:** Dữ liệu test **phải lấy từ** `docs/test-accounts.md` và mục "Dữ liệu ban đầu" trong SRS. Không dùng data AI tự sinh.

---

## Cách dùng AI hiệu quả

| NÊN | KHÔNG NÊN |
|-----|-----------|
| Copy SRS requirement → nhờ AI gợi ý vùng dữ liệu EP/BVA | Nhờ AI bịa test data — đã có `test-accounts.md` và Seed Data |
| Nhờ AI rà soát lỗi chính tả, cải thiện văn phong bug report | Copy nguyên test case AI sinh ra mà không đối chiếu SRS |
| Copy thông báo lỗi từ hệ thống → nhờ AI phân tích đó là bug hay feature | Nhờ AI viết Expected Result rồi tin ngay — phải tự kiểm tra trong SRS |
| Nhờ AI gợi ý negative scenarios bạn chưa nghĩ tới | Để AI quyết định test case nào quan trọng — bạn mới là Tester |

---

## Khai báo (tùy chọn nhưng khuyến khích)

Nếu nhóm dùng AI, ghi 1 dòng vào phần "Khai báo sử dụng AI" trong `submissions/summary.md`:

> *"Nhóm đã dùng [tên công cụ] để [mục đích cụ thể], sau đó tự đối chiếu lại với SRS."*

Khai báo trung thực **không ảnh hưởng điểm** — đây là kỹ năng minh bạch trong nghề QA.
