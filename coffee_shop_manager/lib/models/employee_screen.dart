import 'package:flutter/material.dart';
import '../models/employee.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  // Mock data ban đầu
  List<Employee> employees = [
    Employee(id: 'EMP002', name: 'Nguyễn Văn B', email: 'b@gmail.com', status: 'Đang làm'),
    Employee(id: 'EMP003', name: 'Trần Thị C', email: 'c@gmail.com', status: 'Nghỉ việc'),
  ];

  String currentRole = 'Admin001'; 

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); 

  void showAlert(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool checkAccess() {
    if (currentRole == 'Admin001') return true;
    showAlert('Từ chối truy cập: Bạn không phải quản lý!');
    return false;
  }

  void handleAddEmployee() {
    if (!checkAccess()) return;

    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();

      if (employees.any((e) => e.email.toLowerCase() == email.toLowerCase())) {
        showAlert('Lỗi: Email này đã tồn tại trong hệ thống!');
        return;
      }

      String newId = 'EMP${DateTime.now().millisecondsSinceEpoch.toString().substring(10)}';

      setState(() {
        employees.add(Employee(
          id: newId,
          name: name,
          email: email,
          status: 'Đang làm',
        ));
      });

      showAlert('Thêm nhân viên thành công!', isSuccess: true);

      _nameController.clear();
      _emailController.clear();
    }
  }

  void toggleStatus(Employee emp) {
    if (!checkAccess()) return;
    setState(() {
      emp.status = (emp.status == 'Đang làm') ? 'Nghỉ việc' : 'Đang làm';
    });
    showAlert('Cập nhật trạng thái thành công!', isSuccess: true);
  }

  void deleteEmployee(String id) {
    if (!checkAccess()) return;
    setState(() {
      employees.removeWhere((e) => e.id == id);
    });
    showAlert('Xóa thành công!', isSuccess: true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý nhân viên')),
      body: Column(
        children: [
          // 1. Thanh phân quyền giả lập
          Card(
            color: Colors.blueGrey[50],
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tài khoản: $currentRole', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() => currentRole = 'Admin001'),
                        child: const Text('Quyền Quản lý (Admin)'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => setState(() => currentRole = 'Staff001'),
                        child: const Text('Quyền Nhân viên (Staff)'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          // 2. FORM NHẬP LIỆU THÊM NHÂN VIÊN MỚI
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thêm nhân viên mới', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Ô nhập tên nhân viên
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Họ và tên',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Vui lòng nhập tên';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Ô nhập Email
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) return 'Vui lòng nhập email';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) return 'Email không hợp lệ';
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Nút xác nhận Thêm
                        ElevatedButton.icon(
                          onPressed: handleAddEmployee,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[800],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Thêm ngay'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
          const Text('Danh sách nhân sự hệ thống', style: TextStyle(color: Colors.grey)),

          // 3. Danh sách hiển thị nhân viên
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final emp = employees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text('${emp.name} (${emp.id})', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Email: ${emp.email} | Trạng thái: ${emp.status}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.swap_horiz, color: Colors.blue),
                          onPressed: () => toggleStatus(emp),
                          tooltip: 'Đổi trạng thái làm việc/nghỉ việc',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => deleteEmployee(emp.id),
                          tooltip: 'Xóa khỏi hệ thống',
                        ),
                      ],
                    ),
                    onTap: () {
                      if (emp.status == 'Nghỉ việc') {
                        showAlert('Nhân viên đã nghỉ việc, không thể thực hiện thao tác nghiệp vụ!');
                      } else {
                        showAlert('Nhân viên đang hoạt động bình thường.', isSuccess: true);
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}