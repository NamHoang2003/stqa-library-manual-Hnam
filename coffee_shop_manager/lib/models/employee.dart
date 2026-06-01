class Employee {
  String id;
  String name;
  String email;
  String? phone;
  String? role;
  String status; // 'Đang làm' hoặc 'Nghỉ việc

  Employee({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    required this.status,
  });
  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? status,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}
class Employee {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // 'Manager' or 'Staff'
  final String status; // 'Đang làm' or 'Nghỉ việc'

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? status,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}
