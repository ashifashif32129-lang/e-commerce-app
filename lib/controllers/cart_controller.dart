import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<Map<String, dynamic>> cartItems =
      <Map<String, dynamic>>[].obs;

  // Add product
  void addToCart({
    required String name,
    required double price,
    required IconData icon,
    int quantity = 1,
  }) {
    final index = cartItems.indexWhere(
          (item) => item['name'] == name,
    );

    if (index != -1) {
      cartItems[index]['quantity'] += quantity;
      cartItems.refresh();
    } else {
      cartItems.add({
        'name': name,
        'price': price,
        'quantity': quantity,
        'icon': icon,
      });
    }

    Get.snackbar(
      'Added to Cart',
      '$name added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Increase quantity
  void increaseQuantity(int index) {
    cartItems[index]['quantity']++;
    cartItems.refresh();
  }

  // Decrease quantity
  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity']--;
      cartItems.refresh();
    }
  }

  // Remove product
  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }

  // Subtotal
  double get subtotal {
    double total = 0;

    for (final item in cartItems) {
      total +=
          (item['price'] as double) *
              (item['quantity'] as int);
    }

    return total;
  }

  // Delivery fee
  double get deliveryFee {
    if (cartItems.isEmpty) {
      return 0;
    }

    return subtotal >= 5000 ? 0 : 49;
  }

  // Total
  double get total {
    return subtotal + deliveryFee;
  }

  // Total quantity
  int get itemCount {
    int count = 0;

    for (final item in cartItems) {
      count += item['quantity'] as int;
    }

    return count;
  }

  // Check cart empty
  bool get isEmpty => cartItems.isEmpty;
}