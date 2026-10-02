import 'package:flutter/material.dart';

class OrderModel {
  final String orderId;
  final DateTime date;
  final String status;
  final List<OrderItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double total;

  const OrderModel({
    required this.orderId,
    required this.date,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  int get totalQuantity {
    int quantity = 0;

    for (final item in items) {
      quantity += item.quantity;
    }

    return quantity;
  }
}

class OrderItemModel {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final IconData icon;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.icon,
  });

  double get totalPrice => price * quantity;
}