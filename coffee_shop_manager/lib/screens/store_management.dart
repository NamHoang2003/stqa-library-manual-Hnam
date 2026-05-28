import 'package:flutter/material.dart';

class StoreManagement extends StatefulWidget {
  const StoreManagement({super.key});

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA2A6A6),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Kiểm kho',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          Row(children: []),
        ],
      ),
    );
  }
}
