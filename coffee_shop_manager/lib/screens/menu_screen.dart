import 'package:flutter/material.dart';
import 'package:coffee_shop_manager/main.dart';
import 'package:coffee_shop_manager/screens/order_cart_panel.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.cost});

  final int cost;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Tất cả';
  String _selectedPriceRange = 'Tất cả';
  String _searchQuery = '';

  final List<String> _categories = [
    'Tất cả',
    'Cà phê',
    'Trà',
    'Trà sữa',
    'Sinh tố',
    'Đá xay',
  ];
  final List<String> _priceRanges = [
    'Tất cả',
    'Dưới 50k',
    '50k - 80k',
    'Trên 80k',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final isDesktop = size.width > 1000;

        // Filter logic
        final filteredDrinks = appState.drinks.where((drink) {
          // 1. Search Query (case-insensitive)
          final matchesSearch = drink.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

          // 2. Category
          final matchesCategory =
              _selectedCategory == 'Tất cả' || drink.type == _selectedCategory;

          // 3. Price Range
          bool matchesPrice = true;
          if (_selectedPriceRange == 'Dưới 50k') {
            matchesPrice = drink.cost < 50000;
          } else if (_selectedPriceRange == '50k - 80k') {
            matchesPrice = drink.cost >= 50000 && drink.cost <= 80000;
          } else if (_selectedPriceRange == 'Trên 80k') {
            matchesPrice = drink.cost > 80000;
          }

          return matchesSearch && matchesCategory && matchesPrice;
        }).toList();

        // Responsive structure
        return Scaffold(
          backgroundColor: const Color(0xFFFBF8F6),
          body: Row(
            children: [
              // Left portion: Menu Grid
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(isDesktop ? 24.0 : 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Search Row
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          Text(
                            'Menu Đồ Uống',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          // Search field
                          SizedBox(
                            width: 300,
                            child: TextField(
                              key: const ValueKey('search_drink_field'),
                              controller: _searchController,
                              onChanged: (val) {
                                setState(() {
                                  _searchQuery = val;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Tìm tên đồ uống...',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xFF8D6E63),
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Color(0xFF8D6E63),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _searchController.clear();
                                            _searchQuery = '';
                                          });
                                        },
                                      )
                                    : null,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Category Filter Chips Row
                      const Text(
                        'Phân loại loại đồ uống:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                key: ValueKey('category_chip_$category'),
                                label: Text(category),
                                selected: isSelected,
                                selectedColor: const Color(0xFF5D4037),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF5D4037),
                                ),
                                backgroundColor: Colors.white,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedCategory = category;
                                    });
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price Filter Chips Row
                      const Text(
                        'Mức giá:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D4037),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _priceRanges.map((range) {
                          final isSelected = _selectedPriceRange == range;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ChoiceChip(
                              key: ValueKey('price_chip_$range'),
                              label: Text(range),
                              selected: isSelected,
                              selectedColor: const Color(0xFF8D6E63),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF8D6E63),
                              ),
                              backgroundColor: Colors.white,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedPriceRange = range;
                                  });
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Drinks Grid View
                      Expanded(
                        child: filteredDrinks.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.sentiment_dissatisfied,
                                      size: 60,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Không tìm thấy món đồ uống nào phù hợp!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isDesktop
                                          ? 3
                                          : (size.width > 600 ? 3 : 2),
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: isDesktop
                                          ? 0.65
                                          : (size.width > 600
                                                ? 0.7
                                                : (size.width < 360
                                                      ? 0.56
                                                      : 0.62)),
                                    ),
                                itemCount: filteredDrinks.length,
                                itemBuilder: (context, index) {
                                  final drink = filteredDrinks[index];
                                  final state = appState.getDrinkState(drink);
                                  final isOutOfStock = state == 'Hết tạm thời';

                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: isOutOfStock
                                            ? Border.all(
                                                color: Colors.red.shade100,
                                                width: 1.5,
                                              )
                                            : null,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // Image / Icon Placeholder Banner
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              color: isOutOfStock
                                                  ? Colors.grey.shade200
                                                  : const Color(0xFFFAF5EF),
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Icon(
                                                      Icons.local_cafe,
                                                      size: 50,
                                                      color: isOutOfStock
                                                          ? Colors.grey.shade400
                                                          : const Color(
                                                              0xFF8D6E63,
                                                            ),
                                                    ),
                                                  ),
                                                  // Price tag
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 6,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFF5D4037,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        '${drink.cost ~/ 1000}k',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Category Tag
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.9),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        drink.type,
                                                        style: const TextStyle(
                                                          color: Color(
                                                            0xFF5D4037,
                                                          ),
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Content Info
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                12.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    drink.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color(0xFF3E2723),
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 6),
                                                  // Stock label
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  isOutOfStock
                                                                  ? Colors.red
                                                                  : Colors
                                                                        .green,
                                                            ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        state,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isOutOfStock
                                                              ? Colors
                                                                    .red
                                                                    .shade700
                                                              : Colors
                                                                    .green
                                                                    .shade700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  // Order trigger button
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      key: ValueKey(
                                                        'order_btn_${drink.name}',
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            isOutOfStock
                                                            ? Colors
                                                                  .grey
                                                                  .shade300
                                                            : const Color(
                                                                0xFF5D4037,
                                                              ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 8,
                                                            ),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                      ),
                                                      onPressed: isOutOfStock
                                                          ? null
                                                          : () {
                                                              final res =
                                                                  appState
                                                                      .addToCart(
                                                                        drink,
                                                                      );
                                                              if (res !=
                                                                  'Success') {
                                                                ScaffoldMessenger.of(
                                                                  context,
                                                                ).showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                          res,
                                                                        ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                );
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                  context,
                                                                ).showSnackBar(
                                                                  SnackBar(
                                                                    content: Text(
                                                                      'Đã thêm ${drink.name} vào đơn hàng',
                                                                    ),
                                                                    duration:
                                                                        const Duration(
                                                                          seconds:
                                                                              1,
                                                                        ),
                                                                    backgroundColor:
                                                                        const Color(
                                                                          0xFF8D6E63,
                                                                        ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                      child: Text(
                                                        isOutOfStock
                                                            ? 'Hết hàng'
                                                            : 'Gọi món',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right portion: Order Cart Drawer for Desktop (Visible on Desktop Menu Tab)
              if (isDesktop)
                Expanded(flex: 4, child: OrderCartPanel(isHistoryOnly: false)),
            ],
          ),
          // Floating cart button for mobile screens
          floatingActionButton: !isDesktop
              ? FloatingActionButton.extended(
                  key: const ValueKey('mobile_cart_fab'),
                  backgroundColor: const Color(0xFF5D4037),
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  label: Text(
                    'Đơn hàng (${appState.cartTotalItems})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Show slide up sheet for Cart
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.85,
                        maxChildSize: 0.95,
                        minChildSize: 0.5,
                        expand: false,
                        builder: (context, scrollController) =>
                            const OrderCartPanel(isHistoryOnly: false),
                      ),
                    );
                  },
                )
              : null,
        );
      },
    );
  }
}
