# Thuật ngữ kiểm thử / Testing Glossary

Bảng giải thích các thuật ngữ dùng trong môn học. Nếu gặp từ lạ, hãy tra ở đây trước.

---

## Thuật ngữ chung / General Terms

| Thuật ngữ | Tiếng Việt | Giải thích đơn giản |
|-----------|-----------|---------------------|
| **Test Case (TC)** | Trường hợp kiểm thử | Một kịch bản cụ thể mô tả: điều kiện đầu vào → hành động → kết quả mong đợi. Giống như viết "nếu nhập X thì phải ra Y". |
| **Test Execution** | Thực thi kiểm thử | Quá trình chạy thật các TC trên hệ thống và ghi lại kết quả đạt/không đạt. |
| **Bug Report** | Báo cáo lỗi | Tài liệu mô tả chi tiết một lỗi: cách tái hiện, kết quả mong đợi vs thực tế, mức độ nghiêm trọng. |
| **Severity** | Mức độ nghiêm trọng | Lỗi ảnh hưởng nghiêm trọng đến mức nào (Cao / Trung bình / Thấp). Đánh giá từ góc **kỹ thuật**. |
| **Priority** | Mức độ ưu tiên | Cần sửa lỗi này **nhanh** đến mức nào (Khẩn cấp / Cao / Trung bình / Thấp). Đánh giá từ góc **kinh doanh**. |
| **Precondition** | Điều kiện tiên quyết | Những gì phải đúng/sẵn sàng TRƯỚC KHI thực hiện kiểm thử. VD: "Đã đăng nhập". |
| **Expected Result** | Kết quả mong đợi | Kết quả đúng theo SRS — hệ thống **PHẢI** trả về như thế này. |
| **Actual Result** | Kết quả thực tế | Kết quả hệ thống **THẬT SỰ** trả về khi bạn chạy kiểm thử. |
| **Pass / Fail** | Đạt / Không đạt | Actual = Expected → Pass. Khác nhau → Fail → tạo Bug Report. |
| **SRS** | Đặc tả yêu cầu phần mềm | Tài liệu mô tả hệ thống **phải** làm gì. Đây là "nguồn sự thật" để viết Expected Result. |
| **Regression Testing** | Kiểm thử hồi quy | Chạy lại TC cũ sau khi sửa lỗi để đảm bảo không phát sinh lỗi mới. |

## Khái niệm QA / Quality Concepts

| Thuật ngữ | Tiếng Việt | Giải thích đơn giản |
|-----------|-----------|---------------------|
| **Software Testing** | Kiểm thử phần mềm | Tìm lỗi trong sản phẩm. Hỏi: "Phần mềm có lỗi không?" |
| **Quality Assurance (QA)** | Đảm bảo chất lượng | Ngăn ngừa lỗi qua quy trình. Hỏi: "Quy trình có tốt không?" |
| **Quality Control (QC)** | Kiểm soát chất lượng | Kiểm tra sản phẩm cuối. Tester thường đóng vai QC. |
| **Defect / Bug** | Lỗi phần mềm | Hệ thống hoạt động khác với SRS. |
| **Stakeholder** | Bên liên quan | Tất cả người/nhóm có liên quan: khách hàng, dev, tester, PM, end user. |

## Kỹ thuật thiết kế kiểm thử / Test Design Techniques

| Thuật ngữ | Tiếng Việt | Giải thích đơn giản |
|-----------|-----------|---------------------|
| **Black-box Testing** | Kiểm thử hộp đen | Kiểm thử dựa trên yêu cầu và giao diện, KHÔNG cần đọc mã nguồn. Bạn chỉ quan tâm: nhập gì → ra gì. |
| **Equivalence Partitioning (EP)** | Phân lớp tương đương | Chia dữ liệu đầu vào thành các nhóm tương đương, mỗi nhóm chỉ cần test 1 giá trị đại diện. VD: tuổi hợp lệ 18-60 → chọn 25 làm đại diện. |
| **Boundary Value Analysis (BVA)** | Phân tích giá trị biên | Tập trung test tại ranh giới các nhóm — nơi lỗi hay xảy ra nhất. VD: tuổi 18-60 → test 17, 18, 60, 61. |
| **Decision Table** | Bảng quyết định | Bảng liệt kê TẤT CẢ tổ hợp điều kiện và kết quả tương ứng. Dùng khi chức năng có nhiều điều kiện kết hợp. |

## Thuật ngữ Git / Git Terms

| Thuật ngữ | Tiếng Việt | Giải thích đơn giản |
|-----------|-----------|---------------------|
| **Fork** | Phân nhánh kho mã | Tạo bản sao repo về tài khoản GitHub cá nhân để tự do chỉnh sửa. |
| **Clone** | Sao chép | Tải toàn bộ repo từ GitHub về máy tính cá nhân. |
| **Commit** | Lưu thay đổi | Ghi lại một lần thay đổi kèm mô tả ngắn. Giống "Save" nhưng có lịch sử. |
| **Pull Request (PR)** | Yêu cầu gộp mã | Yêu cầu giảng viên xem xét và nhập bài làm của bạn. |
