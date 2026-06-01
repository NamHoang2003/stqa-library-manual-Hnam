import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:coffee_shop_manager/services/app_state.dart';
import 'package:coffee_shop_manager/screens/login_screen.dart';
import 'package:coffee_shop_manager/screens/dashboard_screen.dart';

// Central state instance
final appState = AppStateProvider();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        return MaterialApp(
          title: 'Hệ thống Quản lý Cà Phê ABC',
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5D4037), // Deep Espresso Brown
              primary: const Color(0xFF5D4037),
              secondary: const Color(0xFF8D6E63), // Roasted Bean
              tertiary: const Color(0xFFD7CCC8), // Light milk foam
              background: const Color(0xFFFBF8F6), // Warm off-white
              surface: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              error: const Color(0xFFD32F2F),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5D4037),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5D4037),
                side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFFF5EFEB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF5D4037),
                  width: 2,
                ),
              ),
              labelStyle: const TextStyle(color: Color(0xFF8D6E63)),
              floatingLabelStyle: const TextStyle(
                color: Color(0xFF5D4037),
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          home: appState.currentUser == null
              ? const LoginScreen()
              : DashboardScreen(),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:coffee_shop_manager/services/app_state.dart';
import 'package:coffee_shop_manager/screens/login_screen.dart';
import 'package:coffee_shop_manager/screens/dashboard_screen.dart';

// Central state instance
final appState = AppStateProvider();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        return MaterialApp(
          title: 'Hệ thống Quản lý Cà Phê ABC',
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5D4037), // Deep Espresso Brown
              primary: const Color(0xFF5D4037),
              secondary: const Color(0xFF8D6E63), // Roasted Bean
              tertiary: const Color(0xFFD7CCC8), // Light milk foam
              background: const Color(0xFFFBF8F6), // Warm off-white
              surface: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              error: const Color(0xFFD32F2F),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5D4037),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5D4037),
                side: const BorderSide(color: Color(0xFF5D4037), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFFF5EFEB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF5D4037), width: 2),
              ),
              labelStyle: const TextStyle(color: Color(0xFF8D6E63)),
              floatingLabelStyle: const TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          home: appState.currentUser == null
              ? const LoginScreen()
              : DashboardScreen(),
        );
      },
    );
  }
}
