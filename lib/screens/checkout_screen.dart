import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {
  int selectedPayment = 0;
  int selectedDelivery = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'title': 'UPI',
      'subtitle': 'Google Pay, PhonePe, Paytm',
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard, RuPay',
      'icon': Icons.credit_card_outlined,
    },
    {
      'title': 'Cash on Delivery',
      'subtitle': 'Pay when your order arrives',
      'icon': Icons.payments_outlined,
    },
  ];

  final List<Map<String, dynamic>> deliveryOptions = [
    {
      'title': 'Standard Delivery',
      'subtitle': '3 - 5 business days',
      'price': 'FREE',
      'fee': 0.0,
    },
    {
      'title': 'Express Delivery',
      'subtitle': '1 - 2 business days',
      'price': '₹99',
      'fee': 99.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final CartController cartController =
    Get.find<CartController>();

    return Obx(() {
      final double subtotal =
          cartController.subtotal;

      final double deliveryFee =
      deliveryOptions[selectedDelivery]['fee']
      as double;

      final double total =
          subtotal + deliveryFee;

      return Scaffold(
        backgroundColor: const Color(0xFFF8F8FA),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0xFF07142D),
            ),
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: Color(0xFF07142D),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            130,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                Icons.location_on_outlined,
                'Delivery Address',
              ),

              const SizedBox(height: 10),

              _addressCard(),

              const SizedBox(height: 24),

              _sectionTitle(
                Icons.local_shipping_outlined,
                'Delivery Option',
              ),

              const SizedBox(height: 10),

              ...List.generate(
                deliveryOptions.length,
                    (index) {
                  return _deliveryCard(
                    index,
                    deliveryOptions[index],
                  );
                },
              ),

              const SizedBox(height: 24),

              _sectionTitle(
                Icons.payment_rounded,
                'Payment Method',
              ),

              const SizedBox(height: 10),

              ...List.generate(
                paymentMethods.length,
                    (index) {
                  return _paymentCard(
                    index,
                    paymentMethods[index],
                  );
                },
              ),

              const SizedBox(height: 24),

              _sectionTitle(
                Icons.shopping_bag_outlined,
                'Order Items',
              ),

              const SizedBox(height: 10),

              ...cartController.cartItems.map(
                    (item) => _orderItem(item),
              ),

              const SizedBox(height: 24),

              _sectionTitle(
                Icons.receipt_long_outlined,
                'Order Summary',
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(17),
                  border: Border.all(
                    color: const Color(0xFFE8EAF0),
                  ),
                ),
                child: Column(
                  children: [
                    _summaryRow(
                      'Subtotal',
                      '₹${subtotal.toStringAsFixed(0)}',
                    ),
                    const SizedBox(height: 12),
                    _summaryRow(
                      'Delivery Fee',
                      deliveryFee == 0
                          ? 'FREE'
                          : '₹${deliveryFee.toStringAsFixed(0)}',
                      valueColor: deliveryFee == 0
                          ? const Color(0xFF16A34A)
                          : null,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      child: Divider(
                        color: Color(0xFFEDEDF1),
                      ),
                    ),
                    _summaryRow(
                      'Total',
                      '₹${total.toStringAsFixed(0)}',
                      valueColor:
                      const Color(0xFF6938EF),
                      bold: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            18,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: cartController.isEmpty
                  ? null
                  : () {
                _placeOrder(
                  cartController,
                  subtotal,
                  deliveryFee,
                  total,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF6938EF),
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                const Color(0xFFD8D8DE),
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
                    'Place Order',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₹${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // ===========================================================
  // PLACE ORDER
  // ===========================================================

  void _placeOrder(
      CartController cartController,
      double subtotal,
      double deliveryFee,
      double total,
      ) {
    final OrderController orderController =
    Get.find<OrderController>();

    final List<Map<String, dynamic>> items =
    cartController.cartItems
        .map(
          (item) => Map<String, dynamic>.from(item),
    )
        .toList();

    orderController.addOrder(
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
    );

    cartController.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFFE9F9EF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF16A34A),
                  size: 42,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF07142D),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Your order of ₹${total.toStringAsFixed(0)} '
                    'has been placed successfully.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8B93A3),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(0xFF6938EF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================
  // ADDRESS
  // ===========================================================

  Widget _addressCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE8EAF0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF1EDFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.home_outlined,
              color: Color(0xFF6938EF),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF07142D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your delivery address',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8B93A3),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Color(0xFF8B93A3),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // DELIVERY CARD
  // ===========================================================

  Widget _deliveryCard(
      int index,
      Map<String, dynamic> option,
      ) {
    final bool selected =
        selectedDelivery == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDelivery = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? const Color(0xFF6938EF)
                : const Color(0xFFE8EAF0),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFF6938EF)
                  : const Color(0xFFB4B8C2),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    option['title'].toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF07142D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option['subtitle'].toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8B93A3),
                    ),
                  ),
                ],
              ),
            ),

            Text(
              option['price'].toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: option['price'] == 'FREE'
                    ? const Color(0xFF16A34A)
                    : const Color(0xFF07142D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // PAYMENT CARD
  // ===========================================================

  Widget _paymentCard(
      int index,
      Map<String, dynamic> method,
      ) {
    final bool selected =
        selectedPayment == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? const Color(0xFF6938EF)
                : const Color(0xFFE8EAF0),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EDFF),
                borderRadius:
                BorderRadius.circular(11),
              ),
              child: Icon(
                method['icon'] as IconData,
                color: const Color(0xFF6938EF),
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    method['title'].toString(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF07142D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    method['subtitle'].toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8B93A3),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xFF6938EF)
                  : const Color(0xFFB4B8C2),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // ORDER ITEM
  // ===========================================================

  Widget _orderItem(
      Map<String, dynamic> item,
      ) {
    final String name =
        item['name']?.toString() ??
            'Product';

    final double price =
        (item['price'] as num?)?.toDouble() ??
            0;

    final int quantity =
    item['quantity'] is int
        ? item['quantity'] as int
        : int.tryParse(
      item['quantity']
          .toString(),
    ) ??
        1;

    final IconData icon =
    item['icon'] is IconData
        ? item['icon'] as IconData
        : Icons.shopping_bag_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE8EAF0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6938EF),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
                Text(
                  'Qty: $quantity',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8B93A3),
                  ),
                ),
              ],
            ),
          ),

          Text(
            '₹${(price * quantity).toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF07142D),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // SECTION TITLE
  // ===========================================================

  Widget _sectionTitle(
      IconData icon,
      String title,
      ) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EDFF),
            borderRadius:
            BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFF6938EF),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF07142D),
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // SUMMARY
  // ===========================================================

  Widget _summaryRow(
      String title,
      String value, {
        Color? valueColor,
        bool bold = false,
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
            fontSize: bold ? 15 : 13,
            fontWeight: bold
                ? FontWeight.w800
                : FontWeight.w600,
            color: valueColor ??
                const Color(0xFF07142D),
          ),
        ),
      ],
    );
  }
}