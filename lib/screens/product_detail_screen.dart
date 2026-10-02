import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String oldPrice;
  final String category;
  final IconData productIcon;
  final double rating;

  const ProductDetailsScreen({
    super.key,
    this.productName = 'Wireless Earbuds',
    this.price = '₹2,999',
    this.oldPrice = '₹4,999',
    this.category = 'Electronics',
    this.productIcon = Icons.headphones,
    this.rating = 4.8,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  bool isFavorite = false;
  int quantity = 1;
  int selectedColor = 0;
  int selectedSize = 0;

  final List<Color> colors = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.purple,
  ];

  final List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
  ];

  double get priceValue {
    return double.tryParse(
      widget.price
          .replaceAll('₹', '')
          .replaceAll(',', ''),
    ) ??
        0;
  }

  void addProductToCart() {
    final CartController cartController =
    Get.find<CartController>();

    cartController.addToCart(
      name: widget.productName,
      price: priceValue,
      icon: widget.productIcon,
      quantity: quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF07142D),
            size: 20,
          ),
        ),

        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Color(0xFF07142D),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              addProductToCart();

              Get.snackbar(
                'Added to Cart',
                '${widget.productName} added successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor:
                const Color(0xFF6938EF),
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF07142D),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                5,
                20,
                20,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  // Product Image
                  Stack(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F3FA),
                          borderRadius:
                          BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Icon(
                            widget.productIcon,
                            size: 150,
                            color:
                            const Color(0xFF6938EF),
                          ),
                        ),
                      ),

                      // Sale Badge
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color:
                            const Color(0xFF6938EF),
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'SALE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Favorite
                      Positioned(
                        top: 14,
                        right: 14,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite =
                              !isFavorite;
                            });
                          },
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration:
                            BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(
                                    alpha: 0.08,
                                  ),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons
                                  .favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : const Color(
                                0xFF07142D,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Category
                  Text(
                    widget.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF6938EF),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Product Name
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      color: Color(0xFF07142D),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rating
                  Row(
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFFFB800),
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        '128 Reviews',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: const TextStyle(
                          color: Color(0xFF07142D),
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Text(
                        widget.oldPrice,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          decoration:
                          TextDecoration.lineThrough,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFF1EDFF),
                          borderRadius:
                          BorderRadius.circular(7),
                        ),
                        child: const Text(
                          '40% OFF',
                          style: TextStyle(
                            color:
                            Color(0xFF6938EF),
                            fontSize: 11,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xFF07142D),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Experience premium quality and modern design. '
                        'This product is designed for everyday use with '
                        'excellent performance, comfort and durability.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Color
                  const Text(
                    'Color',
                    style: TextStyle(
                      color: Color(0xFF07142D),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: List.generate(
                      colors.length,
                          (index) {
                        final selected =
                            selectedColor == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor =
                                  index;
                            });
                          },
                          child: Container(
                            margin:
                            const EdgeInsets.only(
                              right: 12,
                            ),
                            padding:
                            const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected
                                    ? const Color(
                                  0xFF6938EF,
                                )
                                    : Colors
                                    .transparent,
                                width: 2,
                              ),
                            ),
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration:
                              BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                  Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Size
                  const Text(
                    'Size',
                    style: TextStyle(
                      color: Color(0xFF07142D),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: List.generate(
                      sizes.length,
                          (index) {
                        final selected =
                            selectedSize == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize =
                                  index;
                            });
                          },
                          child: Container(
                            margin:
                            const EdgeInsets.only(
                              right: 10,
                            ),
                            height: 42,
                            width: 48,
                            alignment:
                            Alignment.center,
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(
                                0xFF6938EF,
                              )
                                  : Colors.white,
                              borderRadius:
                              BorderRadius.circular(
                                10,
                              ),
                              border: Border.all(
                                color: selected
                                    ? const Color(
                                  0xFF6938EF,
                                )
                                    : Colors
                                    .grey.shade300,
                              ),
                            ),
                            child: Text(
                              sizes[index],
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : const Color(
                                  0xFF07142D,
                                ),
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Quantity
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          color: Color(0xFF07142D),
                          fontSize: 17,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFF5F3FA),
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),

                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.08,
                  ),
                  blurRadius: 15,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [

                // Cart Icon
                Container(
                  height: 54,
                  width: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EDFF),
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    onPressed: () {
                      addProductToCart();

                      Get.snackbar(
                        'Added to Cart',
                        '${widget.productName} added successfully',
                        snackPosition:
                        SnackPosition.BOTTOM,
                        backgroundColor:
                        const Color(0xFF6938EF),
                        colorText: Colors.white,
                        margin:
                        const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.bagShopping,
                      color:
                      Color(0xFF6938EF),
                      size: 20,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Add To Cart
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        addProductToCart();

                        Get.snackbar(
                          'Added to Cart',
                          '${widget.productName} added successfully',
                          snackPosition:
                          SnackPosition.BOTTOM,
                          backgroundColor:
                          const Color(0xFF6938EF),
                          colorText: Colors.white,
                          margin:
                          const EdgeInsets.all(16),
                          borderRadius: 12,
                        );
                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFF6938EF),
                        foregroundColor:
                        Colors.white,
                        elevation: 0,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Buy Now
                SizedBox(
                  height: 54,
                  width: 110,
                  child: ElevatedButton(
                    onPressed: () {
                      addProductToCart();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const CheckoutScreen(),
                        ),
                      );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF07142D),
                      foregroundColor:
                      Colors.white,
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}