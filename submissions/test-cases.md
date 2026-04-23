# Test Cases — Bảng trường hợp kiểm thử

> **Hướng dẫn**: Viết tối thiểu **20 TC** phủ đủ các chức năng chính (REQ-01 → REQ-08).
> Xem [examples/sample-test-case.md](../examples/sample-test-case.md) để hiểu cách viết TC tốt.
> Tự tổ chức và phân nhóm test case theo cách hợp lý nhất.

| Thông tin | |
|---|---|
| **Nhóm** | `Hnam` |
| **Ngày tạo** | `16/4/2026` |
| **Hệ thống** | https://stqa.rbc.vn |
| **Tham chiếu** | SRS v1.0 |

---

## Bước 1: Mô hình hóa miền đầu vào — Input Domain Modeling (IDM)

> 📖 **Textbook:** Chương 6 — *Input Domain Modeling*, Paul Ammann & Jeff Offutt.
>
> **Trước khi viết Test Case**, nhóm **phải** phân tích miền đầu vào bằng bảng IDM bên dưới.
> Mỗi chức năng cần xác định: **Đặc tính (Characteristic)**, **Phân vùng (Block/Partition)**, và **Giá trị đại diện (Value)**.

### IDM — Đăng nhập (REQ-01)

| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value)                        | Kết quả mong đợi                          |
| ------------------------- | ----------------- | ----------------------------------------------- | ----------------------------------------- |
| Email tồn tại             | Có                | [manager@coffee.com](mailto:manager@coffee.com) | Tiếp tục kiểm tra mật khẩu                |
|                           | Không             | [noone@email.com](mailto:noone@email.com)       | Báo lỗi "Không tìm thấy tài khoản"        |
| Mật khẩu                  | Đúng              | admin123                                        | Đăng nhập thành công                      |
|                           | Sai               | wrongpass                                       | Báo lỗi "Mật khẩu không đúng"             |
| Ô nhập                    | Không rỗng        | [user@gmail.com](mailto:user@gmail.com)         | Xử lý bình thường                         |
|                           | Rỗng              | ""                                              | Báo lỗi "Vui lòng nhập email và mật khẩu" |
| Quyền truy cập            | Manager           | [manager@coffee.com](mailto:manager@coffee.com) | Hiển thị giao diện quản lý                |
|                           | Staff             | [staff@coffee.com](mailto:staff@coffee.com)     | Hiển thị giao diện nhân viên              |


### IDM — xem danh sách sách đồ uống (REQ-02)

| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value) | Kết quả mong đợi                     |
| ------------------------- | ----------------- | ------------------------ | ------------------------------------ |
| Quyền truy cập            | Manager           | manager                  | Xem được danh sách                   |
|                           | Staff             | staff                    | Xem được danh sách                   |
| Dữ liệu menu              | Có dữ liệu        | 10 món                   | Hiển thị đầy đủ tên, giá, trạng thái |
|                           | Không có dữ liệu  | 0 món                    | Hiển thị "Không có dữ liệu"          |
| Trạng thái món            | Còn               | Available                | Hiển thị "Còn"                       |
|                           | Hết               | Out of stock             | Hiển thị "Hết"                       |
| Hiển thị thông tin        | Đầy đủ            | Tên + giá + trạng thái   | Hiển thị đúng                        |
|                           | Thiếu dữ liệu     | Thiếu giá                | Báo lỗi hoặc hiển thị thiếu          |


### IDM — Quản lý thành viên (REQ-03)
 
| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value) | Kết quả mong đợi |
|---|---|---|---|
| Tìm theo tên | Hợp lệ  | `Coffee` | Hiển thị đúng đồ uống  |
| | Không tồn tại | `Trà xoài đặc biệt` | Không có kết quả |
| | Gần đúng | `Coffee sữa` | Gợi ý hiển thị gần đúng |
| | Rỗng  | `` | Hiển thị toàn bộ menu ||
| Lọc theo loại | Hợp lệ  | `Coffee` | Hiển thị danh sách coffee  |
| | Hợp lệ  | `Trà sữa` | Hiển thị danh sách trà sữa  |
| | Hợp lệ  | `Coffee` | Hiển thị danh sách coffee  |
| | Hợp lệ  | `Sinh tố` | Hiển thị danh sách sinh tố  |
| | Không hợp lệ  | `Nước ép` | Không có kết quả/Báo lỗi  ||
| Kết hợp tìm và lọc | Cả 2 hợp lệ  | `Coffee`+`Coffee` | Hiển thị đúng kết quả phù hợp  |
| | Tên đúng,loại sai  | `Coffee`+`Sinh tố` | Không có kết quả  |
| | Cả 2 rỗng  | ``+`` | Hiển thị toàn bộ menu  |
| Ô nhập | Không nhập  | null | Xử lý bình thường  |
| | Chỉ khoảng trắng  | `` | Thông báo hoặc coi như rỗng  ||
### IDM — Tạo đơn hàng (REQ-04)
 
| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value) | Kết quả mong đợi |
|---|---|---|---|
| Tạo đơn hàng | Hợp lệ | Thêm 1 món(Coffee sữa) | Tạo đơn hàng thành công |
| | Hợp lệ | Thêm nhiều món | Tạo đơn thành công |
| | Không có món | 0 món | Báo lỗi/Không tạo được |
| Thêm món vào đơn | Hợp lệ | Chọn món từ menu | Món được thêm vào đơn |
| | Trùng món | Thêm 2 lần cùng 1 món | Tăng số lượng |
| | Không tồn tại  | `abcxyz` | Báo lỗi  ||
| Số lượng | Hợp lệ | 1,2,3 | Tính tiền đúng |
| | =0 | 0 | Báo lỗi |
| | Âm  | -1 | Báo lỗi  ||
| | Quá lớn  | 9999 | Cảnh báo giới hạn  ||
| Xóa món | Có | Xóa 1 món trong đơn | Món bị xóa |
| | Không tồn tại  | Xóa món không có | Không thay đổi/Báo lỗi  ||
| Cập nhật số lượng | Hợp lệ | TỪ 1 -> 3 | Cập nhật thành công |
| | Không hợp lệ  | -2 | Báo lỗi  ||
| Tổng tiền | Hợp lệ | Nhiều món | Tính tổng chính xác |
| | Không có món  | 0 | Tổng=0  ||
| Thanh toán | Hợp lệ | Xác nhận đơn | Lưu đơn thành công |
| | Chưa có món  | 0 món | Không cho thanh toán  ||
| Ô nhập | Rỗng | `` | Thông báo `Vui lòng nhập `  |
| | Null  | null | Xử lý bình thường  ||

### IDM — Thanh toán đơn hàng (REQ-05)
| Đặc tính (Characteristic) | Phân vùng (Block)  | Giá trị đại diện (Value)    | Kết quả mong đợi                     |
| ------------------------- | ------------------ | --------------------------- | ------------------------------------ |
| Tính tổng tiền            | Hợp lệ             | Đơn hàng có nhiều món       | Tổng = ∑ (Đơn giá × Số lượng)        |
|                           | Giỏ hàng trống     | 0 món                       | Không cho phép thanh toán            |
| Áp dụng giảm giá          | Mã hợp lệ          | Voucher giảm 10%            | Giảm đúng 10% trên tổng hóa đơn      |
|                           | Mã hết hạn         | Voucher đã quá hạn          | Báo lỗi "Mã hết hạn", không giảm giá |
|                           | Không đủ điều kiện | Đơn < 200k                  | Báo lỗi "Không đủ điều kiện áp dụng" |
| Ghi nhận thanh toán       | Tiền mặt           | Khách đưa 200k cho đơn 150k | Tiền thừa 50k, in hóa đơn            |
|                           | Chuyển khoản       | Quét QR thành công          | Xác nhận thanh toán                  |
| Trạng thái đơn hàng       | Sau thanh toán     | Nhấn "Hoàn tất"             | Trạng thái = "Đã thanh toán"         |
| Ô nhập (Tiền khách đưa)   | Số âm              | -50000                      | Báo lỗi giá trị không hợp lệ         |
|                           | Nhập chữ           | abc                         | Báo lỗi định dạng                    |


### IDM — Quản lý kho nguyên liệu (REQ-06)
| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value)  | Kết quả mong đợi         |
| ------------------------- | ----------------- | ------------------------- | ------------------------ |
| Kiểm tra tồn kho          | Còn hàng          | Số lượng > 0              | Hiển thị đúng số lượng   |
|                           | Hết hàng          | Số lượng = 0              | Hiển thị "Hết hàng"      |
| Cập nhật khi nhập         | Hợp lệ            | +5kg cà phê               | Tồn mới = tồn cũ + 5     |
|                           | Không hợp lệ      | -2kg                      | Báo lỗi số lượng         |
| Cập nhật khi bán          | Tự động trừ       | Bán 1 ly                  | Trừ đúng nguyên liệu     |
|                           | Không đủ          | Kho 0.1kg, cần 0.2kg      | Báo lỗi không đủ         |
| Cảnh báo ngưỡng           | Chạm ngưỡng       | ≤ mức tối thiểu           | Hiển thị cảnh báo        |
| Xóa nguyên liệu           | Hợp lệ            | Xóa "Trân châu"           | Xóa thành công           |
|                           | Có liên kết       | Đang dùng trong công thức | Không cho xóa            |
| Ô nhập                    | Rỗng              | ""                        | Báo lỗi "Không để trống" |
|                           | Ký tự đặc biệt    | @#$%                      | Báo lỗi                  |

