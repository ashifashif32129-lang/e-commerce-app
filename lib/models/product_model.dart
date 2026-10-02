import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final double price;
  final double oldPrice;
  final double rating;
  final String description;
  final IconData icon;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.description,
    required this.icon,
    this.isFavorite = false,
  });

  double get discountPercentage {
    if (oldPrice <= 0) return 0;

    return ((oldPrice - price) / oldPrice) * 100;
  }
}