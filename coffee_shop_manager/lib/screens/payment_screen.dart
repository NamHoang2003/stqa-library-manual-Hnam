import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            // Image(),
            const SizedBox(width: 2),
            Column(children: [Text('Trà đào cam xả'), Text('vnđ')]),
          ],
        ),
      ),
    );
  }
}
