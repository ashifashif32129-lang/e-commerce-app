import 'package:get/get.dart';

import '../services/order_service.dart';

class OrderController extends GetxController {
  final orders = <Map<String, dynamic>>[];

  String selectedTab = 'All';

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    orders.clear();
    orders.addAll(
      List<Map<String, dynamic>>.from(
        OrderService.orders,
      ),
    );
    update();
  }

  void addOrder({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) {
    OrderService.addOrder(
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: total,
    );

    loadOrders();
  }

  void selectTab(String tab) {
    selectedTab = tab;
    update();
  }

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedTab == 'All') {
      return orders;
    }

    return orders.where((order) {
      return order['status'] == selectedTab;
    }).toList();
  }

  void refreshOrders() {
    loadOrders();
  }
}