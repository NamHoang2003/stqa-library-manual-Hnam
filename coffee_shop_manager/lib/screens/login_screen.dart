import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart'; // import global appState

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _obscurePassword = true;

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final result = appState.login(email, password);

    if (result == 'Success') {
      setState(() {
        _errorMessage = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chào mừng ${appState.currentUser?.name} quay trở lại!',
          ),
          backgroundColor: const Color(0xFF8D6E63),
        ),
      );
    } else {
      setState(() {
        _errorMessage = result;
      });
      // Show elegant error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              const Text('Lỗi Đăng Nhập'),
            ],
          ),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Đóng',
                style: TextStyle(color: Color(0xFF5D4037)),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      body: Stack(
        children: [
          // Elegant Coffee Pattern Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3E2723),
                  Color(0xFF5D4037),
                  Color(0xFF8D6E63),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Subtle warm lighting overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: isDesktop ? 900 : size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Brand Panel (Hidden on mobile)
                    if (isDesktop)
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF3D251E), Color(0xFF53352B)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.coffee,
                                  size: 80,
                                  color: Color(0xFFD2B48C),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Cà Phê ABC',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Hệ thống Quản lý Quán Cà Phê',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFD7CCC8),
                                ),
                              ),
                              const SizedBox(height: 48),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(
                                      0xFF8D6E63,
                                    ).withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  'Mức độ phủ: REQ-01 → REQ-08',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFD7CCC8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Right Form Panel
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 50 : 24,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!isDesktop) ...[
                              const Center(
                                child: Icon(
                                  Icons.coffee,
                                  size: 60,
                                  color: Color(0xFF5D4037),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Center(
                                child: Text(
                                  'Cà Phê ABC',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                            const Text(
                              'Đăng Nhập Hệ Thống',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vui lòng điền thông tin đăng nhập của bạn',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8D6E63),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Email Field
                            TextField(
                              key: const ValueKey('email_field'),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF8D6E63),
                                ),
                                labelText: 'Địa chỉ Email',
                                hintText:
                                    'manager@coffee.com hoặc staff@coffee.com',
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Password Field
                            TextField(
                              key: const ValueKey('password_field'),
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF8D6E63),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF8D6E63),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                labelText: 'Mật khẩu',
                                hintText: 'admin123 hoặc staff123',
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Error text
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            // Sign In Button
                            ElevatedButton(
                              key: const ValueKey('login_button'),
                              onPressed: _handleLogin,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ĐĂNG NHẬP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 20),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Seeding Quick Accounts Helper
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAF5EF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFEFE6DD),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tài khoản Demo (In-Memory):',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D4037),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    '• Quản lý: manager@coffee.com | admin123\n• Nhân viên: staff@coffee.com | staff123',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF7D5F55),
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _emailController.text =
                                            'manager@coffee.com';
                                        _passwordController.text = 'admin123';
                                      });
                                    },
                                    child: const Text(
                                      'Click để điền nhanh Quản lý',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _emailController.text =
                                            'staff@coffee.com';
                                        _passwordController.text = 'staff123';
                                      });
                                    },
                                    child: const Text(
                                      'Click để điền nhanh Nhân viên',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart'; // import global appState

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _obscurePassword = true;

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final result = appState.login(email, password);

    if (result == 'Success') {
      setState(() {
        _errorMessage = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chào mừng ${appState.currentUser?.name} quay trở lại!',
          ),
          backgroundColor: const Color(0xFF8D6E63),
        ),
      );
    } else {
      setState(() {
        _errorMessage = result;
      });
      // Show elegant error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              const Text('Lỗi Đăng Nhập'),
            ],
          ),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Đóng',
                style: TextStyle(color: Color(0xFF5D4037)),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      body: Stack(
        children: [
          // Elegant Coffee Pattern Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3E2723),
                  Color(0xFF5D4037),
                  Color(0xFF8D6E63),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Subtle warm lighting overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: isDesktop ? 900 : size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Brand Panel (Hidden on mobile)
                    if (isDesktop)
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF3D251E), Color(0xFF53352B)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.coffee,
                                  size: 80,
                                  color: Color(0xFFD2B48C),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Cà Phê ABC',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Hệ thống Quản lý Quán Cà Phê',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFD7CCC8),
                                ),
                              ),
                              const SizedBox(height: 48),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(
                                      0xFF8D6E63,
                                    ).withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  'Mức độ phủ: REQ-01 → REQ-08',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFD7CCC8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Right Form Panel
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 50 : 24,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!isDesktop) ...[
                              const Center(
                                child: Icon(
                                  Icons.coffee,
                                  size: 60,
                                  color: Color(0xFF5D4037),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Center(
                                child: Text(
                                  'Cà Phê ABC',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3E2723),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                            const Text(
                              'Đăng Nhập Hệ Thống',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Vui lòng điền thông tin đăng nhập của bạn',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8D6E63),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Email Field
                            TextField(
                              key: const ValueKey('email_field'),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF8D6E63),
                                ),
                                labelText: 'Địa chỉ Email',
                                hintText:
                                    'manager@coffee.com hoặc staff@coffee.com',
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Password Field
                            TextField(
                              key: const ValueKey('password_field'),
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFF8D6E63),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF8D6E63),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                labelText: 'Mật khẩu',
                                hintText: 'admin123 hoặc staff123',
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Error text
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            // Sign In Button
                            ElevatedButton(
                              key: const ValueKey('login_button'),
                              onPressed: _handleLogin,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ĐĂNG NHẬP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 20),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Seeding Quick Accounts Helper
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAF5EF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFEFE6DD),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tài khoản Demo (In-Memory):',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5D4037),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    '• Quản lý: manager@coffee.com | admin123\n• Nhân viên: staff@coffee.com | staff123',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF7D5F55),
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _emailController.text =
                                            'manager@coffee.com';
                                        _passwordController.text = 'admin123';
                                      });
                                    },
                                    child: const Text(
                                      'Click để điền nhanh Quản lý',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _emailController.text =
                                            'staff@coffee.com';
                                        _passwordController.text = 'staff123';
                                      });
                                    },
                                    child: const Text(
                                      'Click để điền nhanh Nhân viên',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
