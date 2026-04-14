# Ví dụ mẫu: Trường hợp kiểm thử (*Sample Test Case*)

> Đây là ví dụ minh họa từ **hệ thống khác** (ứng dụng máy tính bỏ túi) để bạn hiểu cách viết một trường hợp kiểm thử hoàn chỉnh. **Áp dụng format này cho hệ thống thư viện, không sao chép nội dung.**

---

| Mã TC | Mục tiêu kiểm thử | Tiền điều kiện | Bước thực hiện | Dữ liệu đầu vào | Kết quả mong đợi | REQ | Kỹ thuật |
|-------|-------------------|---------------|---------------|-----------------|------------------|-----|--------|
| TC-03 | Chia cho số 0 | Ứng dụng máy tính đã mở | 1. Nhập `10` vào ô số bị chia. 2. Chọn phép tính **Chia (/)**. 3. Nhập `0` vào ô số chia. 4. Nhấn nút **=**. | Số bị chia: `10`, Số chia: `0` | Hiển thị thông báo lỗi “Không thể chia cho 0”. Không hiển thị kết quả số. | REQ-02 | EP, BVA |

---

## Giải thích cách viết (*Explanation*)

### Tại sao TC này tốt?

1. **Mã TC rõ ràng**: `TC-03` — đánh số liên tục, dễ tham chiếu từ báo cáo lỗi.
2. **REQ cụ thể**: Liên kết đến `REQ-02` để biết đang test yêu cầu nào.
3. **Mục tiêu kiểm thử rõ ràng**: “Chia cho số 0” — đọc là hiểu ngay đang test gì.
4. **Tiền điều kiện**: “Ứng dụng máy tính đã mở” — người khác đọc có thể tái hiện.
5. **Dữ liệu đầu vào cụ thể**: Ghi rõ `10` và `0` — không viết chung chung “nhập số”.
6. **Bước thực hiện chi tiết**: Đánh số 1-2-3-4, mỗi bước là một hành động.
7. **Kết quả mong đợi kiểm chứng được**: "Hiển thị thông báo lỗi" + "Không hiển thị kết quả số" — có 2 điều kiện kiểm chứng rõ ràng.

### Kỹ thuật được áp dụng

- **EP (*Phân lớp tương đương*)**: Số chia được chia thành 2 lớp — khác 0 (hợp lệ) và bằng 0 (không hợp lệ). TC này thuộc lớp không hợp lệ.
- **BVA (*Phân tích giá trị biên*)**: `0` là giá trị biên — ranh giới giữa số dương nhỏ nhất và số không hợp lệ.

### Lỗi thường gặp khi viết TC

| Sai | Đúng | Lý do |
|-----|------|-------|
| Dữ liệu: "số sai" | Dữ liệu: `10` và `0` | Phải ghi giá trị cụ thể để người khác tái hiện được |
| Bước: "Thực hiện phép chia sai" | Bước: 1. Nhập số... 2. Chọn phép tính... 3. Nhấn nút... | Phải tách từng hành động |
| Mong đợi: "Báo lỗi" | Mong đợi: "Hiển thị thông báo 'Không thể chia cho 0'" | Phải ghi rõ nội dung thông báo |

