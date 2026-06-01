class Ingredient {
  final String name;
  final double quantity;
  final String unit; // 'g', 'ml', 'cái', etc.

  Ingredient({required this.name, required this.quantity, required this.unit});

  Ingredient copyWith({String? name, double? quantity, String? unit}) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
class Ingredient {
  final String name;
  final double quantity;
  final String unit; // 'g', 'ml', 'cái', etc.

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Ingredient copyWith({
    String? name,
    double? quantity,
    String? unit,
  }) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
