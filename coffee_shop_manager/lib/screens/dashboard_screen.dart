import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/screens/menu_screen.dart';
import 'package:coffee_shop_manager/screens/staff_screen.dart';
import 'package:coffee_shop_manager/screens/inventory_screen.dart';
import 'package:coffee_shop_manager/screens/report_screen.dart';
import 'package:coffee_shop_manager/screens/order_cart_panel.dart'; // cart panel inside tabs

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final user = appState.currentUser;
        final isManager = user?.role == 'Manager';

        // List of screens/tabs
        // Managers see: Menu/Order, Inventory, Staff, Reports
        // Staff see: Menu/Order, Orders History
        final List<Widget> screens = [];
        final List<Map<String, dynamic>> tabItems = [];

        // Always add Menu/Order tab
        screens.add(const MenuScreen(cost: 0));
        tabItems.add({
          'title': 'Menu & Tạo Đơn',
          'icon': Icons.local_cafe_outlined,
        });

        if (isManager) {
          screens.add(const InventoryScreen());
          tabItems.add({
            'title': 'Kho Nguyên Liệu',
            'icon': Icons.inventory_2_outlined,
          });

          screens.add(const StaffScreen());
          tabItems.add({
            'title': 'Quản Lý Nhân Viên',
            'icon': Icons.people_outline,
          });

          screens.add(const ReportScreen());
          tabItems.add({
            'title': 'Báo Cáo Doanh Thu',
            'icon': Icons.bar_chart_outlined,
          });
        } else {
          // Staff see: Orders history
          screens.add(const OrderCartPanel(isHistoryOnly: true));
          tabItems.add({
            'title': 'Lịch Sử Đơn Hàng',
            'icon': Icons.receipt_long_outlined,
          });
        }

        final currentIndex = appState.activeTabIndex >= screens.length
            ? 0
            : appState.activeTabIndex;

        // Body content
        final bodyContent = IndexedStack(
          index: currentIndex,
          children: screens,
        );

        // Responsive design: Left Side Navigation for Desktop, Drawer/Bottom Navigation for Mobile
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Icon(Icons.coffee, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  isDesktop ? 'Hệ thống Cà Phê ABC' : 'ABC Coffee',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF3E2723), // Warm dark brown
            elevation: 0,
            actions: [
              // Seeding restore button for testing convenience
              if (isManager)
                IconButton(
                  tooltip: 'Khôi phục dữ liệu ban đầu',
                  icon: const Icon(Icons.restore, color: Colors.white70),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Khôi phục dữ liệu?'),
                        content: const Text(
                          'Tất cả đơn hàng và nhân viên tự thêm sẽ bị xóa, kho nguyên liệu được nạp lại về ban đầu.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Hủy',
                              style: TextStyle(color: Color(0xFF5D4037)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              appState.restoreData();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Đã khôi phục dữ liệu về seed data thành công!',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Khôi phục',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(width: 10),
              // User Badge (Responsive)
              isDesktop
                  ? Chip(
                      backgroundColor: const Color(0xFF5D4037),
                      padding: EdgeInsets.zero,
                      label: Text(
                        '${user?.name} (${user?.role == 'Manager' ? 'Quản lý' : 'Nhân viên'})',
                        style: const TextStyle(
                          color: Color(0xFFEFE6DD),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      avatar: Icon(
                        user?.role == 'Manager'
                            ? Icons.admin_panel_settings
                            : Icons.person,
                        color: const Color(0xFFD2B48C),
                        size: 16,
                      ),
                      side: BorderSide.none,
                    )
                  : Tooltip(
                      message:
                          '${user?.name} (${user?.role == 'Manager' ? 'Quản lý' : 'Nhân viên'})',
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF5D4037),
                        radius: 16,
                        child: Icon(
                          user?.role == 'Manager'
                              ? Icons.admin_panel_settings
                              : Icons.person,
                          color: const Color(0xFFD2B48C),
                          size: 16,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              IconButton(
                tooltip: 'Đăng xuất',
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  appState.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đăng xuất thành công')),
                  );
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
          body: isDesktop
              ? Row(
                  children: [
                    // Desktop Navigation Drawer Sidebar
                    Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAF5EF),
                        border: Border(
                          right: BorderSide(
                            color: Color(0xFFEFE6DD),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          // Decorative coffee shop info card
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5D4037),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.storefront,
                                  color: Color(0xFFD2B48C),
                                  size: 30,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cửa Hàng ABC',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Đang hoạt động',
                                        style: TextStyle(
                                          color: Color(0xFFD7CCC8),
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: ListView.builder(
                              itemCount: tabItems.length,
                              itemBuilder: (context, idx) {
                                final item = tabItems[idx];
                                final isSelected = currentIndex == idx;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  child: Material(
                                    color: isSelected
                                        ? const Color(0xFF5D4037)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      leading: Icon(
                                        item['icon'] as IconData,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF8D6E63),
                                      ),
                                      title: Text(
                                        item['title'] as String,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(0xFF3E2723),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        appState.setActiveTabIndex(idx);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Sidebar Footer
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Phiên bản 1.0.0 (In-Memory)',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Main Panel
                    Expanded(child: bodyContent),
                  ],
                )
              : bodyContent,
          bottomNavigationBar: !isDesktop
              ? BottomNavigationBar(
                  currentIndex: currentIndex,
                  selectedItemColor: const Color(0xFF5D4037),
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  type: BottomNavigationBarType.fixed,
                  onTap: (idx) {
                    appState.setActiveTabIndex(idx);
                  },
                  items: tabItems.map((item) {
                    return BottomNavigationBarItem(
                      icon: Icon(item['icon'] as IconData),
                      label: item['title'] as String,
                    );
                  }).toList(),
                )
              : null,
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/screens/menu_screen.dart';
import 'package:coffee_shop_manager/screens/staff_screen.dart';
import 'package:coffee_shop_manager/screens/inventory_screen.dart';
import 'package:coffee_shop_manager/screens/report_screen.dart';
import 'package:coffee_shop_manager/screens/order_cart_panel.dart'; // cart panel inside tabs

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final user = appState.currentUser;
        final isManager = user?.role == 'Manager';

        // List of screens/tabs
        // Managers see: Menu/Order, Inventory, Staff, Reports
        // Staff see: Menu/Order, Orders History
        final List<Widget> screens = [];
        final List<Map<String, dynamic>> tabItems = [];

        // Always add Menu/Order tab
        screens.add(const MenuScreen(cost: 0));
        tabItems.add({'title': 'Menu & Tạo Đơn', 'icon': Icons.local_cafe_outlined});

        if (isManager) {
          screens.add(const InventoryScreen());
          tabItems.add({'title': 'Kho Nguyên Liệu', 'icon': Icons.inventory_2_outlined});

          screens.add(const StaffScreen());
          tabItems.add({'title': 'Quản Lý Nhân Viên', 'icon': Icons.people_outline});

          screens.add(const ReportScreen());
          tabItems.add({'title': 'Báo Cáo Doanh Thu', 'icon': Icons.bar_chart_outlined});
        } else {
          // Staff see: Orders history
          screens.add(const OrderCartPanel(isHistoryOnly: true));
          tabItems.add({'title': 'Lịch Sử Đơn Hàng', 'icon': Icons.receipt_long_outlined});
        }

        final currentIndex = appState.activeTabIndex >= screens.length ? 0 : appState.activeTabIndex;

        // Body content
        final bodyContent = IndexedStack(
          index: currentIndex,
          children: screens,
        );

        // Responsive design: Left Side Navigation for Desktop, Drawer/Bottom Navigation for Mobile
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Icon(Icons.coffee, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  isDesktop ? 'Hệ thống Cà Phê ABC' : 'ABC Coffee',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF3E2723), // Warm dark brown
            elevation: 0,
            actions: [
              // Seeding restore button for testing convenience
              if (isManager)
                IconButton(
                  tooltip: 'Khôi phục dữ liệu ban đầu',
                  icon: const Icon(Icons.restore, color: Colors.white70),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Khôi phục dữ liệu?'),
                        content: const Text('Tất cả đơn hàng và nhân viên tự thêm sẽ bị xóa, kho nguyên liệu được nạp lại về ban đầu.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Hủy', style: TextStyle(color: Color(0xFF5D4037))),
                          ),
                          TextButton(
                            onPressed: () {
                              appState.restoreData();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã khôi phục dữ liệu về seed data thành công!')),
                              );
                            },
                            child: const Text('Khôi phục', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(width: 10),
              // User Badge (Responsive)
              isDesktop
                  ? Chip(
                      backgroundColor: const Color(0xFF5D4037),
                      padding: EdgeInsets.zero,
                      label: Text(
                        '${user?.name} (${user?.role == 'Manager' ? 'Quản lý' : 'Nhân viên'})',
                        style: const TextStyle(color: Color(0xFFEFE6DD), fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      avatar: Icon(
                        user?.role == 'Manager' ? Icons.admin_panel_settings : Icons.person,
                        color: const Color(0xFFD2B48C),
                        size: 16,
                      ),
                      side: BorderSide.none,
                    )
                  : Tooltip(
                      message: '${user?.name} (${user?.role == 'Manager' ? 'Quản lý' : 'Nhân viên'})',
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF5D4037),
                        radius: 16,
                        child: Icon(
                          user?.role == 'Manager' ? Icons.admin_panel_settings : Icons.person,
                          color: const Color(0xFFD2B48C),
                          size: 16,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              IconButton(
                tooltip: 'Đăng xuất',
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  appState.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đăng xuất thành công')),
                  );
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
          body: isDesktop
              ? Row(
                  children: [
                    // Desktop Navigation Drawer Sidebar
                    Container(
                      width: 250,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAF5EF),
                        border: Border(
                          right: BorderSide(color: Color(0xFFEFE6DD), width: 1.5),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          // Decorative coffee shop info card
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5D4037),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.storefront, color: Color(0xFFD2B48C), size: 30),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cửa Hàng ABC',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Đang hoạt động',
                                        style: TextStyle(color: Color(0xFFD7CCC8), fontSize: 11),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: ListView.builder(
                              itemCount: tabItems.length,
                              itemBuilder: (context, idx) {
                                final item = tabItems[idx];
                                final isSelected = currentIndex == idx;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Material(
                                    color: isSelected ? const Color(0xFF5D4037) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      leading: Icon(
                                        item['icon'] as IconData,
                                        color: isSelected ? Colors.white : const Color(0xFF8D6E63),
                                      ),
                                      title: Text(
                                        item['title'] as String,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : const Color(0xFF3E2723),
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      onTap: () {
                                        appState.setActiveTabIndex(idx);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Sidebar Footer
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Phiên bản 1.0.0 (In-Memory)',
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Main Panel
                    Expanded(
                      child: bodyContent,
                    ),
                  ],
                )
              : bodyContent,
          bottomNavigationBar: !isDesktop
              ? BottomNavigationBar(
                  currentIndex: currentIndex,
                  selectedItemColor: const Color(0xFF5D4037),
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  type: BottomNavigationBarType.fixed,
                  onTap: (idx) {
                    appState.setActiveTabIndex(idx);
                  },
                  items: tabItems.map((item) {
                    return BottomNavigationBarItem(
                      icon: Icon(item['icon'] as IconData),
                      label: item['title'] as String,
                    );
                  }).toList(),
                )
              : null,
        );
      },
    );
  }
}
