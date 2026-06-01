import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/order.dart';

class OrderCartPanel extends StatefulWidget {
  const OrderCartPanel({super.key, required this.isHistoryOnly});

  final bool isHistoryOnly;

  @override
  State<OrderCartPanel> createState() => _OrderCartPanelState();
}

class _OrderCartPanelState extends State<OrderCartPanel> {
  final TextEditingController _voucherController = TextEditingController();
  String _paymentMethod = 'Tiền mặt';
  String _voucherError = '';
  String _appliedVoucher = '';

  void _applyVoucher() {
    final code = _voucherController.text.trim().toUpperCase();
    if (code.isEmpty) {
      setState(() {
        _appliedVoucher = '';
        _voucherError = '';
      });
      return;
    }

    if (code == 'ABC10' || code == 'COFFEE20') {
      setState(() {
        _appliedVoucher = code;
        _voucherError = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Áp dụng mã giảm giá $code thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        _appliedVoucher = '';
        _voucherError = 'Mã giảm giá không hợp lệ';
      });
    }
  }

  void _handleCheckout(String status) {
    if (appState.cart.isEmpty) return;

    final voucher = _appliedVoucher.isNotEmpty ? _appliedVoucher : null;
    final res = appState.checkout(
      paymentMethod: _paymentMethod,
      voucherCode: voucher,
      status: status,
    );

    if (res == 'Success') {
      final latestOrder = appState.orders.last;

      setState(() {
        _voucherController.clear();
        _appliedVoucher = '';
        _voucherError = '';
      });

      // Show Invoice Popup
      _showInvoiceDialog(latestOrder);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.amber),
              SizedBox(width: 8),
              Text('Không thể đặt hàng'),
            ],
          ),
          content: Text(res),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  void _showInvoiceDialog(Order order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: size.width > 450 ? 400 : size.width * 0.9,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  const Center(
                    child: Text(
                      'CÀ PHÊ ABC',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Đ/C: 123 Đường Đại Học, Khu A',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 1, color: Colors.black54),
                  const SizedBox(height: 8),

                  // Info Rows
                  _buildReceiptRow('Mã hóa đơn:', order.id),
                  _buildReceiptRow(
                    'Ngày tạo:',
                    '${order.date.day}/${order.date.month}/${order.date.year} ${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')}',
                  ),
                  _buildReceiptRow('Nhân viên:', order.createdByName),
                  _buildReceiptRow('Thanh toán:', order.paymentMethod),
                  _buildReceiptRow(
                    'Trạng thái:',
                    order.status,
                    isBoldValue: true,
                  ),

                  const SizedBox(height: 12),
                  const Divider(thickness: 1, color: Colors.black54),
                  const SizedBox(height: 8),

                  // Items Headers
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Tên món',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'SL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Thành tiền',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Items list
                  ...order.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 5, child: Text(item.drink.name)),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${item.quantity}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${item.cost.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Divider(thickness: 1, color: Colors.black54),
                  const SizedBox(height: 8),

                  // Totals
                  _buildReceiptRow(
                    'Tạm tính:',
                    '${order.subtotal.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                  ),
                  if (order.discount > 0)
                    _buildReceiptRow(
                      'Giảm giá (${order.voucherCode}):',
                      '-${order.discount.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                    ),
                  const Divider(thickness: 1),
                  _buildReceiptRow(
                    'TỔNG TIỀN:',
                    '${order.total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                    isBoldTitle: true,
                    isBoldValue: true,
                    fontSize: 16,
                  ),

                  const SizedBox(height: 24),
                  const Center(
                    child: Text(
                      'Cảm ơn Quý Khách - Hẹn gặp lại!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    key: const ValueKey('receipt_close_btn'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D4037),
                    ),
                    child: const Text('Đóng & In hóa đơn'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptRow(
    String title,
    String value, {
    bool isBoldTitle = false,
    bool isBoldValue = false,
    double fontSize = 13,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBoldTitle ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        if (widget.isHistoryOnly) {
          return _buildHistoryView();
        }
        return _buildCartView();
      },
    );
  }

  Widget _buildCartView() {
    final cartItems = appState.cart.entries.toList();
    final subtotal = appState.cartSubtotal;
    final discount = appState.getVoucherDiscount(_appliedVoucher, subtotal);
    final total = subtotal - discount;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: isDesktop
            ? const Border(
                left: BorderSide(color: Color(0xFFEFE6DD), width: 1.5),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFAF5EF),
            child: Row(
              children: [
                const Icon(Icons.shopping_basket, color: Color(0xFF5D4037)),
                const SizedBox(width: 8),
                const Text(
                  'Đơn hàng hiện tại',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2723),
                  ),
                ),
                const Spacer(),
                if (cartItems.isNotEmpty)
                  TextButton(
                    onPressed: () => appState.clearCart(),
                    child: const Text(
                      'Xóa hết',
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
              ],
            ),
          ),

          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Chưa có món nào được chọn',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final drinkName = item.key;
                      final quantity = item.value;
                      final drink = appState.drinks.firstWhere(
                        (e) => e.name == drinkName,
                      );

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xFFFAF5EF)),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5EFEB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Color(0xFF5D4037),
                                    ),
                                    onPressed: () {
                                      appState.updateCartQuantity(
                                        drinkName,
                                        quantity - 1,
                                      );
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D4037),
                                    ),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Color(0xFF5D4037),
                                    ),
                                    onPressed: () {
                                      if (appState.canAddDrink(
                                        drink,
                                        quantityToAdd: 1,
                                      )) {
                                        appState.updateCartQuantity(
                                          drinkName,
                                          quantity + 1,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Không đủ nguyên liệu trong kho hoặc vượt quá giới hạn 10 món!',
                                            ),
                                            backgroundColor: Colors.amber,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Drink info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    drinkName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                  Text(
                                    '${drink.cost.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')}đ',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Total item price
                            Text(
                              '${(drink.cost * quantity).toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')}đ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5D4037),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Voucher & Checkout Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFAF5EF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Voucher inputs
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          key: const ValueKey('voucher_field'),
                          controller: _voucherController,
                          decoration: InputDecoration(
                            hintText: 'Nhập voucher',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            errorText: _voucherError.isNotEmpty
                                ? _voucherError
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      key: const ValueKey('voucher_apply_btn'),
                      onPressed: _applyVoucher,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D6E63),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text(
                        'Áp dụng',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Payment Method
                const Text(
                  'Phương thức thanh toán:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: ['Tiền mặt', 'Chuyển khoản', 'Ví điện tử'].map((
                    method,
                  ) {
                    final isSelected = _paymentMethod == method;
                    return InkWell(
                      key: ValueKey('pay_method_$method'),
                      onTap: () {
                        setState(() {
                          _paymentMethod = method;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5D4037)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEFE6DD)),
                        ),
                        child: Text(
                          method,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF5D4037),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Cost Breakdown
                _buildReceiptRow(
                  'Tạm tính:',
                  '${subtotal.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                ),
                if (discount > 0)
                  _buildReceiptRow(
                    'Khuyến mãi (${_appliedVoucher}):',
                    '-${discount.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                  ),
                const Divider(),
                _buildReceiptRow(
                  'TỔNG THANH TOÁN:',
                  '${total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                  isBoldTitle: true,
                  isBoldValue: true,
                  fontSize: 15,
                ),
                const SizedBox(height: 16),

                // Checkout buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      key: const ValueKey('checkout_paid_btn'),
                      onPressed: cartItems.isEmpty
                          ? null
                          : () => _handleCheckout('Đã thanh toán'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4037),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Thanh Toán (Đã thanh toán)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      key: const ValueKey('checkout_unpaid_btn'),
                      onPressed: cartItems.isEmpty
                          ? null
                          : () => _handleCheckout('Chưa thanh toán'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF8D6E63)),
                      ),
                      child: const Text(
                        'Ghi Nợ (Chưa thanh toán)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    final orders = appState.orders.reversed.toList();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F6),
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch Sử Đơn Hàng',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: orders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Chưa có đơn hàng nào được tạo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final isUnpaid = order.status == 'Chưa thanh toán';

                        final orderHeader = Row(
                          children: [
                            Text(
                              'Mã: ${order.id}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isUnpaid
                                    ? Colors.orange.shade50
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: isUnpaid
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: isUnpaid
                                      ? Colors.orange.shade800
                                      : Colors.green.shade800,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );

                        final orderDetails = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Món đã gọi: ${order.items.map((e) => "${e.drink.name} x${e.quantity}").join(", ")}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Ngày: ${order.date.day}/${order.date.month}/${order.date.year} ${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')} | Người tạo: ${order.createdByName}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );

                        final priceText = Text(
                          '${order.total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF5D4037),
                          ),
                        );

                        final actionButtons = Row(
                          mainAxisAlignment: isMobile
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            // View Receipt
                            TextButton.icon(
                              key: ValueKey('view_receipt_btn_${order.id}'),
                              onPressed: () => _showInvoiceDialog(order),
                              icon: const Icon(
                                Icons.receipt_outlined,
                                size: 14,
                              ),
                              label: const Text(
                                'Hóa đơn',
                                style: TextStyle(fontSize: 12),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF8D6E63),
                              ),
                            ),

                            // Pay button (if unpaid)
                            if (isUnpaid) ...[
                              const SizedBox(width: 8),
                              ElevatedButton(
                                key: ValueKey('pay_order_btn_${order.id}'),
                                onPressed: () {
                                  appState.payOrder(order.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Đã ghi nhận thanh toán cho đơn ${order.id}',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Thanh toán',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: isMobile
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [orderHeader, priceText],
                                      ),
                                      const SizedBox(height: 12),
                                      orderDetails,
                                      const Divider(height: 20),
                                      actionButtons,
                                    ],
                                  )
                                : Row(
                                    children: [
                                      // Left details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderHeader,
                                            const SizedBox(height: 8),
                                            orderDetails,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Right price and action buttons
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          priceText,
                                          const SizedBox(height: 8),
                                          actionButtons,
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/order.dart';

class OrderCartPanel extends StatefulWidget {
  const OrderCartPanel({super.key, required this.isHistoryOnly});

  final bool isHistoryOnly;

  @override
  State<OrderCartPanel> createState() => _OrderCartPanelState();
}

class _OrderCartPanelState extends State<OrderCartPanel> {
  final TextEditingController _voucherController = TextEditingController();
  String _paymentMethod = 'Tiền mặt';
  String _voucherError = '';
  String _appliedVoucher = '';

  void _applyVoucher() {
    final code = _voucherController.text.trim().toUpperCase();
    if (code.isEmpty) {
      setState(() {
        _appliedVoucher = '';
        _voucherError = '';
      });
      return;
    }

    if (code == 'ABC10' || code == 'COFFEE20') {
      setState(() {
        _appliedVoucher = code;
        _voucherError = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Áp dụng mã giảm giá $code thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        _appliedVoucher = '';
        _voucherError = 'Mã giảm giá không hợp lệ';
      });
    }
  }

  void _handleCheckout(String status) {
    if (appState.cart.isEmpty) return;

    final voucher = _appliedVoucher.isNotEmpty ? _appliedVoucher : null;
    final res = appState.checkout(
      paymentMethod: _paymentMethod,
      voucherCode: voucher,
      status: status,
    );

    if (res == 'Success') {
      final latestOrder = appState.orders.last;

      setState(() {
        _voucherController.clear();
        _appliedVoucher = '';
        _voucherError = '';
      });

      // Show Invoice Popup
      _showInvoiceDialog(latestOrder);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.amber),
              SizedBox(width: 8),
              Text('Không thể đặt hàng'),
            ],
          ),
          content: Text(res),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            )
          ],
        ),
      );
    }
  }

  void _showInvoiceDialog(Order order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: size.width > 450 ? 400 : size.width * 0.9,
            padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Center(
                  child: Text(
                    'CÀ PHÊ ABC',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                  ),
                ),
                const Center(
                  child: Text(
                    'Đ/C: 123 Đường Đại Học, Khu A',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(thickness: 1, color: Colors.black54),
                const SizedBox(height: 8),

                // Info Rows
                _buildReceiptRow('Mã hóa đơn:', order.id),
                _buildReceiptRow('Ngày tạo:', '${order.date.day}/${order.date.month}/${order.date.year} ${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')}'),
                _buildReceiptRow('Nhân viên:', order.createdByName),
                _buildReceiptRow('Thanh toán:', order.paymentMethod),
                _buildReceiptRow('Trạng thái:', order.status, isBoldValue: true),

                const SizedBox(height: 12),
                const Divider(thickness: 1, color: Colors.black54),
                const SizedBox(height: 8),

                // Items Headers
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 5, child: Text('Tên món', style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text('SL', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    Expanded(flex: 3, child: Text('Thành tiền', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                  ],
                ),
                const SizedBox(height: 8),

                // Items list
                ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 5, child: Text(item.drink.name)),
                          Expanded(flex: 2, child: Text('${item.quantity}', textAlign: TextAlign.center)),
                          Expanded(
                              flex: 3,
                              child: Text(
                                '${item.cost.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                                textAlign: TextAlign.right,
                              )),
                        ],
                      ),
                    )),

                const SizedBox(height: 12),
                const Divider(thickness: 1, color: Colors.black54),
                const SizedBox(height: 8),

                // Totals
                _buildReceiptRow('Tạm tính:', '${order.subtotal.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ'),
                if (order.discount > 0)
                  _buildReceiptRow('Giảm giá (${order.voucherCode}):', '-${order.discount.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ'),
                const Divider(thickness: 1),
                _buildReceiptRow('TỔNG TIỀN:', '${order.total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ', isBoldTitle: true, isBoldValue: true, fontSize: 16),

                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Cảm ơn Quý Khách - Hẹn gặp lại!',
                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  key: const ValueKey('receipt_close_btn'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D4037),
                  ),
                  child: const Text('Đóng & In hóa đơn'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  Widget _buildReceiptRow(String title, String value, {bool isBoldTitle = false, bool isBoldValue = false, double fontSize = 13}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: isBoldTitle ? FontWeight.bold : FontWeight.normal, fontSize: fontSize)),
          Text(value, style: TextStyle(fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal, fontSize: fontSize)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        if (widget.isHistoryOnly) {
          return _buildHistoryView();
        }
        return _buildCartView();
      },
    );
  }

  Widget _buildCartView() {
    final cartItems = appState.cart.entries.toList();
    final subtotal = appState.cartSubtotal;
    final discount = appState.getVoucherDiscount(_appliedVoucher, subtotal);
    final total = subtotal - discount;
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: isDesktop
            ? const Border(
                left: BorderSide(color: Color(0xFFEFE6DD), width: 1.5),
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cart Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFAF5EF),
            child: Row(
              children: [
                const Icon(Icons.shopping_basket, color: Color(0xFF5D4037)),
                const SizedBox(width: 8),
                const Text(
                  'Đơn hàng hiện tại',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF3E2723)),
                ),
                const Spacer(),
                if (cartItems.isNotEmpty)
                  TextButton(
                    onPressed: () => appState.clearCart(),
                    child: const Text('Xóa hết', style: TextStyle(color: Colors.red, fontSize: 13)),
                  ),
              ],
            ),
          ),

          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        const Text(
                          'Chưa có món nào được chọn',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final drinkName = item.key;
                      final quantity = item.value;
                      final drink = appState.drinks.firstWhere((e) => e.name == drinkName);

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFFAF5EF))),
                        ),
                        child: Row(
                          children: [
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5EFEB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.remove, size: 16, color: Color(0xFF5D4037)),
                                    onPressed: () {
                                      appState.updateCartQuantity(drinkName, quantity - 1);
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add, size: 16, color: Color(0xFF5D4037)),
                                    onPressed: () {
                                      if (appState.canAddDrink(drink, quantityToAdd: 1)) {
                                        appState.updateCartQuantity(drinkName, quantity + 1);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Không đủ nguyên liệu trong kho hoặc vượt quá giới hạn 10 món!'),
                                            backgroundColor: Colors.amber,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Drink info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    drinkName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3E2723)),
                                  ),
                                  Text(
                                    '${drink.cost.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')}đ',
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            // Total item price
                            Text(
                              '${(drink.cost * quantity).toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')}đ',
                              style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF5D4037)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Voucher & Checkout Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFAF5EF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Voucher inputs
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          key: const ValueKey('voucher_field'),
                          controller: _voucherController,
                          decoration: InputDecoration(
                            hintText: 'Nhập voucher',
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            errorText: _voucherError.isNotEmpty ? _voucherError : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      key: const ValueKey('voucher_apply_btn'),
                      onPressed: _applyVoucher,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D6E63),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text('Áp dụng', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Payment Method
                const Text(
                  'Phương thức thanh toán:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF5D4037)),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: ['Tiền mặt', 'Chuyển khoản', 'Ví điện tử'].map((method) {
                    final isSelected = _paymentMethod == method;
                    return InkWell(
                      key: ValueKey('pay_method_$method'),
                      onTap: () {
                        setState(() {
                          _paymentMethod = method;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF5D4037) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEFE6DD)),
                        ),
                        child: Text(
                          method,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : const Color(0xFF5D4037),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Cost Breakdown
                _buildReceiptRow('Tạm tính:', '${subtotal.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ'),
                if (discount > 0)
                  _buildReceiptRow('Khuyến mãi (${_appliedVoucher}):', '-${discount.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ'),
                const Divider(),
                _buildReceiptRow('TỔNG THANH TOÁN:', '${total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ', isBoldTitle: true, isBoldValue: true, fontSize: 15),
                const SizedBox(height: 16),

                // Checkout buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      key: const ValueKey('checkout_paid_btn'),
                      onPressed: cartItems.isEmpty ? null : () => _handleCheckout('Đã thanh toán'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4037),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Thanh Toán (Đã thanh toán)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      key: const ValueKey('checkout_unpaid_btn'),
                      onPressed: cartItems.isEmpty ? null : () => _handleCheckout('Chưa thanh toán'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF8D6E63)),
                      ),
                      child: const Text('Ghi Nợ (Chưa thanh toán)', style: TextStyle(fontSize: 12, color: Color(0xFF8D6E63))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    final orders = appState.orders.reversed.toList();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F6),
      body: Padding(
        padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch Sử Đơn Hàng',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: orders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 64, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          const Text('Chưa có đơn hàng nào được tạo', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final isUnpaid = order.status == 'Chưa thanh toán';

                        final orderHeader = Row(
                          children: [
                            Text(
                              'Mã: ${order.id}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isUnpaid ? Colors.orange.shade50 : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: isUnpaid ? Colors.orange : Colors.green),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: isUnpaid ? Colors.orange.shade800 : Colors.green.shade800,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );

                        final orderDetails = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Món đã gọi: ${order.items.map((e) => "${e.drink.name} x${e.quantity}").join(", ")}',
                              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Ngày: ${order.date.day}/${order.date.month}/${order.date.year} ${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')} | Người tạo: ${order.createdByName}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        );

                        final priceText = Text(
                          '${order.total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF5D4037)),
                        );

                        final actionButtons = Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            // View Receipt
                            TextButton.icon(
                              key: ValueKey('view_receipt_btn_${order.id}'),
                              onPressed: () => _showInvoiceDialog(order),
                              icon: const Icon(Icons.receipt_outlined, size: 14),
                              label: const Text('Hóa đơn', style: TextStyle(fontSize: 12)),
                              style: TextButton.styleFrom(foregroundColor: const Color(0xFF8D6E63)),
                            ),

                            // Pay button (if unpaid)
                            if (isUnpaid) ...[
                              const SizedBox(width: 8),
                              ElevatedButton(
                                key: ValueKey('pay_order_btn_${order.id}'),
                                onPressed: () {
                                  appState.payOrder(order.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Đã ghi nhận thanh toán cho đơn ${order.id}'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                child: const Text('Thanh toán', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ],
                        );

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: isMobile
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          orderHeader,
                                          priceText,
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      orderDetails,
                                      const Divider(height: 20),
                                      actionButtons,
                                    ],
                                  )
                                : Row(
                                    children: [
                                      // Left details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            orderHeader,
                                            const SizedBox(height: 8),
                                            orderDetails,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Right price and action buttons
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          priceText,
                                          const SizedBox(height: 8),
                                          actionButtons,
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
