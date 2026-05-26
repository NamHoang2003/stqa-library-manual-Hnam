import 'package:coffee_shop_manager/models/drink.dart';

class OrderItem {
  final Drink drink;
  final int quantity;

  OrderItem({
    required this.drink,
    required this.quantity,
  });

  int get cost => drink.cost * quantity;
}

class Order {
  final String id;
  final List<OrderItem> items;
  final int subtotal;
  final int discount;
  final int total;
  final String paymentMethod; // 'Tiền mặt', 'Chuyển khoản', 'Ví điện tử'
  final String? voucherCode;
  final DateTime date;
  final String status; // 'Đã thanh toán', 'Chưa thanh toán'
  final String createdById;
  final String createdByName;

  Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    this.voucherCode,
    required this.date,
    required this.status,
    required this.createdById,
    required this.createdByName,
  });
}
