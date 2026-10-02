import 'package:e_commerce_app/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../data/category_data.dart';
import '../models/product_model.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
    Get.find<ProductController>();

    return SafeArea(
      child: Column(
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              10,
            ),
            child: Row(
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF07142D),
                  ),
                ),

                const Spacer(),

                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF07142D),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // CATEGORIES
          // =====================================================

          SizedBox(
            height: 112,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              itemCount: CategoryData.categories.length,
              itemBuilder: (context, index) {
                final category =
                CategoryData.categories[index];

                return Obx(() {
                  final bool isSelected =
                      controller.selectedCategory.value ==
                          category.id;

                  return GestureDetector(
                    onTap: () {
                      controller.selectCategory(
                        category.id,
                      );
                    },
                    child: Container(
                      width: 78,
                      margin: const EdgeInsets.only(
                        right: 12,
                      ),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 250,
                            ),
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF6938EF)
                                  : category.color,
                              borderRadius:
                              BorderRadius.circular(18),
                            ),
                            child: Icon(
                              category.icon,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF6938EF),
                              size: 27,
                            ),
                          ),

                          const SizedBox(height: 7),

                          Text(
                            category.name,
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF6938EF)
                                  : const Color(0xFF667085),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          const SizedBox(height: 5),

          Container(
            height: 1,
            color: const Color(0xFFF0F0F3),
          ),

          // =====================================================
          // PRODUCTS
          // =====================================================

          Expanded(
            child: Obx(() {
              final products =
              controller.filteredProducts.toList();

              if (products.isEmpty) {
                return _emptyProducts();
              }

              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  20,
                ),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.72,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final ProductModel product =
                  products[index];

                  return _productCard(
                    context,
                    product,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // PRODUCT CARD
  // ===========================================================

  Widget _productCard(
      BuildContext context,
      ProductModel product,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
              productName: product.name,
              price:
              '₹${product.price.toStringAsFixed(0)}',
              oldPrice:
              '₹${product.oldPrice.toStringAsFixed(0)}',
              category: product.categoryName,
              productIcon: product.icon,
              rating: product.rating,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE8EAF0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.025,
              ),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            // IMAGE

            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        product.icon,
                        size: 72,
                        color:
                        const Color(0xFF6938EF),
                      ),
                    ),

                    if (product.discountPercentage > 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFF6938EF),
                            borderRadius:
                            BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // DETAILS

            Padding(
              padding: const EdgeInsets.fromLTRB(
                11,
                0,
                11,
                12,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.categoryName,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF8B93A3),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.name,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF07142D),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFF59E0B),
                      ),

                      const SizedBox(width: 3),

                      Text(
                        product.rating
                            .toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.w800,
                          color: Color(0xFF07142D),
                        ),
                      ),

                      const SizedBox(width: 6),

                      if (product.oldPrice > product.price)
                        Text(
                          '₹${product.oldPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF9AA1AE),
                            decoration:
                            TextDecoration
                                .lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // EMPTY
  // ===========================================================

  Widget _emptyProducts() {
    return const Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 55,
            color: Color(0xFFB4B8C2),
          ),
          SizedBox(height: 12),
          Text(
            'No Products Found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF07142D),
            ),
          ),
        ],
      ),
    );
  }
}