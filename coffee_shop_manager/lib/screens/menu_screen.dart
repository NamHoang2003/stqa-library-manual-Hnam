import 'package:coffee_shop_manager/models/drink.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.cost});

  final int cost;
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Drink> drinkList = [
    Drink('Trà Đào Cam Xả', 30000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Bạc Hà', 20000, 'Còn đồ', 'VND'),
    Drink('Trà đào xả tắc', 35000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Việt Quất', 23000, 'Còn đồ', 'VND'),
    Drink('Caramel Vị Muối Biển', 30000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Chuối Nướng', 35000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Kiwi', 20000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Socola', 20000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Dâu', 20000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Socola Bạc Hà', 23000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Cappucino', 23000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Khoai Môn', 23000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Chanh Leo', 23000, 'Còn đồ', 'VND'),
    Drink('Trà Sữa Matcha', 27000, 'Còn đồ', 'VND'),
    Drink('Trà Ổi Hồng', 25000, 'Còn đồ', 'VND'),
    Drink('Yogurt Việt Quất', 28000, 'Còn đồ', 'VND'),
    Drink('Matcha Sữa Tươi Đường Đen', 35000, 'Còn đồ', 'VND'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('Trà đào cam xả'),
                    Row(
                      children: [
                        Text('Giá: '),
                        const SizedBox(width: 5),
                        Text('vnđ'),
                      ],
                    ),
                    Text('Trạng thái'),
                    ElevatedButton(onPressed: () {}, child: Text('Gọi món')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
