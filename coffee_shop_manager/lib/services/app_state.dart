import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/models/employee.dart';
import 'package:coffee_shop_manager/models/drink.dart';
import 'package:coffee_shop_manager/models/ingredient.dart';
import 'package:coffee_shop_manager/models/order.dart';

class AppStateProvider extends ChangeNotifier {
  // Current logged in user
  Employee? _currentUser;
  Employee? get currentUser => _currentUser;

  // Active Screen/Tab Index for Navigation
  int _activeTabIndex = 0;
  int get activeTabIndex => _activeTabIndex;

  void setActiveTabIndex(int index) {
    _activeTabIndex = index;
    notifyListeners();
  }

  // Employee list (pre-seeded)
  final List<Employee> _employees = [
    Employee(
      id: 'EMP001',
      name: 'Nguyễn Văn Quản',
      email: 'manager@coffee.com',
      phone: '0901234567',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP002',
      name: 'Trần Thị Phục Vụ',
      email: 'staff1@coffee.com',
      phone: '0907654321',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP003',
      name: 'Lê Văn Pha Chế',
      email: 'staff2@coffee.com',
      phone: '0908889999',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP004',
      name: 'Phạm Tạm Ngưng',
      email: 'staff3@coffee.com',
      phone: '0904445555',
      role: 'Staff',
      status: 'Nghỉ việc',
    ),
    Employee(
      id: 'EMP005',
      name: 'Manager Coffee 2',
      email: 'manager2@coffee.com',
      phone: '0901112222',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP006',
      name: 'Staff Coffee',
      email: 'staff@coffee.com',
      phone: '0903334444',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP007',
      name: 'Manager Coffee 3',
      email: 'manager3@coffee.com',
      phone: '0905556666',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP008',
      name: 'Bá Nguyễn',
      email: 'ba.nguyen@coffee.com',
      phone: '0907778888',
      role: 'Staff',
      status: 'Đang làm',
    ),
  ];
  List<Employee> get employees => List.unmodifiable(_employees);

  // Ingredient inventory (pre-seeded)
  final List<Ingredient> _ingredients = [
    Ingredient(name: 'Cà phê bột', quantity: 1000.0, unit: 'g'),
    Ingredient(name: 'Sữa tươi', quantity: 2000.0, unit: 'ml'),
    Ingredient(name: 'Đường', quantity: 1500.0, unit: 'g'),
    Ingredient(name: 'Sữa đặc', quantity: 1000.0, unit: 'g'),
    Ingredient(name: 'Ly giấy', quantity: 100.0, unit: 'cái'),
    Ingredient(name: 'Trà túi lọc', quantity: 50.0, unit: 'cái'),
    Ingredient(name: 'Đào ngâm', quantity: 100.0, unit: 'miếng'),
    Ingredient(name: 'Siro bạc hà', quantity: 500.0, unit: 'ml'),
    Ingredient(name: 'Việt quất mứt', quantity: 500.0, unit: 'g'),
    Ingredient(name: 'Bột matcha', quantity: 300.0, unit: 'g'),
  ];
  List<Ingredient> get ingredients => List.unmodifiable(_ingredients);

