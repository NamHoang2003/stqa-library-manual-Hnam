# Test Summary — Báo cáo tổng hợp kiểm thử

> **Hướng dẫn**: Đây là hoạt động **Quality Assurance** — bạn đánh giá chất lượng tổng thể của phần mềm, không chỉ liệt kê lỗi.

---

## 1. Thông tin dự án

| Thuộc tính         | Giá trị                    |
| ------------------ | -------------------------- |
| Tên dự án          | Coffee Shop Manager        |
| Loại ứng dụng      | Flutter Mobile Application |
| Phiên bản kiểm thử | Release Candidate          |
| Loại kiểm thử      | Manual Testing             |
| Người thực hiện    | QA Tester                  |
| Ngày thực hiện     | 2026                       |

---

# 2. Mục tiêu kiểm thử

Xác minh các chức năng chính của hệ thống Coffee Shop Manager hoạt động đúng theo tài liệu đặc tả yêu cầu (SRS), bao gồm:

* Đăng nhập hệ thống
* Quản lý menu đồ uống
* Tìm kiếm sản phẩm
* Tạo đơn hàng
* Thanh toán
* Quản lý kho
* Quản lý nhân viên
* Báo cáo doanh thu

---

# 3. Phạm vi kiểm thử

## Trong phạm vi

* Functional Testing
* UI Validation cơ bản
* Data Validation
* Requirement Verification

## Ngoài phạm vi

* Performance Testing
* Security Testing
* Stress Testing
* Automation Testing

---

# 4. Môi trường kiểm thử

| Thành phần         | Giá trị                           |
| ------------------ | --------------------------------- |
| Framework          | Flutter                           |
| Ngôn ngữ           | Dart                              |
| Thiết bị           | Android Emulator / Android Device |
| Database           | Local Mock Data                   |
| Hình thức kiểm thử | Manual                            |

---

# 5. Thống kê Test Case

| Chỉ số            | Giá trị |
| ----------------- | ------- |
| Tổng số Test Case | 20      |
| Đã thực thi       | 20      |
| Pass              | 18      |
| Fail              | 2       |
| Blocked           | 0       |
| Not Run           | 0       |

## Tỷ lệ thành công

Pass Rate = 18 / 20 = 90%

---

# 6. Coverage Requirement

| Requirement                | Trạng thái |
| -------------------------- | ---------- |
| REQ-01 Login               | Covered    |
| REQ-02 Menu Management     | Covered    |
| REQ-03 Search Product      | Covered    |
| REQ-04 Order Creation      | Covered    |
| REQ-05 Payment             | Covered    |
| REQ-06 Inventory           | Covered    |
| REQ-07 Employee Management | Covered    |
| REQ-08 Revenue Report      | Covered    |

Coverage đạt 100% yêu cầu chức năng.

---

# 7. Kết quả theo chức năng

| Chức năng           | Tổng TC | Pass | Fail |
| ------------------- | ------- | ---- | ---- |
| Login               | 6       | 5    | 1    |
| Menu Management     | 2       | 2    | 0    |
| Search Product      | 3       | 3    | 0    |
| Order Creation      | 3       | 3    | 0    |
| Payment             | 2       | 2    | 0    |
| Inventory           | 1       | 1    | 0    |
| Employee Management | 2       | 1    | 1    |
| Revenue Report      | 1       | 1    | 0    |

---

# 8. Phân tích lỗi

## BUG-01

Mức độ: Medium

Nguyên nhân:

* Tài khoản được mô tả trong SRS không tồn tại trong source code.

Ảnh hưởng:

* Gây sai lệch kết quả kiểm thử chức năng Login.

---

## BUG-02

Mức độ: Low

Nguyên nhân:

* Dữ liệu nhân viên trong source code khác dữ liệu trong tài liệu đặc tả.

Ảnh hưởng:

* Gây không nhất quán giữa tài liệu và hệ thống.

---

# 9. Phân loại Bug

| Severity | Số lượng |
| -------- | -------- |
| Critical | 0        |
| High     | 0        |
| Medium   | 1        |
| Low      | 1        |

---

# 10. Đánh giá rủi ro

| Rủi ro                                        | Mức độ          |
| --------------------------------------------- | --------------- |
| Sai lệch dữ liệu giữa tài liệu và source code | Medium          |
| Sai lệch tài khoản mẫu kiểm thử               | Medium          |
| Lỗi nghiệp vụ thanh toán                      | Không phát hiện |
| Lỗi xử lý đơn hàng                            | Không phát hiện |

---

# 11. Điểm mạnh của hệ thống

* Luồng tạo đơn hàng hoạt động chính xác.
* Tính toán thanh toán chính xác.
* Chức năng tìm kiếm hoạt động ổn định.
* Giao diện đơn giản và dễ sử dụng.
* Không phát hiện lỗi gây crash ứng dụng.

---

# 12. Điểm cần cải thiện

* Đồng bộ tài liệu SRS với dữ liệu thực tế.
* Đồng bộ danh sách tài khoản mẫu.
* Đồng bộ dữ liệu nhân viên giữa tài liệu và source code.

---

# 13. Khuyến nghị

Trước khi nghiệm thu:

1. Sửa BUG-01.
2. Sửa BUG-02.
3. Rà soát lại toàn bộ dữ liệu mô tả trong SRS.
4. Cập nhật tài liệu hướng dẫn kiểm thử.

---

# 14. AI Usage Declaration

## Mục đích sử dụng AI

Trong quá trình thực hiện đồ án, công cụ AI ChatGPT được sử dụng với vai trò hỗ trợ biên soạn tài liệu kiểm thử.

## Phạm vi sử dụng

AI chỉ được sử dụng để hỗ trợ soạn thảo nội dung của tài liệu:

* bug-report.md

Các nội dung khác bao gồm:

* Phân tích yêu cầu
* Thiết kế Test Case
* Thực hiện kiểm thử
* Ghi nhận kết quả kiểm thử
* Đánh giá chất lượng hệ thống
* Tổng hợp Test Summary

được thực hiện thủ công dựa trên việc nghiên cứu tài liệu đặc tả yêu cầu (SRS), source code và kết quả kiểm thử thực tế của dự án.

# 15. Kết luận

Đã thực hiện 20/20 test case.

Kết quả:

* Pass: 18
* Fail: 2
* Pass Rate: 90%

Các chức năng nghiệp vụ chính của hệ thống hoạt động đúng. Hai lỗi được ghi nhận đều liên quan đến sự không đồng bộ giữa tài liệu đặc tả và dữ liệu trong source code, không ảnh hưởng đến luồng nghiệp vụ cốt lõi của ứng dụng.

Dự án có thể được xem xét nghiệm thu sau khi hoàn thành việc đồng bộ dữ liệu và cập nhật tài liệu liên quan.
