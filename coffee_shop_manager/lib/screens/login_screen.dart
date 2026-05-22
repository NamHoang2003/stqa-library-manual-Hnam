import 'package:coffee_shop_manager/models/account.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  List<Account> accounts = [
    Account('Manager', 'Ab123456'),
    Account('Staff1', 'Ab123456'),
    Account('Staff2', 'Ab123456'),
    Account('Staff3', 'Ab123456'),
    Account('Staff4', 'Ab123456'),
    Account('Staff5', 'Ab123456'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 30,
          height: 60,
          child: Column(
            children: [
              Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextField(
                decoration: InputDecoration(label: Text('Tên đăng nhập')),
              ),
              const SizedBox(height: 5),
              Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextField(
                decoration: InputDecoration(label: Text('Tên đăng nhập')),
              ),
              const SizedBox(height: 5),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Đăng nhập'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
