import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/employee.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRole = 'Staff';

  // For Editing
  Employee? _editingEmployee;
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editPhoneController = TextEditingController();
  String _editRole = 'Staff';
  String _editStatus = 'Đang làm';

  void _handleAddEmployee() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    final result = appState.addEmployee(name, email, phone, _selectedRole);

    if (result == 'Success') {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      setState(() {
        _selectedRole = 'Staff';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm nhân viên mới thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Lỗi xác thực'),
            ],
          ),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  void _showEditDialog(Employee emp) {
    setState(() {
      _editingEmployee = emp;
      _editNameController.text = emp.name;
      _editPhoneController.text = emp.phone!;
      _editRole = emp.role!;
      _editStatus = emp.status;
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text('Chỉnh sửa: ${emp.id}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _editNameController,
                      decoration: const InputDecoration(
                        labelText: 'Họ tên nhân viên',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _editPhoneController,
                      decoration: const InputDecoration(
                        labelText: 'Số điện thoại',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _editRole,
                      decoration: const InputDecoration(labelText: 'Vai trò'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Manager',
                          child: Text('Quản lý (Manager)'),
                        ),
                        DropdownMenuItem(
                          value: 'Staff',
                          child: Text('Nhân viên (Staff)'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            _editRole = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _editStatus,
                      decoration: const InputDecoration(
                        labelText: 'Trạng thái',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Đang làm',
                          child: Text('Đang làm (Active)'),
                        ),
                        DropdownMenuItem(
                          value: 'Nghỉ việc',
                          child: Text('Nghỉ việc (Inactive)'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            _editStatus = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  key: const ValueKey('dialog_save_btn'),
                  onPressed: () {
                    appState.updateEmployee(
                      emp.id,
                      _editNameController.text.trim(),
                      _editPhoneController.text.trim(),
                      _editRole,
                      _editStatus,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cập nhật thông tin nhân viên thành công!',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text(
                    'Lưu thay đổi',
                    style: TextStyle(color: Color(0xFF5D4037)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thêm Nhân Viên',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Tạo tài khoản nhân viên mới truy cập hệ thống',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width > 900 ? 20.0 : 12.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Name Field
                  TextFormField(
                    key: const ValueKey('staff_name_field'),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ và tên',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập họ tên nhân viên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    key: const ValueKey('staff_email_field'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'example@domain.com',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Phone Field
                  TextFormField(
                    key: const ValueKey('staff_phone_field'),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Role Field
                  DropdownButtonFormField<String>(
                    key: const ValueKey('staff_role_dropdown'),
                    isExpanded: true,
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Vai trò',
                      prefixIcon: Icon(Icons.shield_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Manager',
                        child: Text('Quản lý (Manager)'),
                      ),
                      DropdownMenuItem(
                        value: 'Staff',
                        child: Text('Nhân viên (Staff)'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedRole = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    key: const ValueKey('staff_submit_btn'),
                    onPressed: _handleAddEmployee,
                    child: const Text(
                      'THÊM MỚI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(
    List<Employee> employees, {
    required bool isScrollable,
  }) {
    final tableWidget = DataTable(
      columns: const [
        DataColumn(
          label: Text('Mã NV', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Họ tên', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Vai trò', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text(
            'Trạng thái',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Hành động',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: employees.map((emp) {
        final isActive = emp.status == 'Đang làm';
        return DataRow(
          cells: [
            DataCell(Text(emp.id)),
            DataCell(
              Text(
                emp.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            DataCell(Text(emp.email)),
            DataCell(Text(emp.role == 'Manager' ? 'Quản lý' : 'Nhân viên')),
            DataCell(
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
                child: Text(
                  emp.status,
                  style: TextStyle(
                    color: isActive
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataCell(
              Row(
                children: [
                  IconButton(
                    key: ValueKey('toggle_status_btn_${emp.id}'),
                    tooltip: isActive ? 'Tạm ngưng' : 'Kích hoạt',
                    icon: Icon(
                      isActive ? Icons.toggle_on : Icons.toggle_off,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      appState.toggleEmployeeStatus(emp.id);
                    },
                  ),
                  IconButton(
                    key: ValueKey('edit_staff_btn_${emp.id}'),
                    tooltip: 'Chỉnh sửa',
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () => _showEditDialog(emp),
                  ),
                  IconButton(
                    key: ValueKey('delete_staff_btn_${emp.id}'),
                    tooltip: 'Xóa',
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: emp.id == 'EMP001'
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Xác nhận xóa'),
                                content: Text(
                                  'Bạn có chắc chắn muốn xóa nhân viên ${emp.name}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Hủy'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      appState.deleteEmployee(emp.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Xóa',
                                      style: TextStyle(color: Colors.red),
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
          ],
        );
      }).toList(),
    );

    final cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: isScrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tableWidget,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tableWidget,
            ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh Sách Nhân Viên (${employees.length})',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        const Text(
          'Kéo chuột hoặc vuốt ngang để xem thêm: Vai trò, Trạng thái, Hành động',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16),
        isScrollable
            ? Expanded(child: Card(child: cardContent))
            : Card(child: cardContent),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final employees = appState.employees;

        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F6),
          body: isDesktop
              ? Row(
                  children: [
                    // Left Form side (35% width on desktop)
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildFormSection(),
                      ),
                    ),
                    // Right Listing side (65% width on desktop)
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 24,
                          right: 24,
                        ),
                        child: _buildListSection(employees, isScrollable: true),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildFormSection(),
                      const SizedBox(height: 24),
                      _buildListSection(employees, isScrollable: false),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/models/employee.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedRole = 'Staff';

  // For Editing
  Employee? _editingEmployee;
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editPhoneController = TextEditingController();
  String _editRole = 'Staff';
  String _editStatus = 'Đang làm';

  void _handleAddEmployee() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    final result = appState.addEmployee(name, email, phone, _selectedRole);

    if (result == 'Success') {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      setState(() {
        _selectedRole = 'Staff';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thêm nhân viên mới thành công!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Lỗi xác thực'),
            ],
          ),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    }
  }

  void _showEditDialog(Employee emp) {
    setState(() {
      _editingEmployee = emp;
      _editNameController.text = emp.name;
      _editPhoneController.text = emp.phone;
      _editRole = emp.role;
      _editStatus = emp.status;
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('Chỉnh sửa: ${emp.id}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _editNameController,
                      decoration: const InputDecoration(labelText: 'Họ tên nhân viên'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _editPhoneController,
                      decoration: const InputDecoration(labelText: 'Số điện thoại'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _editRole,
                      decoration: const InputDecoration(labelText: 'Vai trò'),
                      items: const [
                        DropdownMenuItem(value: 'Manager', child: Text('Quản lý (Manager)')),
                        DropdownMenuItem(value: 'Staff', child: Text('Nhân viên (Staff)')),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            _editRole = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _editStatus,
                      decoration: const InputDecoration(labelText: 'Trạng thái'),
                      items: const [
                        DropdownMenuItem(value: 'Đang làm', child: Text('Đang làm (Active)')),
                        DropdownMenuItem(value: 'Nghỉ việc', child: Text('Nghỉ việc (Inactive)')),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            _editStatus = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  key: const ValueKey('dialog_save_btn'),
                  onPressed: () {
                    appState.updateEmployee(
                      emp.id,
                      _editNameController.text.trim(),
                      _editPhoneController.text.trim(),
                      _editRole,
                      _editStatus,
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cập nhật thông tin nhân viên thành công!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Lưu thay đổi', style: TextStyle(color: Color(0xFF5D4037))),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Thêm Nhân Viên',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          'Tạo tài khoản nhân viên mới truy cập hệ thống',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width > 900 ? 20.0 : 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Name Field
                  TextFormField(
                    key: const ValueKey('staff_name_field'),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ và tên',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập họ tên nhân viên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Email Field
                  TextFormField(
                    key: const ValueKey('staff_email_field'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'example@domain.com',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Phone Field
                  TextFormField(
                    key: const ValueKey('staff_phone_field'),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Role Field
                  DropdownButtonFormField<String>(
                    key: const ValueKey('staff_role_dropdown'),
                    isExpanded: true,
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Vai trò',
                      prefixIcon: Icon(Icons.shield_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Manager', child: Text('Quản lý (Manager)')),
                      DropdownMenuItem(value: 'Staff', child: Text('Nhân viên (Staff)')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedRole = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    key: const ValueKey('staff_submit_btn'),
                    onPressed: _handleAddEmployee,
                    child: const Text('THÊM MỚI', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(List<Employee> employees, {required bool isScrollable}) {
    final tableWidget = DataTable(
      columns: const [
        DataColumn(label: Text('Mã NV', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Họ tên', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Vai trò', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Trạng thái', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Hành động', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: employees.map((emp) {
        final isActive = emp.status == 'Đang làm';
        return DataRow(
          cells: [
            DataCell(Text(emp.id)),
            DataCell(Text(emp.name, style: const TextStyle(fontWeight: FontWeight.w600))),
            DataCell(Text(emp.email)),
            DataCell(Text(emp.role == 'Manager' ? 'Quản lý' : 'Nhân viên')),
            DataCell(
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: isActive ? Colors.green : Colors.red),
                ),
                child: Text(
                  emp.status,
                  style: TextStyle(
                    color: isActive ? Colors.green.shade800 : Colors.red.shade800,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DataCell(
              Row(
                children: [
                  IconButton(
                    key: ValueKey('toggle_status_btn_${emp.id}'),
                    tooltip: isActive ? 'Tạm ngưng' : 'Kích hoạt',
                    icon: Icon(
                      isActive ? Icons.toggle_on : Icons.toggle_off,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      appState.toggleEmployeeStatus(emp.id);
                    },
                  ),
                  IconButton(
                    key: ValueKey('edit_staff_btn_${emp.id}'),
                    tooltip: 'Chỉnh sửa',
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () => _showEditDialog(emp),
                  ),
                  IconButton(
                    key: ValueKey('delete_staff_btn_${emp.id}'),
                    tooltip: 'Xóa',
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: emp.id == 'EMP001'
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Xác nhận xóa'),
                                content: Text('Bạn có chắc chắn muốn xóa nhân viên ${emp.name}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Hủy'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      appState.deleteEmployee(emp.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );

    final cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: isScrollable
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: tableWidget,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tableWidget,
            ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh Sách Nhân Viên (${employees.length})',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        const Text(
          'Kéo chuột hoặc vuốt ngang để xem thêm: Vai trò, Trạng thái, Hành động',
          style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        isScrollable
            ? Expanded(
                child: Card(
                  child: cardContent,
                ),
              )
            : Card(
                child: cardContent,
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 900;
        final employees = appState.employees;

        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F6),
          body: isDesktop
              ? Row(
                  children: [
                    // Left Form side (35% width on desktop)
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildFormSection(),
                      ),
                    ),
                    // Right Listing side (65% width on desktop)
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 24, right: 24),
                        child: _buildListSection(employees, isScrollable: true),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildFormSection(),
                      const SizedBox(height: 24),
                      _buildListSection(employees, isScrollable: false),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
