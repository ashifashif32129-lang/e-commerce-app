import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller =
    Get.find<CartController>();

    return SafeArea(
      child: Obx(
            () => Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                18,
                20,
                15,
              ),
              child: Row(
                children: [
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF07142D),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${controller.itemCount}',
                      style: const TextStyle(
                        color: Color(0xFF6938EF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
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
                      Icons.more_horiz_rounded,
                      color: Color(0xFF07142D),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // CART ITEMS
            // =====================================================

            Expanded(
              child: controller.isEmpty
                  ? _emptyCart(context)
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  20,
                ),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item =
                  controller.cartItems[index];

                  return _cartItem(
                    controller,
                    index,
                    item,
                  );
                },
              ),
            ),

            // =====================================================
            // BOTTOM SUMMARY
            // =====================================================

            if (!controller.isEmpty)
              Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.06,
                      ),
                      blurRadius: 15,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _summaryRow(
                      'Subtotal',
                      '₹${controller.subtotal.toStringAsFixed(0)}',
                    ),

                    const SizedBox(height: 10),

                    _summaryRow(
                      'Delivery Fee',
                      controller.deliveryFee == 0
                          ? 'FREE'
                          : '₹${controller.deliveryFee.toStringAsFixed(0)}',
                      valueColor:
                      controller.deliveryFee == 0
                          ? const Color(0xFF16A34A)
                          : null,
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: Divider(
                        color: Color(0xFFEDEDF1),
                      ),
                    ),

                    _summaryRow(
                      'Total',
                      '₹${controller.total.toStringAsFixed(0)}',
                      valueColor:
                      const Color(0xFF6938EF),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const CheckoutScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF6938EF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text(
                              '₹${controller.total.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(width: 5),

                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
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
  // CART ITEM
  // ===========================================================

  Widget _cartItem(
      CartController controller,
      int index,
      Map<String, dynamic> item,
      ) {
    final double price = item['price'] as double;
    final int quantity = item['quantity'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFEDEDF1),
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
      child: Row(
        children: [
          // =====================================================
          // PRODUCT IMAGE
          // =====================================================

          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              item['icon'] as IconData,
              size: 42,
              color: const Color(0xFF6938EF),
            ),
          ),

          const SizedBox(width: 12),

          // =====================================================
          // PRODUCT DETAILS
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['name'] as String,
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF07142D),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        controller.removeFromCart(index);
                      },
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 20,
                        color: Color(0xFF9AA1AE),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6938EF),
                  ),
                ),

                const SizedBox(height: 10),

                // =================================================
                // QUANTITY
                // =================================================

                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        controller.decreaseQuantity(
                          index,
                        );
                      },
                    ),

                    SizedBox(
                      width: 35,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    _quantityButton(
                      icon: Icons.add,
                      onTap: () {
                        controller.increaseQuantity(
                          index,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // QUANTITY BUTTON
  // ===========================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF1EDFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: const Color(0xFF6938EF),
        ),
      ),
    );
  }

  // ===========================================================
  // EMPTY CART
  // ===========================================================

  Widget _emptyCart(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDFF),
                borderRadius:
                BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 48,
                color: Color(0xFF6938EF),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF07142D),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Add some products to your cart',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF667085),
              ),
            ),

            const SizedBox(height: 22),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF6938EF),
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continue Shopping',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // SUMMARY ROW
  // ===========================================================

  Widget _summaryRow(
      String title,
      String value, {
        Color? valueColor,
      }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF667085),
            ),
          ),
        ),

        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color:
            valueColor ??
                const Color(0xFF07142D),
          ),
        ),
      ],
    );
  }
}