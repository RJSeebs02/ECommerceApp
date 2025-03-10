import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bangerlabz/pages/home.dart';
  
class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});
  
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}
  
class _ShoppingPageState extends State<ShoppingPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  
  // Dummy list of shopping items with categories and images.
  final List<Map<String, dynamic>> items = [
    {'name': 'Apple', 'category': 'Fruits', 'price': 1.99, 'rating': 4.5},
    {'name': 'Banana', 'category': 'Fruits', 'price': 2.99, 'rating': 4.2},
    {'name': 'Orange', 'category': 'Fruits', 'price': 3.99, 'rating': 4.7},
    {'name': 'Grapes', 'category': 'Fruits', 'price': 4.99, 'rating': 4.1},
    {'name': 'Mango', 'category': 'Fruits', 'price': 5.99, 'rating': 4.8},
    {'name': 'Pineapple', 'category': 'Fruits', 'price': 6.99, 'rating': 4.3},
    {'name': 'Strawberry', 'category': 'Berries', 'price': 7.99, 'rating': 4.6},
    {'name': 'Blueberry', 'category': 'Berries', 'price': 8.99, 'rating': 4.4},
    {'name': 'Watermelon', 'category': 'Fruits', 'price': 9.99, 'rating': 4.9},
  ];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) =>
      item['name'].toString().toLowerCase().contains(_searchController.text.toLowerCase())).toList();
  
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom Header with title.
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fresh Groceries',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF207008),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find the best quality products',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
  
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search fresh products...',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.green[400]),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list, color: Colors.green[400]),
                        onPressed: () {
                          // Add filter functionality
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
              ),
            ),
  
            // Categories
            SliverToBoxAdapter(
              child: Container(
                height: 60,
                margin: const EdgeInsets.only(top: 24),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildCategoryChip('All', true),
                    _buildCategoryChip('Fruits', false),
                    _buildCategoryChip('Vegetables', false),
                    _buildCategoryChip('Berries', false),
                    _buildCategoryChip('Nuts', false),
                  ],
                ),
              ),
            ),
  
            // Grid of products
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filteredItems[index];
                    return _buildProductCard(product);
                  },
                  childCount: filteredItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.green[800],
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          // Handle category selection
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF46C221),
        checkmarkColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.green.shade200,
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.eco,
                        size: 60,
                        color: Colors.green.shade300,
                      ),
                    ),
                  ),
                ),
                // Product Details
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name']?.toString() ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF207008),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['category']?.toString() ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber[400]),
                            const SizedBox(width: 4),
                            Text(
                              (product['rating']?.toString() ?? '0.0'),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${(product['price'] as num).toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF46C221),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  // Handle add to cart
                                },
                                constraints: const BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: const Color(0xFF46C221),
                ),
                onPressed: () {
                  // Handle favorite
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
