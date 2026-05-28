import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coffee_shop_manager/main.dart';

void main() {
  testWidgets('Login screen rendering and error validation test', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the login screen title and fields exist
    expect(find.text('Đăng Nhập Hệ Thống'), findsOneWidget);
    expect(find.byKey(const ValueKey('email_field')), findsOneWidget);
    expect(find.byKey(const ValueKey('password_field')), findsOneWidget);
    expect(find.byKey(const ValueKey('login_button')), findsOneWidget);

    // 2. Try to log in with empty credentials
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();

    // Verify error dialog appears for empty credentials
    expect(find.text('Lỗi Đăng Nhập'), findsOneWidget);
    expect(find.text('Vui lòng nhập email và mật khẩu'), findsWidgets);

    // Close dialog
    await tester.tap(find.text('Đóng'));
    await tester.pumpAndSettle();

    // 3. Try to log in with invalid account email
    await tester.enterText(find.byKey(const ValueKey('email_field')), 'wrong@email.com');
    await tester.enterText(find.byKey(const ValueKey('password_field')), 'password');
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();

    // Verify correct error message
    expect(find.text('Không tìm thấy tài khoản'), findsWidgets);

    // Close dialog
    await tester.tap(find.text('Đóng'));
    await tester.pumpAndSettle();
  });

  testWidgets('Login success and dashboard navigation test', (WidgetTester tester) async {
    // Set desktop screen size
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // Build our app
    await tester.pumpWidget(const MyApp());

    // Enter correct credentials for manager
    await tester.enterText(find.byKey(const ValueKey('email_field')), 'manager@abc.com');
    await tester.enterText(find.byKey(const ValueKey('password_field')), 'admin123');
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle();

    // Verify navigation to dashboard (checks for dashboard header title)
    expect(find.text('Hệ thống Cà Phê ABC'), findsOneWidget);
    expect(find.text('Menu & Tạo Đơn'), findsOneWidget);
    expect(find.text('Kho Nguyên Liệu'), findsOneWidget);
    expect(find.text('Quản Lý Nhân Viên'), findsOneWidget);
    expect(find.text('Báo Cáo Doanh Thu'), findsOneWidget);

    // Tap on Kho Nguyên Liệu and verify
    await tester.tap(find.text('Kho Nguyên Liệu'));
    await tester.pumpAndSettle();
    expect(find.text('CẢNH BÁO HẾT NGUYÊN LIỆU (Tồn kho < 10)'), findsNothing); // initially safe

    // Tap on Quản Lý Nhân Viên and verify
    await tester.tap(find.text('Quản Lý Nhân Viên'));
    await tester.pumpAndSettle();
    expect(find.text('Danh Sách Nhân Viên (8)'), findsOneWidget);

    // Tap on Báo Cáo Doanh Thu and verify
    await tester.tap(find.text('Báo Cáo Doanh Thu'));
    await tester.pumpAndSettle();
    expect(find.text('Tổng Doanh Thu'), findsOneWidget);
  });
}
