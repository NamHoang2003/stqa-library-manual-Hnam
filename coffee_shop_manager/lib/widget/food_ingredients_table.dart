import 'package:flutter/material.dart';

class FoodIngredientsTable extends StatefulWidget {
  const FoodIngredientsTable({super.key});

  @override
  State<FoodIngredientsTable> createState() => _FoodIngredientsTableState();
}

class _FoodIngredientsTableState extends State<FoodIngredientsTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            SizedBox(),
            Text('STT'),
            Text('Tên hàng'),
            Text('Tồn kho'),
            Text('Thực tế'),
            Text('SL lệch'),
            Text('Giá trị lệch'),
          ],
        ),
        TableRow(
          children: [
            Icon(Icons.delete),
            Text('1'),
            Text('Bột cacao'),
            Text('11'),
            Text('11'),
            Text('0'),
            Text('0'),
          ],
        ),
      ],
    );
  }
}
