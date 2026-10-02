import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const Color navy = Color(0xFF07142D);
  static const Color purple = Color(0xFF6938EF);
  static const Color lightPurple = Color(0xFFF1EDFF);

  @override
  Widget build(BuildContext context) {
    final OrderController _ =
    Get.find<OrderController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: navy,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: GetBuilder<OrderController>(
        builder: (controller) {
          const tabs = [
            'All',
            'Processing',
            'On the way',
            'Delivered',
            'Cancelled',
          ];

          final orderList = controller.filteredOrders;

          return Column(
            children: [
              const SizedBox(height: 8),

              // ================= TABS =================

              SizedBox(
                height: 46,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  separatorBuilder: (_, _) =>
                  const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final tab = tabs[index];

                    final bool isSelected =
                        controller.selectedTab == tab;

                    return GestureDetector(
                      onTap: () {
                        controller.selectTab(tab);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? purple
                              : lightPurple,
                          borderRadius:
                          BorderRadius.circular(24),
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : navy,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ================= ORDERS =================

              Expanded(
                child: orderList.isEmpty
                    ? _emptyOrders()
                    : ListView.separated(
                  padding:
                  const EdgeInsets.fromLTRB(
                    16,
                    4,
                    16,
                    24,
                  ),
                  itemCount: orderList.length,
                  separatorBuilder: (_, _) =>
                  const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final order =
                    orderList[index];

                    return _orderCard(
                      context,
                      order,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // ORDER CARD
  // =========================================================

  Widget _orderCard(
      BuildContext context,
      Map<String, dynamic> order,
      ) {
    final String orderId =
        order['orderId']?.toString() ?? '';

    final String status =
        order['status']?.toString() ?? 'Processing';

    final List items =
        (order['items'] as List?) ?? [];

    final double total =
        (order['total'] as num?)?.toDouble() ?? 0;

    final DateTime? date =
    order['date'] is DateTime
        ? order['date'] as DateTime
        : null;

    final String firstItemName = items.isNotEmpty
        ? items.first['name']?.toString() ??
        'Product'
        : 'Product';

    final int itemCount = items.length;

    final IconData productIcon =
    items.isNotEmpty &&
        items.first['icon'] is IconData
        ? items.first['icon'] as IconData
        : Icons.shopping_bag_outlined;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  orderId,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _statusChip(status),
            ],
          ),

          const SizedBox(height: 6),

          if (date != null)
            Text(
              _formatDate(date),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

          const SizedBox(height: 16),

          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Icon(
                  productIcon,
                  color: purple,
                  size: 28,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstItemName,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      itemCount == 1
                          ? '1 item'
                          : '$itemCount items',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                '₹${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(
                          () => OrderDetailsScreen(
                        order: order,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: navy,
                    side: const BorderSide(
                      color: Colors.black12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                  ),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              if (status == 'Delivered') ...[
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar(
                        'Buy Again',
                        'Products added to cart',
                        snackPosition:
                        SnackPosition.BOTTOM,
                      );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      foregroundColor:
                      Colors.white,
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                    ),
                    child: const Text(
                      'Buy Again',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATUS
  // =========================================================

  Widget _statusChip(String status) {
    Color background;
    Color textColor;

    switch (status) {
      case 'Delivered':
        background = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;

      case 'On the way':
        background = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;

      case 'Cancelled':
        background = Colors.red.shade50;
        textColor = Colors.red.shade700;
        break;

      default:
        background = Colors.orange.shade50;
        textColor = Colors.orange.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY
  // =========================================================

  Widget _emptyOrders() {
    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: lightPurple,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: purple,
              size: 42,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No Orders Found',
            style: TextStyle(
              color: navy,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Your orders will appear here.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// =============================================================
// ORDER DETAILS SCREEN
// =============================================================

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  static const Color navy = Color(0xFF07142D);
  static const Color purple = Color(0xFF6938EF);
  static const Color lightPurple = Color(0xFFF1EDFF);

  @override
  Widget build(BuildContext context) {
    final List items =
        (order['items'] as List?) ?? [];

    final double subtotal =
        (order['subtotal'] as num?)?.toDouble() ?? 0;

    final double deliveryFee =
        (order['deliveryFee'] as num?)?.toDouble() ?? 0;

    final double total =
        (order['total'] as num?)?.toDouble() ?? 0;

    final String status =
        order['status']?.toString() ?? 'Processing';

    final String orderId =
        order['orderId']?.toString() ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:
        const IconThemeData(color: navy),
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(
                    color: navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                _infoRow('Order ID', orderId),
                const SizedBox(height: 10),
                _infoRow('Status', status),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Products',
                  style: TextStyle(
                    color: navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),

                ...items.map(
                      (item) {
                    final String name =
                        item['name']?.toString() ??
                            'Product';

                    final double price =
                        (item['price'] as num?)
                            ?.toDouble() ??
                            0;

                    final int quantity =
                        (item['quantity'] as num?)
                            ?.toInt() ??
                            1;

                    final IconData icon =
                    item['icon'] is IconData
                        ? item['icon'] as IconData
                        : Icons
                        .shopping_bag_outlined;

                    return Padding(
                      padding:
                      const EdgeInsets.only(
                        bottom: 14,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration:
                            BoxDecoration(
                              color: lightPurple,
                              borderRadius:
                              BorderRadius.circular(
                                13,
                              ),
                            ),
                            child: Icon(
                              icon,
                              color: purple,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  name,
                                  style:
                                  const TextStyle(
                                    color: navy,
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Qty: $quantity',
                                  style: TextStyle(
                                    color: Colors
                                        .grey
                                        .shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Text(
                            '₹${(price * quantity).toStringAsFixed(0)}',
                            style:
                            const TextStyle(
                              color: navy,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Summary',
                  style: TextStyle(
                    color: navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 16),

                _priceRow(
                  'Subtotal',
                  subtotal,
                ),

                const SizedBox(height: 10),

                _priceRow(
                  'Delivery',
                  deliveryFee,
                ),

                const Padding(
                  padding:
                  EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  child: Divider(),
                ),

                _priceRow(
                  'Total',
                  total,
                  isTotal: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _infoRow(
      String title,
      String value,
      ) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: navy,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _priceRow(
      String title,
      double value, {
        bool isTotal = false,
      }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: isTotal
                ? navy
                : Colors.grey.shade700,
            fontSize: isTotal ? 16 : 14,
            fontWeight:
            isTotal
                ? FontWeight.w800
                : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          '₹${value.toStringAsFixed(0)}',
          style: TextStyle(
            color: navy,
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}