# Bug Reports — Báo cáo lỗi

> **Hướng dẫn**: Tạo 1 mục bug cho mỗi TC có kết quả **Fail**.
> Xem [examples/sample-bug-report.md](../examples/sample-bug-report.md) để hiểu cách viết bug report tốt.
> Mỗi bug cần: tiêu đề mô tả hành vi lỗi, bước tái hiện, expected vs actual, severity + giải thích.

| Thông tin | |
|---|---|
| **Nhóm** | `Nhóm 2` |
| **Ngày báo cáo** | `28/5/2026` |

---


## BUG-01

| Thuộc tính    | Chi tiết |
| ------------- | -------- |
| Mã lỗi        | BUG-01   |
| TC liên quan  | TC-01    |
| REQ liên quan | REQ-01   |
| Mức độ        | Medium   |
| Trạng thái    | Open     |

**Tiêu đề:**
Không đăng nhập được bằng tài khoản Manager được công bố trong SRS (`manager@abc.com`)

**Điều kiện tiên quyết:**
Mở màn hình đăng nhập.

**Bước tái hiện:**

1. Nhập email `manager@abc.com`
2. Nhập mật khẩu `admin123`
3. Nhấn Đăng nhập

**Kết quả mong đợi:**
Đăng nhập thành công theo SRS.

**Kết quả thực tế:**
Hệ thống báo "Không tìm thấy tài khoản".

**Tác động:**
Người kiểm thử không thể sử dụng tài khoản mẫu trong tài liệu SRS.

---

## BUG-02

| Thuộc tính    | Chi tiết |
| ------------- | -------- |
| Mã lỗi        | BUG-02   |
| TC liên quan  | TC-18    |
| REQ liên quan | REQ-07   |
| Mức độ        | Low      |
| Trạng thái    | Open     |

**Tiêu đề:**
Thông tin nhân viên EMP004 không khớp với dữ liệu mô tả trong SRS

**Bước tái hiện:**

1. Đăng nhập bằng tài khoản Manager
2. Mở màn hình Quản lý nhân viên
3. Kiểm tra nhân viên EMP004

**Kết quả mong đợi:**
Theo SRS trạng thái là "Đang làm".

**Kết quả thực tế:**
Trong code trạng thái là "Nghỉ việc".

**Tác động:**
Gây sai lệch dữ liệu kiểm thử và tài liệu đặc tả.
