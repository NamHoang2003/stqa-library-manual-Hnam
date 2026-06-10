# Test Execution — Kết quả thực thi kiểm thử

> **Hướng dẫn**: Chạy từng TC trên hệ thống https://stqa.rbc.vn, ghi lại kết quả thực tế.
> Kết luận: **Pass** (kết quả đúng), **Fail** (kết quả sai → tạo bug report), **Blocked** (không thực hiện được vì lỗi khác chặn), **Not Run** (chưa chạy).

| Thông tin | |
|---|---|
| **Nhóm** | `Nhóm 2` |
| **Ngày thực thi** | `09/06/2026` |
| **Trình duyệt** | Chrome  |
| **Hệ điều hành** | `Windows` |

---


## Test Execution

| Mã TC | Kết luận | Bug    |
| ----- | -------- | ------ |
| TC-01 | Fail     | BUG-01 |
| TC-02 | Pass     |        |
| TC-03 | Pass     |        |
| TC-04 | Pass     |        |
| TC-05 | Pass     |        |
| TC-06 | Pass     |        |
| TC-07 | Pass     |        |
| TC-08 | Pass     |        |
| TC-09 | Pass     |        |
| TC-10 | Pass     |        |
| TC-11 | Pass     |        |
| TC-12 | Pass     |        |
| TC-13 | Pass     |        |
| TC-14 | Pass     |        |
| TC-15 | Pass     |        |
| TC-16 | Pass     |        |
| TC-17 | Pass     |        |
| TC-18 | Fail     | BUG-02 |
| TC-19 | Pass     |        |
| TC-20 | Pass     |        |

## Tổng hợp

* Tổng TC: 20
* Pass: 18
* Fail: 2
* Blocked: 0
* Not Run: 0
* Tỷ lệ Pass: 90%

### Kết quả theo nhóm chức năng

| Chức năng           | Tổng TC | Pass | Fail | Tỷ lệ Pass |
| ------------------- | ------- | ---- | ---- | ---------- |
| Login               | 6       | 5    | 1    | 83.33%     |
| Menu Management     | 2       | 2    | 0    | 100%       |
| Search Product      | 3       | 3    | 0    | 100%       |
| Order Creation      | 3       | 3    | 0    | 100%       |
| Payment             | 2       | 2    | 0    | 100%       |
| Inventory           | 1       | 1    | 0    | 100%       |
| Employee Management | 2       | 1    | 1    | 50%        |
| Revenue Report      | 1       | 1    | 0    | 100%       |

# Kết quả theo Requirement

| Requirement | Pass | Fail |
| ----------- | ---- | ---- |
| REQ-01      | 5    | 1    |
| REQ-02      | 2    | 0    |
| REQ-03      | 3    | 0    |
| REQ-04      | 3    | 0    |
| REQ-05      | 2    | 0    |
| REQ-06      | 1    | 0    |
| REQ-07      | 1    | 1    |
| REQ-08      | 1    | 0    |

# Danh sách Test Case Fail

| TC    | Bug ID | Mô tả                                               |
| ----- | ------ | --------------------------------------------------- |
| TC-01 | BUG-01 | Không đăng nhập được bằng tài khoản mô tả trong SRS |
| TC-18 | BUG-02 | Thông tin EMP004 không khớp tài liệu đặc tả         |

# Nhận xét

* Các chức năng nghiệp vụ chính hoạt động ổn định.
* Không phát hiện lỗi trong quy trình đặt món và thanh toán.
* Các lỗi phát hiện chủ yếu thuộc nhóm dữ liệu và tài liệu không đồng bộ.

