# Ví dụ mẫu: Báo cáo lỗi (*Sample Bug Report*)

> Đây là ví dụ minh họa từ **hệ thống khác** (ứng dụng máy tính bỏ túi) để bạn hiểu cách viết một báo cáo lỗi hoàn chỉnh. **Áp dụng format này cho hệ thống thư viện, không sao chép nội dung.**

---

## Bug ID
BUG-02

## Tiêu đề
Phép nhân hai số âm cho kết quả âm thay vì dương

## Môi trường
- Trình duyệt: Chrome 120
- Hệ điều hành: Windows 11
- Ứng dụng: Máy tính bỏ túi v2.0

## Điều kiện tiên quyết
- Ứng dụng máy tính đã mở.
- Không có phép tính nào đang thực hiện.

## Bước tái hiện
1. Nhập số: `-5`.
2. Chọn phép tính **Nhân (×)**.
3. Nhập số: `-3`.
4. Nhấn nút **=**.

## Kết quả mong đợi
Hiển thị kết quả `15` (số dương, theo quy tắc toán học: âm × âm = dương).

## Kết quả thực tế
Hệ thống hiển thị kết quả `-15` (số âm). Không có cảnh báo hay thông báo lỗi.

## Tác động
Kết quả tính toán sai, vi phạm quy tắc toán học cơ bản, ảnh hưởng đến mọi phép nhân có số âm. Người dùng nhận được kết quả sai mà không có cảnh báo.

## Mức độ
**Cao (High)**

## Minh chứng
- Ảnh chụp màn hình: *(đính kèm ảnh kết quả hiển thị -15)*
- Video: *(nếu có)*

## Đề xuất xử lý
Kiểm tra lại logic xử lý dấu âm trong phép nhân. Có thể hàm xử lý dấu không tính đúng trường hợp cả hai toán hạng đều âm.

---

## Giải thích cách viết (*Explanation*)

### Tại sao báo cáo lỗi này tốt?

1. **Tiêu đề mô tả hành vi lỗi**: Không viết "Lỗi phép nhân" chung chung mà viết cụ thể chuyện gì xảy ra.
2. **Bước tái hiện có thể lặp lại**: Người khác đọc theo bước 1→4 sẽ thấy cùng lỗi.
3. **So sánh rõ mong đợi vs thực tế**: Người đọc hiểu ngay đâu là lỗi.
4. **Tác động rõ ràng**: Giải thích lỗi ảnh hưởng thế nào đến người dùng/hệ thống.
5. **Mức độ + lý do**: Không chỉ viết “Cao” mà còn giải thích TẠI SAO cao.
6. **Liên kết TC**: Lỗi này phát hiện từ TC nào — giúp truy vết.
7. **Đề xuất xử lý**: Gợi ý hướng sửa giúp Dev hiểu nhanh vấn đề.

### Lỗi thường gặp khi viết báo cáo lỗi

| Sai | Đúng | Lý do |
|-----|------|-------|
| Tiêu đề: "Lỗi phép nhân" | Tiêu đề: "Phép nhân hai số âm cho kết quả âm thay vì dương" | Phải mô tả cụ thể lỗi gì |
| Bước: "Nhân sai" | Bước: 1. Nhập số... 2. Chọn phép tính... | Phải liệt kê từng bước |
| Mức độ: "Cao" | Mức độ: "Cao — kết quả tính toán sai, vi phạm quy tắc toán học cơ bản..." | Phải giải thích lý do |
| Không có minh chứng | Có ảnh chụp/video | Minh chứng giúp xác nhận lỗi, tránh tranh cãi |
| Không có đề xuất | Có đề xuất xử lý cụ thể | Gợi ý giúp Dev hiểu và sửa nhanh hơn |
### Mối liên hệ với trường hợp kiểm thử

Báo cáo lỗi được tạo khi **một TC không đạt** (Fail):
- TC mong đợi kết quả X (theo SRS)
- TC thực tế cho kết quả Y
- X ≠ Y → Tạo Bug Report để ghi nhận lỗi
