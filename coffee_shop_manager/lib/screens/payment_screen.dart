import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Danh sách sản phẩm mẫu
  final List<Map<String, dynamic>> _items = [
    {'stt': 1, 'name': 'Trà Sữa Bạc Hà', 'quantity': 2, 'price': 45000},
    {'stt': 2, 'name': 'Trà Đào', 'quantity': 1, 'price': 40000},
  ];

  String? _voucherCode;
  double _discountPercent = 0;
  String _voucherMessage = '';
  bool _isVoucherValid = false;

  final TextEditingController _paidAmountController = TextEditingController();
  String _paymentMethod = 'cash'; // cash or transfer

  String _errorMessage = '';

  @override
  void dispose() {
    _paidAmountController.dispose();
    super.dispose();
  }

  double get subtotal {
    return _items.fold(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['quantity'] as int),
    );
  }

  double get discountAmount => subtotal * _discountPercent / 100;
  double get total => subtotal - discountAmount;
  double get paidAmount => double.tryParse(_paidAmountController.text) ?? 0;
  double get change => paidAmount - total;

  bool get isCartEmpty => _items.isEmpty;

  void _applyVoucher(String code) {
    setState(() {
      _voucherCode = code;
      _voucherMessage = '';
      _isVoucherValid = false;

      if (code == 'VOUCHER10') {
        if (subtotal > 200000) {
          _discountPercent = 10;
          _isVoucherValid = true;
          _voucherMessage = 'Áp dụng voucher thành công (-10%)';
        } else {
          _voucherMessage = 'Không đủ điều kiện áp dụng (đơn tối thiểu 200k)';
        }
      } else if (code == 'EXPIRED') {
        _voucherMessage = 'Mã hết hạn';
      } else {
        _voucherMessage = 'Mã voucher không hợp lệ';
      }
    });
  }

  void _processPayment() {
    if (isCartEmpty) {
      setState(() => _errorMessage = 'Giỏ hàng trống, không thể thanh toán');
      return;
    }
    if (total <= 0) {
      setState(() => _errorMessage = 'Tổng tiền không hợp lệ');
      return;
    }
    if (paidAmount < total && _paymentMethod == 'cash') {
      setState(() => _errorMessage = 'Tiền khách đưa chưa đủ');
      return;
    }

    setState(() => _errorMessage = '');

    // TODO: Gọi API thanh toán thực tế
    String message = _paymentMethod == 'cash'
        ? 'Thanh toán tiền mặt thành công. Tiền thừa: ${change.toStringAsFixed(0)}đ'
        : 'Thanh toán chuyển khoản thành công.';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thanh toán thành công'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Chuyển trạng thái đơn hàng sang "Đã thanh toán"
            },
            child: const Text('Hoàn tất'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh Toán')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== BẢNG CHI TIẾT ĐƠN HÀNG =====
            const Text(
              'Chi tiết đơn hàng',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey.shade100,
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'STT',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Tên sản phẩm',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'SL',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Đơn giá',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Thành tiền',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Items
                  ..._items.map((item) {
                    int itemTotal = item['price'] * item['quantity'];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(item['stt'].toString())),
                          Expanded(flex: 3, child: Text(item['name'])),
                          Expanded(child: Text(item['quantity'].toString())),
                          Expanded(child: Text('${item['price']}đ')),
                          Expanded(child: Text('${itemTotal.toInt()}đ')),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== TỔNG TIỀN =====
            SummaryRow(label: 'Tổng tiền hàng', value: '${subtotal.toInt()}đ'),
            if (_discountPercent > 0)
              SummaryRow(
                label: 'Giảm giá ($_discountPercent%)',
                value: '-${discountAmount.toInt()}đ',
                isDiscount: true,
              ),
            SummaryRow(
              label: 'Khách phải trả',
              value: '${total.toInt()}đ',
              isTotal: true,
            ),

            const SizedBox(height: 20),

            // ===== VOUCHER =====
            const Text(
              'Mã giảm giá',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Nhập mã voucher',
                    ),
                    onSubmitted: _applyVoucher,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _applyVoucher(_voucherCode ?? ''),
                  child: const Text('Áp dụng'),
                ),
              ],
            ),
            if (_voucherMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _voucherMessage,
                  style: TextStyle(
                    color: _isVoucherValid ? Colors.green : Colors.red,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // ===== TIỀN KHÁCH ĐƯA =====
            const Text(
              'Tiền khách đưa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _paidAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(hintText: 'Nhập số tiền'),
              onChanged: (_) => setState(() {}),
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 10),
            if (paidAmount > 0 && _paymentMethod == 'cash')
              SummaryRow(
                label: 'Tiền thừa',
                value: change >= 0 ? '${change.toInt()}đ' : 'Chưa đủ',
                color: change >= 0 ? Colors.green : Colors.red,
              ),

            const SizedBox(height: 20),

            // ===== PHƯƠNG THỨC THANH TOÁN =====
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Tiền mặt'),
                  selected: _paymentMethod == 'cash',
                  onSelected: (selected) =>
                      setState(() => _paymentMethod = 'cash'),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('Chuyển khoản'),
                  selected: _paymentMethod == 'transfer',
                  onSelected: (selected) =>
                      setState(() => _paymentMethod = 'transfer'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ===== NÚT THANH TOÁN =====
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isCartEmpty ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff27b4f5),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Thanh toán', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    this.color,
    required this.value,
    this.isTotal = false,
    this.isDiscount = false,
  });
  final String label;
  final String value;
  final bool isTotal;
  final bool isDiscount;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isDiscount ? Colors.green : null),
            ),
          ),
        ],
      ),
    );
  }
}
