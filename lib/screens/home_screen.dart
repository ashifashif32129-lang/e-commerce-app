import 'package:e_commerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/product_controller.dart';
import '../data/category_data.dart';
import '../models/product_model.dart';

import 'category_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

import '../widgets/category_card.dart';
import '../widgets/product_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    final List<Widget> screens = const [
      HomeContent(),
      CategoryScreen(),
      CartScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];

    return Obx(
          () => Scaffold(
        backgroundColor: Colors.white,

        body: IndexedStack(
          index: homeController.selectedIndex.value,
          children: screens,
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeController.selectedIndex.value,
          onTap: homeController.changeTab,

          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,

          selectedItemColor: const Color(0xFF6938EF),
          unselectedItemColor: const Color(0xFF9AA1AE),

          selectedFontSize: 11,
          unselectedFontSize: 11,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// HOME CONTENT
// ============================================================

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final ProductController productController =
    Get.find<ProductController>();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Column(
                children: [

                  // ==================================================
                  // HEADER
                  // ==================================================

                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Shop',
                              style: TextStyle(
                                color: Color(0xFF07142D),
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'Ease',
                              style: TextStyle(
                                color: Color(0xFF6938EF),
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      _iconButton(
                        Icons.notifications_none_rounded,
                      ),

                      const SizedBox(width: 10),

                      _iconButton(
                        Icons.shopping_bag_outlined,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // ==================================================
                  // SEARCH
                  // ==================================================

                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: homeController.searchController,
                      onChanged: productController.searchProducts,
                      decoration: InputDecoration(
                        border: InputBorder.none,

                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF667085),
                        ),

                        hintText: 'Search products...',

                        hintStyle: const TextStyle(
                          color: Color(0xFF9AA1AE),
                          fontSize: 14,
                        ),

                        suffixIcon: Obx(
                              () {
                            if (productController
                                .searchText
                                .value
                                .isEmpty) {
                              return const SizedBox();
                            }

                            return IconButton(
                              onPressed: () {
                                homeController.clearSearch();
                                productController.clearSearch();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // BANNER
                  // ==================================================

                  Container(
                    height: 135,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6938EF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        const Positioned(
                          left: 18,
                          top: 22,
                          child: Text(
                            'New Season\nNew Styles',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 18,
                          bottom: 17,
                          child: GestureDetector(
                            onTap: () {
                              homeController.changeTab(1);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  color: Color(0xFF6938EF),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Positioned(
                          right: 20,
                          top: 35,
                          child: Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // CATEGORIES
                  // ==================================================

                  Row(
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          homeController.changeTab(1);
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF6938EF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: CategoryData.categories
                        .where((category) => category.id != 'all')
                        .take(4)
                        .map(
                          (category) => CategoryCard(
                        name: category.name,
                        icon: category.icon,
                        color: category.color,
                        onTap: () {
                          productController.selectCategory(category.id);
                          homeController.changeTab(1);
                        },
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // FLASH SALE
                  // ==================================================

                  Row(
                    children: [
                      const Text(
                        'Flash Sale',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          homeController.changeTab(1);
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF6938EF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ==========================================================
          // PRODUCTS
          // ==========================================================

          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: Obx(
                    () {
                  final List<ProductModel> products =
                  productController.filteredProducts
                      .take(4)
                      .toList();

                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return SizedBox(
                        width: 145,
                        child: ProductCard(
                          product: product,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  productName: product.name,
                                  price: '₹${product.price.toStringAsFixed(0)}',
                                  oldPrice: '₹${product.oldPrice.toStringAsFixed(0)}',
                                  category: product.categoryName,
                                  productIcon: product.icon,
                                  rating: product.rating,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ============================================================
  // ICON BUTTON
  // ============================================================

  Widget _iconButton(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 21,
        color: const Color(0xFF07142D),
      ),
    );
  }


}