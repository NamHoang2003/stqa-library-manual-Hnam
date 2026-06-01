class Drink {
  final String name;
  final int cost;
  final String state; // 'Còn' or 'Hết' or 'Còn đồ'
  final String currency;
  final String type; // 'Cà phê', 'Trà sữa', 'Sinh tố', 'Đồ uống lạnh'
  final Map<String, double>
  recipe; // e.g. {'Cà phê hạt/bột': 15.0, 'Ly giấy': 1.0}

  Drink(
    this.name,
    this.cost,
    this.state,
    this.currency, {
    this.type = 'Cà phê',
    this.recipe = const {},
  });
}
class Drink {
  final String name;
  final int cost;
  final String state; // 'Còn' or 'Hết' or 'Còn đồ'
  final String currency;
  final String type; // 'Cà phê', 'Trà sữa', 'Sinh tố', 'Đồ uống lạnh'
  final Map<String, double> recipe; // e.g. {'Cà phê hạt/bột': 15.0, 'Ly giấy': 1.0}

  Drink(
    this.name,
    this.cost,
    this.state,
    this.currency, {
    this.type = 'Cà phê',
    this.recipe = const {},
  });
}
