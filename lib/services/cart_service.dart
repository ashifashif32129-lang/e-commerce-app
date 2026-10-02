import 'package:flutter/material.dart';

class CartService {
  static final List<Map<String, dynamic>> cartItems = [];

  static void addToCart({
    required String name,
    required double price,
    required IconData icon,
    int quantity = 1,
  }) {
    final existingIndex = cartItems.indexWhere(
          (item) => item['name'] == name,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      cartItems.add({
        'name': name,
        'price': price,
        'quantity': quantity,
        'icon': icon,
      });
    }
  }

  static void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  static int get itemCount {
    int count = 0;

    for (final item in cartItems) {
      count += item['quantity'] as int;
    }

    return count;
  }
}