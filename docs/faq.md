# FAQ — Câu hỏi thường gặp

---

### 1. Hệ thống cần kiểm thử ở đâu?

Truy cập tại **https://stqa.rbc.vn**. Hệ thống là một ứng dụng web quản lý mượn sách thư viện, chạy trên trình duyệt Chrome. Nếu link không hoạt động, hãy hỏi giảng viên.

### 2. Bài tập A1 có cần biết lập trình không?

**Không.** Bài A1 là kiểm thử thủ công (manual testing) — bạn chỉ kiểm thử qua giao diện, viết test case và bug report bằng Markdown. Không cần đọc hay viết code.

### 3. EP, BVA, Decision Table là gì?

Xem giải thích chi tiết tại [glossary.md](glossary.md). Tóm tắt:
- **EP**: Chia dữ liệu thành nhóm, mỗi nhóm test 1 giá trị đại diện.
- **BVA**: Test ở ranh giới các nhóm (nơi lỗi hay xảy ra).
- **Decision Table**: Liệt kê mọi tổ hợp điều kiện → kết quả.

### 4. Kết quả mong đợi (expected result) lấy từ đâu?

Từ tài liệu **SRS** — [docs/SRS-library-system.md](SRS-library-system.md). Mỗi REQ đều ghi rõ hệ thống **phải** làm gì. Đó chính là expected result. Đọc kỹ cột "Quy tắc", "Thông báo lỗi", "Quyền truy cập" trong mỗi REQ.

### 5. Template trống quá, em không biết điền gì?

Hãy xem các ví dụ mẫu:
- [examples/sample-test-case.md](../examples/sample-test-case.md) — TC mẫu chi tiết
- [examples/sample-bug-report.md](../examples/sample-bug-report.md) — Bug report mẫu

Chú ý: các ví dụ mẫu dùng hệ thống khác để minh họa — hãy áp dụng **format** tương tự cho hệ thống thư viện.

### 6. Viết 20 test case thế nào cho đủ?

Đọc SRS và phân bổ đều cho **tất cả 8 REQ** (REQ-01 → REQ-08). Chức năng phức tạp hơn (nhiều quy tắc, nhiều điều kiện) cần nhiều TC hơn. Bao gồm cả happy path, negative và boundary cho mỗi chức năng.

### 7. Em có thể dùng tiếng Việt hoàn toàn không?

**Có.** Viết bài hoàn toàn bằng tiếng Việt — chỉ cần giữ đúng cấu trúc template.

### 8. Em tìm thấy lỗi nhưng không chắc có phải lỗi thật không?

Hãy báo cáo! Trong kiểm thử, việc báo cáo sai (*false positive*) vẫn tốt hơn bỏ sót lỗi. Miễn là bạn mô tả rõ ràng các bước tái hiện, giảng viên sẽ xác nhận giúp bạn.

### 9. Software Testing và Quality Assurance khác nhau thế nào?

- **Software Testing**: Tìm lỗi trong sản phẩm → bạn đang làm khi viết TC và chạy test.
- **Quality Assurance**: Đánh giá quy trình và chất lượng tổng thể → bạn đang làm khi viết Summary.

Xem thêm tại [README.md](../README.md#software-testing-vs-quality-assurance--khác-nhau-thế-nào).

### 10. Bao giờ nộp?

Hạn nộp do giảng viên thông báo trong lớp. Kiểm tra thường xuyên trên nhóm lớp hoặc GitHub Issues.
