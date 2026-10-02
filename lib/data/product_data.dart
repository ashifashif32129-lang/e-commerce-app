import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductData {
  static const List<ProductModel> products = [
    ProductModel(
      id: 'p001',
      name: 'Wireless Earbuds',
      categoryId: 'electronics',
      categoryName: 'Electronics',
      price: 2999,
      oldPrice: 4499,
      rating: 4.8,
      description:
      'High-quality wireless earbuds with clear sound, deep bass and long battery life.',
      icon: Icons.headphones_rounded,
    ),

    ProductModel(
      id: 'p002',
      name: 'Smart Watch',
      categoryId: 'electronics',
      categoryName: 'Electronics',
      price: 1999,
      oldPrice: 2999,
      rating: 4.6,
      description:
      'Modern smart watch with fitness tracking, notifications and stylish design.',
      icon: Icons.watch_rounded,
    ),

    ProductModel(
      id: 'p003',
      name: 'Running Shoes',
      categoryId: 'fashion',
      categoryName: 'Fashion',
      price: 3499,
      oldPrice: 5999,
      rating: 4.7,
      description:
      'Comfortable running shoes designed for everyday workouts and running.',
      icon: Icons.directions_run_rounded,
    ),

    ProductModel(
      id: 'p004',
      name: 'Premium Hoodie',
      categoryId: 'fashion',
      categoryName: 'Fashion',
      price: 1499,
      oldPrice: 2499,
      rating: 4.5,
      description:
      'Premium comfortable hoodie with a modern casual style.',
      icon: Icons.checkroom_rounded,
    ),

    ProductModel(
      id: 'p005',
      name: 'Face Serum',
      categoryId: 'beauty',
      categoryName: 'Beauty',
      price: 799,
      oldPrice: 1299,
      rating: 4.6,
      description:
      'Lightweight face serum suitable for daily skincare routines.',
      icon: Icons.spa_rounded,
    ),

    ProductModel(
      id: 'p006',
      name: 'Table Lamp',
      categoryId: 'home',
      categoryName: 'Home',
      price: 999,
      oldPrice: 1499,
      rating: 4.4,
      description:
      'Elegant table lamp perfect for bedrooms, study rooms and offices.',
      icon: Icons.light_rounded,
    ),
  ];
}