  // Drinks list (pre-seeded)
  final List<Drink> _drinks = [
    Drink(
      'Cà phê đen',
      20000,
      'Còn đồ',
      'VND',
      type: 'Cà phê',
      recipe: {'Cà phê bột': 15.0, 'Đường': 10.0, 'Ly giấy': 1.0},
    ),
    Drink(
      'Cà phê sữa',
      25000,
      'Còn đồ',
      'VND',
      type: 'Cà phê',
      recipe: {'Cà phê bột': 15.0, 'Sữa đặc': 25.0, 'Ly giấy': 1.0},
    ),
    Drink(
      'Bạc xỉu',
      29000,
      'Còn đồ',
      'VND',
      type: 'Cà phê',
      recipe: {
        'Cà phê bột': 10.0,
        'Sữa tươi': 100.0,
        'Sữa đặc': 20.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Trà Đào Cam Sả',
      35000,
      'Còn đồ',
      'VND',
      type: 'Trà',
      recipe: {
        'Trà túi lọc': 1.0,
        'Đào ngâm': 2.0,
        'Đường': 20.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Trà đào xả tắc',
      35000,
      'Còn đồ',
      'VND',
      type: 'Trà',
      recipe: {
        'Trà túi lọc': 1.0,
        'Đào ngâm': 2.0,
        'Đường': 20.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Trà Sữa Việt Quất',
      32000,
      'Còn đồ',
      'VND',
      type: 'Trà sữa',
      recipe: {
        'Trà túi lọc': 1.0,
        'Sữa tươi': 100.0,
        'Việt quất mứt': 30.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Trà Sữa Bạc Hà',
      30000,
      'Còn đồ',
      'VND',
      type: 'Trà sữa',
      recipe: {
        'Trà túi lọc': 1.0,
        'Sữa tươi': 100.0,
        'Siro bạc hà': 20.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Caramel Vị Muối Biển',
      45000,
      'Còn đồ',
      'VND',
      type: 'Đá xay',
      recipe: {'Sữa tươi': 150.0, 'Đường': 15.0, 'Ly giấy': 1.0},
    ),
    Drink(
      'Trà Sữa Chuối Nướng',
      40000,
      'Còn đồ',
      'VND',
      type: 'Trà sữa',
      recipe: {'Trà túi lọc': 1.0, 'Sữa tươi': 100.0, 'Ly giấy': 1.0},
    ),
    Drink(
      'Trà Sữa Matcha',
      35000,
      'Còn đồ',
      'VND',
      type: 'Trà sữa',
      recipe: {
        'Trà túi lọc': 1.0,
        'Sữa tươi': 100.0,
        'Bột matcha': 5.0,
        'Ly giấy': 1.0,
      },
    ),
    Drink(
      'Sinh tố Bơ',
      45000,
      'Còn đồ',
      'VND',
      type: 'Sinh tố',
      recipe: {'Sữa tươi': 100.0, 'Sữa đặc': 30.0, 'Ly giấy': 1.0},
    ),
    Drink(
      'Sinh tố Xoài',
      45000,
      'Còn đồ',
      'VND',
      type: 'Sinh tố',
      recipe: {'Sữa tươi': 100.0, 'Sữa đặc': 30.0, 'Ly giấy': 1.0},
    ),
  ];
  List<Drink> get drinks => List.unmodifiable(_drinks);

  // Orders list (in-memory)
  final List<Order> _orders = [];
  List<Order> get orders => List.unmodifiable(_orders);

  // Cart: Map of Drink name to quantity
  final Map<String, int> _cart = {};
  Map<String, int> get cart => _cart;

  // Initial Seeding Reset (Restore Data without Refresh)
  void restoreData() {
    _currentUser = null;
    _activeTabIndex = 0;
    _cart.clear();
    _orders.clear();

    // Reset Employees
    _employees.clear();
    _employees.addAll([
      Employee(
        id: 'EMP001',
        name: 'Nguyễn Văn Quản',
        email: 'manager@abc.com',
        phone: '0901234567',
        role: 'Manager',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP002',
        name: 'Trần Thị Phục Vụ',
        email: 'staff1@abc.com',
        phone: '0907654321',
        role: 'Staff',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP003',
        name: 'Lê Văn Pha Chế',
        email: 'staff2@abc.com',
        phone: '0908889999',
        role: 'Staff',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP004',
        name: 'Phạm Tạm Ngưng',
        email: 'staff3@abc.com',
        phone: '0904445555',
        role: 'Staff',
        status: 'Nghỉ việc',
      ),
      Employee(
        id: 'EMP005',
        name: 'Manager Coffee',
        email: 'manager@coffee.com',
        phone: '0901112222',
        role: 'Manager',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP006',
        name: 'Staff Coffee',
        email: 'staff@coffee.com',
        phone: '0903334444',
        role: 'Staff',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP007',
        name: 'Librarian',
        email: 'librarian@library.com',
        phone: '0905556666',
        role: 'Manager',
        status: 'Đang làm',
      ),
      Employee(
        id: 'EMP008',
        name: 'Bá Nguyễn',
        email: 'ba.nguyen@email.com',
        phone: '0907778888',
        role: 'Staff',
        status: 'Đang làm',
      ),
    ]);

    // Reset Ingredients
    _ingredients.clear();
    _ingredients.addAll([
      Ingredient(name: 'Cà phê bột', quantity: 1000.0, unit: 'g'),
      Ingredient(name: 'Sữa tươi', quantity: 2000.0, unit: 'ml'),
      Ingredient(name: 'Đường', quantity: 1500.0, unit: 'g'),
      Ingredient(name: 'Sữa đặc', quantity: 1000.0, unit: 'g'),
      Ingredient(name: 'Ly giấy', quantity: 100.0, unit: 'cái'),
      Ingredient(name: 'Trà túi lọc', quantity: 50.0, unit: 'cái'),
      Ingredient(name: 'Đào ngâm', quantity: 100.0, unit: 'miếng'),
      Ingredient(name: 'Siro bạc hà', quantity: 500.0, unit: 'ml'),
      Ingredient(name: 'Việt quất mứt', quantity: 500.0, unit: 'g'),
      Ingredient(name: 'Bột matcha', quantity: 300.0, unit: 'g'),
    ]);

    notifyListeners();
  }

  // Get current quantity of an ingredient
  double getIngredientQuantity(String name) {
    try {
      return _ingredients
          .firstWhere((element) => element.name == name)
          .quantity;
    } catch (_) {
      return 0.0;
    }
  }

  // Update ingredient quantity manually
  void updateIngredientQuantity(String name, double quantity) {
    final index = _ingredients.indexWhere((element) => element.name == name);
    if (index != -1) {
      _ingredients[index] = _ingredients[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  // Dynamic drink state calculation based on inventory
  String getDrinkState(Drink drink) {
    for (var entry in drink.recipe.entries) {
      final requiredQty = entry.value;
      final currentQty = getIngredientQuantity(entry.key);
      if (currentQty < requiredQty) {
        return 'Hết tạm thời';
      }
    }
    return 'Còn đồ';
  }

  // Employee CRUD operations
  String addEmployee(String name, String email, String phone, String role) {
    // Validate email
    if (!email.contains('@') ||
        !email.substring(email.indexOf('@')).contains('.')) {
      return 'Email không hợp lệ (cần có @ và . ở phần tên miền)';
    }

    // Check duplicate
    final isDuplicate = _employees.any(
      (element) => element.email.toLowerCase() == email.toLowerCase(),
    );
    if (isDuplicate) {
      return 'Email này đã được sử dụng bởi một nhân viên khác';
    }

    final newId = 'EMP${(_employees.length + 1).toString().padLeft(3, '0')}';
    _employees.add(
      Employee(
        id: newId,
        name: name,
        email: email,
        phone: phone,
        role: role,
        status: 'Đang làm',
      ),
    );
    notifyListeners();
    return 'Success';
  }

  void updateEmployee(
    String id,
    String name,
    String phone,
    String role,
    String status,
  ) {
    final index = _employees.indexWhere((element) => element.id == id);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(
        name: name,
        phone: phone,
        role: role,
        status: status,
      );
      notifyListeners();
    }
  }

  void deleteEmployee(String id) {
    _employees.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void toggleEmployeeStatus(String id) {
    final index = _employees.indexWhere((element) => element.id == id);
    if (index != -1) {
      final currentStatus = _employees[index].status;
      _employees[index] = _employees[index].copyWith(
        status: currentStatus == 'Đang làm' ? 'Nghỉ việc' : 'Đang làm',
      );
      notifyListeners();
    }
  }

  // Login handler
  String login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return 'Vui lòng nhập email và mật khẩu';
    }

    try {
      final emp = _employees.firstWhere(
        (element) => element.email.toLowerCase() == email.toLowerCase(),
      );

      // Simple password check logic:
      // Manager default is admin123
      // Staff defaults are staff123
      // Special override for ba.nguyen@email.com: password123
      final expectedPassword = emp.email.toLowerCase() == 'ba.nguyen@email.com'
          ? 'password123'
          : (emp.role == 'Manager' ? 'admin123' : 'staff123');

      if (password != expectedPassword) {
        return 'Mật khẩu không đúng';
      }

      if (emp.status == 'Nghỉ việc') {
        return 'Tài khoản nhân viên này đang bị tạm ngưng/nghỉ việc';
      }

      _currentUser = emp;
      _activeTabIndex = 0;
      notifyListeners();
      return 'Success';
    } catch (_) {
      return 'Không tìm thấy tài khoản';
    }
  }

  void logout() {
    _currentUser = null;
    _cart.clear();
    _activeTabIndex = 0;
    notifyListeners();
  }

  // Cart operations
  int get cartTotalItems => _cart.values.fold(0, (sum, qty) => sum + qty);

  int get cartSubtotal {
    int sub = 0;
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      sub += d.cost * qty;
    });
    return sub;
  }

  int getVoucherDiscount(String? code, int sub) {
    if (code == null || code.trim().isEmpty) return 0;
    final formattedCode = code.trim().toUpperCase();
    if (formattedCode == 'ABC10') {
      return (sub * 0.1).round();
    }
    if (formattedCode == 'COFFEE20') {
      return sub > 20000 ? 20000 : sub;
    }
    return 0;
  }

  // Check if adding one more of a drink is allowed by inventory
  bool canAddDrink(Drink drink, {int quantityToAdd = 1}) {
    // 1. Enforce item quantity limit (Max 10 total items)
    if (cartTotalItems + quantityToAdd > 10) {
      return false;
    }

    // 2. Enforce ingredient availability
    final required = <String, double>{};

    // Calculate current cart recipe totals
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      d.recipe.forEach((ingName, amount) {
        required[ingName] = (required[ingName] ?? 0.0) + (amount * qty);
      });
    });

    // Add proposed recipe amounts
    drink.recipe.forEach((ingName, amount) {
      required[ingName] = (required[ingName] ?? 0.0) + (amount * quantityToAdd);
    });

    // Verify against inventory
    for (var entry in required.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      if (currentStock < entry.value) {
        return false;
      }
    }

    return true;
  }

  String addToCart(Drink drink) {
    // Check if ingredient is sufficient dynamically
    if (getDrinkState(drink) == 'Hết tạm thời') {
      return 'Món này đã hết nguyên liệu để chế biến';
    }

    if (cartTotalItems + 1 > 10) {
      return 'Đơn hàng tối đa chỉ được 10 món';
    }

    if (!canAddDrink(drink, quantityToAdd: 1)) {
      return 'Không đủ nguyên liệu tồn kho để làm thêm món này';
    }

    _cart[drink.name] = (_cart[drink.name] ?? 0) + 1;
    notifyListeners();
    return 'Success';
  }

  void updateCartQuantity(String drinkName, int newQty) {
    if (newQty <= 0) {
      _cart.remove(drinkName);
      notifyListeners();
      return;
    }

    final d = _drinks.firstWhere((e) => e.name == drinkName);
    final currentQty = _cart[drinkName] ?? 0;
    final diff = newQty - currentQty;

    if (diff > 0) {
      if (!canAddDrink(d, quantityToAdd: diff)) {
        return; // Silent fail or handles through check
      }
    }

    _cart[drinkName] = newQty;
    notifyListeners();
  }

  void removeFromCart(String drinkName) {
    _cart.remove(drinkName);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Checkout transaction
  String checkout({
    required String paymentMethod,
    String? voucherCode,
    required String status,
  }) {
    if (_cart.isEmpty) {
      return 'Giỏ hàng đang trống';
    }

    final sub = cartSubtotal;
    final disc = getVoucherDiscount(voucherCode, sub);
    final tot = sub - disc;

    // Build items list
    final List<OrderItem> orderItems = [];
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      orderItems.add(OrderItem(drink: d, quantity: qty));
    });

    // Verify ingredients one last time
    final requiredIngredients = <String, double>{};
    for (var item in orderItems) {
      item.drink.recipe.forEach((ingName, amount) {
        requiredIngredients[ingName] =
            (requiredIngredients[ingName] ?? 0.0) + (amount * item.quantity);
      });
    }

    for (var entry in requiredIngredients.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      if (currentStock < entry.value) {
        return 'Không đủ nguyên liệu ${entry.key} trong kho';
      }
    }

    // Deduct ingredients
    for (var entry in requiredIngredients.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      updateIngredientQuantity(entry.key, currentStock - entry.value);
    }

    // Create the Order record
    final newOrder = Order(
      id: 'ORD${(_orders.length + 1).toString().padLeft(3, '0')}',
      items: orderItems,
      subtotal: sub,
      discount: disc,
      total: tot,
      paymentMethod: paymentMethod,
      voucherCode: voucherCode != null && voucherCode.trim().isNotEmpty
          ? voucherCode.trim().toUpperCase()
          : null,
      date: DateTime.now(),
      status: status,
      createdById: _currentUser?.id ?? 'SYSTEM',
      createdByName: _currentUser?.name ?? 'System',
    );

    _orders.add(newOrder);
    _cart.clear();
    notifyListeners();
    return 'Success';
  }

  // Update payment status for unpaid orders
  void payOrder(String orderId) {
    final index = _orders.indexWhere((element) => element.id == orderId);
    if (index != -1) {
      final old = _orders[index];
      _orders[index] = Order(
        id: old.id,
        items: old.items,
        subtotal: old.subtotal,
        discount: old.discount,
        total: old.total,
        paymentMethod: old.paymentMethod,
        voucherCode: old.voucherCode,
        date: old.date,
        status: 'Đã thanh toán',
        createdById: old.createdById,
        createdByName: old.createdByName,
      );
      notifyListeners();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/models/employee.dart';
import 'package:coffee_shop_manager/models/drink.dart';
import 'package:coffee_shop_manager/models/ingredient.dart';
import 'package:coffee_shop_manager/models/order.dart';

class AppStateProvider extends ChangeNotifier {
  // Current logged in user
  Employee? _currentUser;
  Employee? get currentUser => _currentUser;

  // Active Screen/Tab Index for Navigation
  int _activeTabIndex = 0;
  int get activeTabIndex => _activeTabIndex;

  void setActiveTabIndex(int index) {
    _activeTabIndex = index;
    notifyListeners();
  }

  // Employee list (pre-seeded)
  final List<Employee> _employees = [
    Employee(
      id: 'EMP001',
      name: 'Nguyễn Văn Quản',
      email: 'manager@abc.com',
      phone: '0901234567',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP002',
      name: 'Trần Thị Phục Vụ',
      email: 'staff1@abc.com',
      phone: '0907654321',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP003',
      name: 'Lê Văn Pha Chế',
      email: 'staff2@abc.com',
      phone: '0908889999',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP004',
      name: 'Phạm Tạm Ngưng',
      email: 'staff3@abc.com',
      phone: '0904445555',
      role: 'Staff',
      status: 'Nghỉ việc',
    ),
    Employee(
      id: 'EMP005',
      name: 'Manager Coffee',
      email: 'manager@coffee.com',
      phone: '0901112222',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP006',
      name: 'Staff Coffee',
      email: 'staff@coffee.com',
      phone: '0903334444',
      role: 'Staff',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP007',
      name: 'Librarian',
      email: 'librarian@library.com',
      phone: '0905556666',
      role: 'Manager',
      status: 'Đang làm',
    ),
    Employee(
      id: 'EMP008',
      name: 'Bá Nguyễn',
      email: 'ba.nguyen@email.com',
      phone: '0907778888',
      role: 'Staff',
      status: 'Đang làm',
    ),
  ];
  List<Employee> get employees => List.unmodifiable(_employees);

  // Ingredient inventory (pre-seeded)
  final List<Ingredient> _ingredients = [
    Ingredient(name: 'Cà phê bột', quantity: 1000.0, unit: 'g'),
    Ingredient(name: 'Sữa tươi', quantity: 2000.0, unit: 'ml'),
    Ingredient(name: 'Đường', quantity: 1500.0, unit: 'g'),
    Ingredient(name: 'Sữa đặc', quantity: 1000.0, unit: 'g'),
    Ingredient(name: 'Ly giấy', quantity: 100.0, unit: 'cái'),
    Ingredient(name: 'Trà túi lọc', quantity: 50.0, unit: 'cái'),
    Ingredient(name: 'Đào ngâm', quantity: 100.0, unit: 'miếng'),
    Ingredient(name: 'Siro bạc hà', quantity: 500.0, unit: 'ml'),
    Ingredient(name: 'Việt quất mứt', quantity: 500.0, unit: 'g'),
    Ingredient(name: 'Bột matcha', quantity: 300.0, unit: 'g'),
  ];
  List<Ingredient> get ingredients => List.unmodifiable(_ingredients);

  // Drinks list (pre-seeded)
  final List<Drink> _drinks = [
    Drink('Cà phê đen', 20000, 'Còn đồ', 'VND', type: 'Cà phê', recipe: {'Cà phê bột': 15.0, 'Đường': 10.0, 'Ly giấy': 1.0}),
    Drink('Cà phê sữa', 25000, 'Còn đồ', 'VND', type: 'Cà phê', recipe: {'Cà phê bột': 15.0, 'Sữa đặc': 25.0, 'Ly giấy': 1.0}),
    Drink('Bạc xỉu', 29000, 'Còn đồ', 'VND', type: 'Cà phê', recipe: {'Cà phê bột': 10.0, 'Sữa tươi': 100.0, 'Sữa đặc': 20.0, 'Ly giấy': 1.0}),
    Drink('Trà Đào Cam Sả', 35000, 'Còn đồ', 'VND', type: 'Trà', recipe: {'Trà túi lọc': 1.0, 'Đào ngâm': 2.0, 'Đường': 20.0, 'Ly giấy': 1.0}),
    Drink('Trà đào xả tắc', 35000, 'Còn đồ', 'VND', type: 'Trà', recipe: {'Trà túi lọc': 1.0, 'Đào ngâm': 2.0, 'Đường': 20.0, 'Ly giấy': 1.0}),
    Drink('Trà Sữa Việt Quất', 32000, 'Còn đồ', 'VND', type: 'Trà sữa', recipe: {'Trà túi lọc': 1.0, 'Sữa tươi': 100.0, 'Việt quất mứt': 30.0, 'Ly giấy': 1.0}),
    Drink('Trà Sữa Bạc Hà', 30000, 'Còn đồ', 'VND', type: 'Trà sữa', recipe: {'Trà túi lọc': 1.0, 'Sữa tươi': 100.0, 'Siro bạc hà': 20.0, 'Ly giấy': 1.0}),
    Drink('Caramel Vị Muối Biển', 45000, 'Còn đồ', 'VND', type: 'Đá xay', recipe: {'Sữa tươi': 150.0, 'Đường': 15.0, 'Ly giấy': 1.0}),
    Drink('Trà Sữa Chuối Nướng', 40000, 'Còn đồ', 'VND', type: 'Trà sữa', recipe: {'Trà túi lọc': 1.0, 'Sữa tươi': 100.0, 'Ly giấy': 1.0}),
    Drink('Trà Sữa Matcha', 35000, 'Còn đồ', 'VND', type: 'Trà sữa', recipe: {'Trà túi lọc': 1.0, 'Sữa tươi': 100.0, 'Bột matcha': 5.0, 'Ly giấy': 1.0}),
    Drink('Sinh tố Bơ', 45000, 'Còn đồ', 'VND', type: 'Sinh tố', recipe: {'Sữa tươi': 100.0, 'Sữa đặc': 30.0, 'Ly giấy': 1.0}),
    Drink('Sinh tố Xoài', 45000, 'Còn đồ', 'VND', type: 'Sinh tố', recipe: {'Sữa tươi': 100.0, 'Sữa đặc': 30.0, 'Ly giấy': 1.0}),
  ];
  List<Drink> get drinks => List.unmodifiable(_drinks);

  // Orders list (in-memory)
  final List<Order> _orders = [];
  List<Order> get orders => List.unmodifiable(_orders);

  // Cart: Map of Drink name to quantity
  final Map<String, int> _cart = {};
  Map<String, int> get cart => _cart;

  // Initial Seeding Reset (Restore Data without Refresh)
  void restoreData() {
    _currentUser = null;
    _activeTabIndex = 0;
    _cart.clear();
    _orders.clear();

    // Reset Employees
    _employees.clear();
    _employees.addAll([
      Employee(id: 'EMP001', name: 'Nguyễn Văn Quản', email: 'manager@abc.com', phone: '0901234567', role: 'Manager', status: 'Đang làm'),
      Employee(id: 'EMP002', name: 'Trần Thị Phục Vụ', email: 'staff1@abc.com', phone: '0907654321', role: 'Staff', status: 'Đang làm'),
      Employee(id: 'EMP003', name: 'Lê Văn Pha Chế', email: 'staff2@abc.com', phone: '0908889999', role: 'Staff', status: 'Đang làm'),
      Employee(id: 'EMP004', name: 'Phạm Tạm Ngưng', email: 'staff3@abc.com', phone: '0904445555', role: 'Staff', status: 'Nghỉ việc'),
      Employee(id: 'EMP005', name: 'Manager Coffee', email: 'manager@coffee.com', phone: '0901112222', role: 'Manager', status: 'Đang làm'),
      Employee(id: 'EMP006', name: 'Staff Coffee', email: 'staff@coffee.com', phone: '0903334444', role: 'Staff', status: 'Đang làm'),
      Employee(id: 'EMP007', name: 'Librarian', email: 'librarian@library.com', phone: '0905556666', role: 'Manager', status: 'Đang làm'),
      Employee(id: 'EMP008', name: 'Bá Nguyễn', email: 'ba.nguyen@email.com', phone: '0907778888', role: 'Staff', status: 'Đang làm'),
    ]);

    // Reset Ingredients
    _ingredients.clear();
    _ingredients.addAll([
      Ingredient(name: 'Cà phê bột', quantity: 1000.0, unit: 'g'),
      Ingredient(name: 'Sữa tươi', quantity: 2000.0, unit: 'ml'),
      Ingredient(name: 'Đường', quantity: 1500.0, unit: 'g'),
      Ingredient(name: 'Sữa đặc', quantity: 1000.0, unit: 'g'),
      Ingredient(name: 'Ly giấy', quantity: 100.0, unit: 'cái'),
      Ingredient(name: 'Trà túi lọc', quantity: 50.0, unit: 'cái'),
      Ingredient(name: 'Đào ngâm', quantity: 100.0, unit: 'miếng'),
      Ingredient(name: 'Siro bạc hà', quantity: 500.0, unit: 'ml'),
      Ingredient(name: 'Việt quất mứt', quantity: 500.0, unit: 'g'),
      Ingredient(name: 'Bột matcha', quantity: 300.0, unit: 'g'),
    ]);

    notifyListeners();
  }

  // Get current quantity of an ingredient
  double getIngredientQuantity(String name) {
    try {
      return _ingredients.firstWhere((element) => element.name == name).quantity;
    } catch (_) {
      return 0.0;
    }
  }

  // Update ingredient quantity manually
  void updateIngredientQuantity(String name, double quantity) {
    final index = _ingredients.indexWhere((element) => element.name == name);
    if (index != -1) {
      _ingredients[index] = _ingredients[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  // Dynamic drink state calculation based on inventory
  String getDrinkState(Drink drink) {
    for (var entry in drink.recipe.entries) {
      final requiredQty = entry.value;
      final currentQty = getIngredientQuantity(entry.key);
      if (currentQty < requiredQty) {
        return 'Hết tạm thời';
      }
    }
    return 'Còn đồ';
  }

  // Employee CRUD operations
  String addEmployee(String name, String email, String phone, String role) {
    // Validate email
    if (!email.contains('@') || !email.substring(email.indexOf('@')).contains('.')) {
      return 'Email không hợp lệ (cần có @ và . ở phần tên miền)';
    }

    // Check duplicate
    final isDuplicate = _employees.any((element) => element.email.toLowerCase() == email.toLowerCase());
    if (isDuplicate) {
      return 'Email này đã được sử dụng bởi một nhân viên khác';
    }

    final newId = 'EMP${(_employees.length + 1).toString().padLeft(3, '0')}';
    _employees.add(Employee(
      id: newId,
      name: name,
      email: email,
      phone: phone,
      role: role,
      status: 'Đang làm',
    ));
    notifyListeners();
    return 'Success';
  }

  void updateEmployee(String id, String name, String phone, String role, String status) {
    final index = _employees.indexWhere((element) => element.id == id);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(
        name: name,
        phone: phone,
        role: role,
        status: status,
      );
      notifyListeners();
    }
  }

  void deleteEmployee(String id) {
    _employees.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void toggleEmployeeStatus(String id) {
    final index = _employees.indexWhere((element) => element.id == id);
    if (index != -1) {
      final currentStatus = _employees[index].status;
      _employees[index] = _employees[index].copyWith(
        status: currentStatus == 'Đang làm' ? 'Nghỉ việc' : 'Đang làm',
      );
      notifyListeners();
    }
  }

  // Login handler
  String login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return 'Vui lòng nhập email và mật khẩu';
    }

    try {
      final emp = _employees.firstWhere(
        (element) => element.email.toLowerCase() == email.toLowerCase(),
      );

      // Simple password check logic:
      // Manager default is admin123
      // Staff defaults are staff123
      // Special override for ba.nguyen@email.com: password123
      final expectedPassword = emp.email.toLowerCase() == 'ba.nguyen@email.com'
          ? 'password123'
          : (emp.role == 'Manager' ? 'admin123' : 'staff123');

      if (password != expectedPassword) {
        return 'Mật khẩu không đúng';
      }

      if (emp.status == 'Nghỉ việc') {
        return 'Tài khoản nhân viên này đang bị tạm ngưng/nghỉ việc';
      }

      _currentUser = emp;
      _activeTabIndex = 0;
      notifyListeners();
      return 'Success';
    } catch (_) {
      return 'Không tìm thấy tài khoản';
    }
  }

  void logout() {
    _currentUser = null;
    _cart.clear();
    _activeTabIndex = 0;
    notifyListeners();
  }

  // Cart operations
  int get cartTotalItems => _cart.values.fold(0, (sum, qty) => sum + qty);

  int get cartSubtotal {
    int sub = 0;
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      sub += d.cost * qty;
    });
    return sub;
  }

  int getVoucherDiscount(String? code, int sub) {
    if (code == null || code.trim().isEmpty) return 0;
    final formattedCode = code.trim().toUpperCase();
    if (formattedCode == 'ABC10') {
      return (sub * 0.1).round();
    }
    if (formattedCode == 'COFFEE20') {
      return sub > 20000 ? 20000 : sub;
    }
    return 0;
  }

  // Check if adding one more of a drink is allowed by inventory
  bool canAddDrink(Drink drink, {int quantityToAdd = 1}) {
    // 1. Enforce item quantity limit (Max 10 total items)
    if (cartTotalItems + quantityToAdd > 10) {
      return false;
    }

    // 2. Enforce ingredient availability
    final required = <String, double>{};

    // Calculate current cart recipe totals
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      d.recipe.forEach((ingName, amount) {
        required[ingName] = (required[ingName] ?? 0.0) + (amount * qty);
      });
    });

    // Add proposed recipe amounts
    drink.recipe.forEach((ingName, amount) {
      required[ingName] = (required[ingName] ?? 0.0) + (amount * quantityToAdd);
    });

    // Verify against inventory
    for (var entry in required.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      if (currentStock < entry.value) {
        return false;
      }
    }

    return true;
  }

  String addToCart(Drink drink) {
    // Check if ingredient is sufficient dynamically
    if (getDrinkState(drink) == 'Hết tạm thời') {
      return 'Món này đã hết nguyên liệu để chế biến';
    }

    if (cartTotalItems + 1 > 10) {
      return 'Đơn hàng tối đa chỉ được 10 món';
    }

    if (!canAddDrink(drink, quantityToAdd: 1)) {
      return 'Không đủ nguyên liệu tồn kho để làm thêm món này';
    }

    _cart[drink.name] = (_cart[drink.name] ?? 0) + 1;
    notifyListeners();
    return 'Success';
  }

  void updateCartQuantity(String drinkName, int newQty) {
    if (newQty <= 0) {
      _cart.remove(drinkName);
      notifyListeners();
      return;
    }

    final d = _drinks.firstWhere((e) => e.name == drinkName);
    final currentQty = _cart[drinkName] ?? 0;
    final diff = newQty - currentQty;

    if (diff > 0) {
      if (!canAddDrink(d, quantityToAdd: diff)) {
        return; // Silent fail or handles through check
      }
    }

    _cart[drinkName] = newQty;
    notifyListeners();
  }

  void removeFromCart(String drinkName) {
    _cart.remove(drinkName);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Checkout transaction
  String checkout({
    required String paymentMethod,
    String? voucherCode,
    required String status,
  }) {
    if (_cart.isEmpty) {
      return 'Giỏ hàng đang trống';
    }

    final sub = cartSubtotal;
    final disc = getVoucherDiscount(voucherCode, sub);
    final tot = sub - disc;

    // Build items list
    final List<OrderItem> orderItems = [];
    _cart.forEach((drinkName, qty) {
      final d = _drinks.firstWhere((e) => e.name == drinkName);
      orderItems.add(OrderItem(drink: d, quantity: qty));
    });

    // Verify ingredients one last time
    final requiredIngredients = <String, double>{};
    for (var item in orderItems) {
      item.drink.recipe.forEach((ingName, amount) {
        requiredIngredients[ingName] = (requiredIngredients[ingName] ?? 0.0) + (amount * item.quantity);
      });
    }

    for (var entry in requiredIngredients.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      if (currentStock < entry.value) {
        return 'Không đủ nguyên liệu ${entry.key} trong kho';
      }
    }

    // Deduct ingredients
    for (var entry in requiredIngredients.entries) {
      final currentStock = getIngredientQuantity(entry.key);
      updateIngredientQuantity(entry.key, currentStock - entry.value);
    }

    // Create the Order record
    final newOrder = Order(
      id: 'ORD${(_orders.length + 1).toString().padLeft(3, '0')}',
      items: orderItems,
      subtotal: sub,
      discount: disc,
      total: tot,
      paymentMethod: paymentMethod,
      voucherCode: voucherCode != null && voucherCode.trim().isNotEmpty ? voucherCode.trim().toUpperCase() : null,
      date: DateTime.now(),
      status: status,
      createdById: _currentUser?.id ?? 'SYSTEM',
      createdByName: _currentUser?.name ?? 'System',
    );

    _orders.add(newOrder);
    _cart.clear();
    notifyListeners();
    return 'Success';
  }

  // Update payment status for unpaid orders
  void payOrder(String orderId) {
    final index = _orders.indexWhere((element) => element.id == orderId);
    if (index != -1) {
      final old = _orders[index];
      _orders[index] = Order(
        id: old.id,
        items: old.items,
        subtotal: old.subtotal,
        discount: old.discount,
        total: old.total,
        paymentMethod: old.paymentMethod,
        voucherCode: old.voucherCode,
        date: old.date,
        status: 'Đã thanh toán',
        createdById: old.createdById,
        createdByName: old.createdByName,
      );
      notifyListeners();
    }
  }
}