### IDM — Quản lý nhân viên (REQ-07)
 
| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value) | Kết quả mong đợi |
|---|---|---|---|
| Quyền truy cập | Quản lý | Admin001 | Cho phép thực hiện |
| | Không phải quản lý | Staff001 | Từ chối truy cập |
| Thêm nhân viên | Dữ liệu hợp lệ | Tên: A, Email: a@gmail.com | Thêm thành công |
| | Thiếu thông tin | Thiếu email | Báo lỗi |
| | Email sai format | agmail.com | Báo lỗi |
| | Email trùng | a@gmail.com (đã tồn tại) | Từ chối |
| Sửa nhân viên | Hợp lệ | Sửa tên/email | Cập nhật thành công |
| | Không tồn tại | ID NULL | Báo lỗi |
| Xóa nhân viên | Tồn tại | EMP001 | Xóa thành công |
| | Không tồn tại | EMP NULL | Báo lỗi |
| Trạng thái nhân viên | Đang làm | EMP002 | Hoạt động bình thường |
| | Nghỉ việc | EMP003 | Không cho phép thao tác nghiệp vụ (nếu có rule) |
| Chuyển trạng thái | Đang làm → Nghỉ việc | EMP002 | Cập nhật thành công |
| | Nghỉ việc → Đang làm | EMP003 | Cập nhật thành công |
 
### IDM — Báo cáo doanh thu (REQ-08)
 
| Đặc tính (Characteristic) | Phân vùng (Block) | Giá trị đại diện (Value) | Kết quả mong đợi |
|---|---|---|---|
| Quyền truy cập | Quản lý | Admin001 | Cho phép xem |
| | Không phải quản lý | Staff001 | Từ chối |
| Thời gian xem | Theo ngày | 16/04/2026 | Hiển thị doanh thu ngày |
| | Theo tuần | Tuần 15 | Hiển thị doanh thu tuần |
| | Không có dữ liệu | Ngày không có đơn | Hiển thị 0 hoặc thông báo |
| Dữ liệu doanh thu | Có đơn hàng | 10 đơn | Tính tổng chính xác |
| | Không có đơn | 0 đơn | Doanh thu = 0 |
| Top món bán chạy | Có dữ liệu | Món A (50 đơn) | Hiển thị top đúng |
| | Không có dữ liệu | Không có đơn | Thông báo phù hợp |
| Đơn hàng quá hạn | Có đơn quá hạn | ORD001 (chưa thanh toán) | Hiển thị danh sách |
| | Không có | Không có đơn | Hiển thị rỗng |
| Trạng thái đơn | Đã thanh toán | ORD002 | Không tính quá hạn |
| | Chưa thanh toán | ORD003 | Kiểm tra quá hạn |
> 💡 **Gợi ý kỹ thuật**: Sử dụng **Phân lớp tương đương (EP)** cho các phân vùng rời rạc, **Phân tích giá trị biên (BVA)** cho các phân vùng số (ví dụ: giới hạn 3 sách). Xem textbook §6.1–6.3.

---

## Bước 2: Test Cases

<!-- Tự tổ chức bảng test case: có thể chia nhóm theo chức năng, theo REQ, hoặc theo luồng nghiệp vụ — tùy nhóm quyết định. -->
<!-- Mỗi TC phải ánh xạ ngược về ít nhất 1 dòng trong bảng IDM ở Bước 1. -->

| Mã TC | Mục tiêu kiểm thử | Tiền điều kiện | Bước thực hiện | Dữ liệu đầu vào | Kết quả mong đợi | REQ | Kỹ thuật |
|-------|-------------------|---------------|---------------|-----------------|------------------|-----|---------|
| | | | | | | | |

---

## Tổng hợp

| Nhóm chức năng | Số TC | REQ phủ | Kỹ thuật IDM áp dụng |
|----------------|-------|---------|----------------------|
| | | | |
| **Tổng** | **<!-- ≥ 20 -->** | | |
