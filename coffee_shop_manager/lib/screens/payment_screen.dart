import 'package:flutter/material.dart';
import '../models/drink.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int cost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('STT'),
                      const SizedBox(width: 10),
                      Text('Tác vụ'),
                      const SizedBox(width: 10),
                      Text('Tên sản phẩm'),
                      const SizedBox(width: 10),
                      Text('Số lượng'),
                      const SizedBox(width: 10),
                      Text('Giá tiền'),
                      const SizedBox(width: 10),
                      Text('Tổng tiền'),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text('1'),
                      const SizedBox(width: 10),
                      Text('Xóa'),
                      const SizedBox(width: 10),
                      Text('Trà Sữa Bạc Hà'),
                      const SizedBox(width: 10),
                      Text('Số lượng'),
                      const SizedBox(width: 10),
                      Text('Giá tiền'),
                      const SizedBox(width: 10),
                      Text('Tổng tiền'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Text('Số lượng'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              Row(
                children: [
                  Text('Tổng tiền'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              Row(
                children: [Text('VAT'), const SizedBox(width: 20), Text('0')],
              ),
              Row(
                children: [
                  Text('Chiết khấu'),
                  const SizedBox(width: 20),
                  Text('0'),
                ],
              ),
              Row(
                children: [
                  Text('Khách phải trả'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              Row(
                children: [
                  Text('Tiền khách đưa'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              Row(
                children: [
                  Text('Tiền mặt'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              Row(
                children: [
                  Text('Tiền thừa'),
                  const SizedBox(width: 20),
                  Text('2'),
                ],
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xff27b4f5)),
                ),
                child: Text('Thanh toán'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
