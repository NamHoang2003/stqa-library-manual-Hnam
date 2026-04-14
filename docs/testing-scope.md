# Phạm vi kiểm thử / Testing Scope

---

## Trong phạm vi / In Scope

- Đăng nhập và xác thực dữ liệu đầu vào (*Login and input validation*)
- Xem, tìm kiếm, và lọc sách (*Book listing, searching, and filtering*)
- Luồng mượn/trả sách theo quy tắc nghiệp vụ (*Borrow and return flows with business rules*)
- Xử lý sách quá hạn (*Overdue handling*)
- Thêm thành viên mới và kiểm tra form (*Member creation and form validation*)
- Tra cứu phiếu mượn theo quyền truy cập (*Borrow-record lookup based on access rules*)

## Ngoài phạm vi / Out of Scope

- Kiểm thử giao diện theo thiết kế UI/UX (*Không có tài liệu Figma/mockup — chỉ kiểm thử logic theo SRS*)
- Kiểm thử xâm nhập chuyên sâu (*Advanced penetration testing*)
- Kiểm thử hiệu năng nâng cao (*Advanced performance testing*)
- Kiểm thử trên thiết bị di động (*Mobile-specific validation*)
- Ma trận đa trình duyệt (*Multi-browser matrix*)
- Kiểm thử mã nguồn (*White-box testing / code review*)

## Môi trường kiểm thử / Test Environment

| Mục | Giá trị |
|-----|---------|
| URL | https://stqa.rbc.vn |
| Trình duyệt | Chrome bản mới nhất |
| Ngôn ngữ | Tiếng Việt (mặc định) |
| Dữ liệu | Client-side, reset khi refresh |
| Công nghệ | Flutter Web (CanvasKit) |
