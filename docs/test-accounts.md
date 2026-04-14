# Tài khoản kiểm thử / Test Accounts

**Hệ thống**: https://stqa.rbc.vn

> ⚠️ Dữ liệu được lưu trong bộ nhớ trình duyệt. Mỗi tab là phiên riêng biệt. Refresh trang = dữ liệu trở về trạng thái ban đầu.

---

## Tài khoản Thủ thư / Librarian Account

| Mục | Giá trị |
|-----|---------|
| Email | `librarian@library.com` |
| Mật khẩu | `admin123` |
| Vai trò | Thủ thư (Librarian) |
| Tên hiển thị | Nguyễn Thủ Thư |

**Quyền đặc biệt**: Xem tất cả phiếu mượn, thêm thành viên, kiểm tra quá hạn, khôi phục dữ liệu.

---

## Tài khoản Thành viên / Member Accounts

| Email | Mật khẩu | Tên hiển thị | ID | Trạng thái |
|-------|----------|-------------|-----|-----------|
| `ba.nguyen@email.com` | `password123` | Nguyễn Học Bá | MEM002 | ✅ Hoạt động |
| `dam.tran@email.com` | `password123` | Trần Dựa Dẫm | MEM003 | ✅ Hoạt động |
| `cu.le@email.com` | `password123` | Lê Cần Cù | MEM004 | 🔴 Tạm ngưng |
| `binh.pham@email.com` | `password123` | Phạm Trung Bình | MEM005 | 🔴 Hết hạn |
| `biet.hoang@email.com` | `password123` | Hoàng Cá Biệt | MEM006 | ✅ Hoạt động |

---

## Tài khoản không hợp lệ (dùng cho test thất bại)

| Kịch bản | Email | Mật khẩu |
|----------|-------|----------|
| Email không tồn tại | `nobody@test.com` | `anything` |
| Sai mật khẩu | `ba.nguyen@email.com` | `wrongpassword` |
| Bỏ trống | *(để trống)* | *(để trống)* |

---

## Khôi phục dữ liệu / Data Reset

Hệ thống lưu dữ liệu tạm trong bộ nhớ. Khi cần đưa về trạng thái gốc:

**Cách 1**: Refresh trang (F5) — dữ liệu tự động reset.

**Cách 2**: Đăng nhập Thủ thư → nhấn nút **🔄** trên thanh ứng dụng → xác nhận "Đặt lại".

> 💡 **Mẹo**: Luôn reset dữ liệu trước mỗi nhóm test case để đảm bảo dữ liệu ban đầu (seed data) đúng trạng thái.
