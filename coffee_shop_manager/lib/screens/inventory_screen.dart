import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/ingredient.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _editQuantityController = TextEditingController();

  void _showAdjustStockDialog(Ingredient ing) {
    _editQuantityController.text = ing.quantity.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Cập nhật tồn kho: ${ing.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Số lượng hiện tại: ${ing.quantity} ${ing.unit}',
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const ValueKey('dialog_stock_field'),
              controller: _editQuantityController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Số lượng mới',
                suffixText: ing.unit,
              ),
            ),
            const SizedBox(height: 12),
            // Quick add helpers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [50, 100, 500].map((amount) {
                return OutlinedButton(
                  onPressed: () {
                    final curr = double.tryParse(_editQuantityController.text) ?? 0.0;
                    setState(() {
                      _editQuantityController.text = (curr + amount).toString();
                    });
                  },
                  child: Text('+$amount'),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            key: const ValueKey('dialog_stock_save_btn'),
            onPressed: () {
              final newQty = double.tryParse(_editQuantityController.text);
              if (newQty != null && newQty >= 0) {
                appState.updateIngredientQuantity(ing.name, newQty);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã cập nhật tồn kho ${ing.name}!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng nhập số lượng hợp lệ (không được âm)!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Cập nhật', style: TextStyle(color: Color(0xFF5D4037))),
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
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final ingredients = appState.ingredients;

        // Check if any ingredient is in warning threshold (< 10)
        final lowStockIngredients = ingredients.where((element) => element.quantity < 10).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F6),
          body: Padding(
            padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Text(
              'Kho Nguyên Liệu',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Quản lý nguyên liệu pha chế & theo dõi mức độ tồn kho an toàn',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // Low Stock Warning Banner
            if (lowStockIngredients.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red.shade800),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CẢNH BÁO HẾT NGUYÊN LIỆU (Tồn kho < 10)',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Các nguyên liệu sắp hết: ${lowStockIngredients.map((e) => "${e.name} (${e.quantity} ${e.unit})").join(", ")}',
                            style: TextStyle(color: Colors.red.shade800, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Ingredients List Card
            Expanded(
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Tên Nguyên Liệu', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Số Lượng Hiện Tại', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Đơn Vị', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Tình Trạng', style: TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Thao Tác', style: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: ingredients.map((ing) {
                          final isLow = ing.quantity < 10;
                          return DataRow(
                            cells: [
                              DataCell(Text(ing.name, style: const TextStyle(fontWeight: FontWeight.w600))),
                              DataCell(Text('${ing.quantity}')),
                              DataCell(Text(ing.unit)),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isLow ? Colors.red.shade50 : Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: isLow ? Colors.red : Colors.green),
                                  ),
                                  child: Text(
                                    isLow ? 'Sắp Hết' : 'An Toàn',
                                    style: TextStyle(
                                      color: isLow ? Colors.red.shade800 : Colors.green.shade800,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                ElevatedButton.icon(
                                  key: ValueKey('adjust_stock_btn_${ing.name}'),
                                  onPressed: () => _showAdjustStockDialog(ing),
                                  icon: const Icon(Icons.edit_note, size: 16),
                                  label: const Text('Nhập Kho', style: TextStyle(fontSize: 11)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF5D4037),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
