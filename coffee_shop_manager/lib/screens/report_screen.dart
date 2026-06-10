import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/order.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _timeFilter = 'Hôm nay'; // 'Hôm nay', 'Tuần này', 'Tất cả'

  List<Widget> _buildUnpaidOrders(List<Order> filteredOrders) {
    final unpaidList = filteredOrders
        .where((element) => element.status == 'Chưa thanh toán')
        .toList();
    if (unpaidList.isEmpty) {
      return [
        const SizedBox(
          height: 200,
          child: Center(
            child: Text(
              'Không có đơn hàng nào ghi nợ!',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ];
    }
    return unpaidList.map((order) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5EF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFEFE6DD)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hóa đơn: ${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SL món: ${order.items.fold(0, (int s, e) => s + e.quantity)} | ${order.createdByName}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tiền: ${order.total.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                    style: const TextStyle(
                      color: Color(0xFF5D4037),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                key: ValueKey('report_pay_btn_${order.id}'),
                onPressed: () {
                  appState.payOrder(order.id);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Đơn ${order.id} đã hoàn tất thanh toán!'),
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
                  'Thu nợ',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final orders = appState.orders;

        // Filter orders by time range
        final filteredOrders = orders.where((order) {
          if (_timeFilter == 'Hôm nay') {
            final now = DateTime.now();
            return order.date.year == now.year &&
                order.date.month == now.month &&
                order.date.day == now.day;
          } else if (_timeFilter == 'Tuần này') {
            final now = DateTime.now();
            final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
            final endOfWeek = startOfWeek.add(const Duration(days: 7));
            return order.date.isAfter(
                  startOfWeek.subtract(const Duration(seconds: 1)),
                ) &&
                order.date.isBefore(endOfWeek);
          }
          return true; // All
        }).toList();

        // Calculations
        int totalRevenue = 0;
        int paidRevenue = 0;
        int unpaidRevenue = 0;
        int paidCount = 0;
        int unpaidCount = 0;

        for (var o in filteredOrders) {
          totalRevenue += o.total;
          if (o.status == 'Đã thanh toán') {
            paidRevenue += o.total;
            paidCount++;
          } else {
            unpaidRevenue += o.total;
            unpaidCount++;
          }
        }

        // Top 5 best sellers
        final drinkSalesCounts = <String, int>{};
        for (var o in filteredOrders) {
          for (var item in o.items) {
            drinkSalesCounts[item.drink.name] =
                (drinkSalesCounts[item.drink.name] ?? 0) + item.quantity;
          }
        }

        final sortedBestSellers = drinkSalesCounts.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        final top5BestSellers = sortedBestSellers.take(5).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F6),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title & Filter Wrap
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: isDesktop ? 600 : size.width - 32,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Báo Cáo Doanh Thu',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Thống kê bán hàng & theo dõi các khoản nợ đơn hàng chưa thanh toán',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    // Time Range Select
                    DropdownButton<String>(
                      value: _timeFilter,
                      items: const [
                        DropdownMenuItem(
                          value: 'Hôm nay',
                          child: Text('Hôm nay'),
                        ),
                        DropdownMenuItem(
                          value: 'Tuần này',
                          child: Text('Tuần này'),
                        ),
                        DropdownMenuItem(
                          value: 'Tất cả',
                          child: Text('Tất cả thời gian'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _timeFilter = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
                // Metrics Summary Row/Column
                isDesktop
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildMetricCard(
                              'Tổng Doanh Thu',
                              '${totalRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                              'Từ ${filteredOrders.length} đơn hàng',
                              Icons.monetization_on,
                              const Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMetricCard(
                              'Đã Thu Hồi',
                              '${paidRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                              'Từ $paidCount đơn đã trả',
                              Icons.check_circle_outline,
                              Colors.green,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildMetricCard(
                              'Chưa Thanh Toán',
                              '${unpaidRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                              'Từ $unpaidCount đơn đang ghi nợ',
                              Icons.pending_actions,
                              Colors.orange,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildMetricCard(
                            'Tổng Doanh Thu',
                            '${totalRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                            'Từ ${filteredOrders.length} đơn hàng',
                            Icons.monetization_on,
                            const Color(0xFF5D4037),
                          ),
                          const SizedBox(height: 12),
                          _buildMetricCard(
                            'Đã Thu Hồi',
                            '${paidRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                            'Từ $paidCount đơn đã trả',
                            Icons.check_circle_outline,
                            Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _buildMetricCard(
                            'Chưa Thanh Toán',
                            '${unpaidRevenue.toString().replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '${m[1]}.')} đ',
                            'Từ $unpaidCount đơn đang ghi nợ',
                            Icons.pending_actions,
                            Colors.orange,
                          ),
                        ],
                      ),
                const SizedBox(height: 24),

                // Layout split for Best sellers and Unpaid bills
                isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column: Top 5 Best Sellers
                          Expanded(
                            flex: 5,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  isDesktop ? 20.0 : 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Top 5 Món Bán Chạy',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF3E2723),
                                      ),
                                    ),
                                    const Divider(height: 24),
                                    if (top5BestSellers.isEmpty)
                                      const SizedBox(
                                        height: 200,
                                        child: Center(
                                          child: Text(
                                            'Chưa có dữ liệu bán hàng trong kỳ này',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: top5BestSellers.length,
                                        itemBuilder: (context, idx) {
                                          final entry = top5BestSellers[idx];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Row(
                                              children: [
                                                // Rank circle
                                                Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: idx == 0
                                                        ? const Color(
                                                            0xFFD2B48C,
                                                          )
                                                        : const Color(
                                                            0xFFFAF5EF,
                                                          ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${idx + 1}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: idx == 0
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFF5D4037,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                // Drink name
                                                Expanded(
                                                  child: Text(
                                                    entry.key,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF3E2723),
                                                    ),
                                                  ),
                                                ),
                                                // Sales Count
                                                Text(
                                                  '${entry.value} ly',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF5D4037),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Right Column: Unpaid Bills (Pending Action)
                          Expanded(
                            flex: 5,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  isDesktop ? 20.0 : 12.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Đơn Hàng Ghi Nợ (Chưa thanh toán)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF3E2723),
                                      ),
                                    ),
                                    const Divider(height: 24),
                                    // Filter list of unpaid bills in current range
                                    ..._buildUnpaidOrders(filteredOrders),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top 5 Best Sellers Card
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(isDesktop ? 20.0 : 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Top 5 Món Bán Chạy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                  const Divider(height: 24),
                                  if (top5BestSellers.isEmpty)
                                    const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text(
                                          'Chưa có dữ liệu bán hàng trong kỳ này',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    )
                                  else
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: top5BestSellers.length,
                                      itemBuilder: (context, idx) {
                                        final entry = top5BestSellers[idx];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Row(
                                            children: [
                                              // Rank circle
                                              Container(
                                                width: 28,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  color: idx == 0
                                                      ? const Color(0xFFD2B48C)
                                                      : const Color(0xFFFAF5EF),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${idx + 1}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: idx == 0
                                                          ? Colors.white
                                                          : const Color(
                                                              0xFF5D4037,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              // Drink name
                                              Expanded(
                                                child: Text(
                                                  entry.key,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF3E2723),
                                                  ),
                                                ),
                                              ),
                                              // Sales Count
                                              Text(
                                                '${entry.value} ly',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF5D4037),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Unpaid Bills Card
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(isDesktop ? 20.0 : 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Đơn Hàng Ghi Nợ (Chưa thanh toán)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF3E2723),
                                    ),
                                  ),
                                  const Divider(height: 24),
                                  // Filter list of unpaid bills in current range
                                  ..._buildUnpaidOrders(filteredOrders),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtext,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: color, width: 5)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtext,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            Icon(icon, size: 40, color: color.withOpacity(0.8)),
          ],
        ),
      ),
    );
  }
}
