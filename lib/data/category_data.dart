import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryData {
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'all',
      name: 'All',
      icon: Icons.apps_rounded,
      color: const Color(0xFFE9E7FF),
    ),
     CategoryModel(
      id: 'electronics',
      name: 'Electronics',
      icon: Icons.devices_rounded,
      color: Color(0xFFE9E7FF),
    ),
    CategoryModel(
      id: 'fashion',
      name: 'Fashion',
      icon: Icons.checkroom_rounded,
      color: Color(0xFFFFE8EF),
    ),
    CategoryModel(
      id: 'beauty',
      name: 'Beauty',
      icon: Icons.brush_rounded,
      color: Color(0xFFFFE5EE),
    ),
    CategoryModel(
      id: 'home',
      name: 'Home',
      icon: Icons.home_rounded,
      color: Color(0xFFFFEFD9),
    ),
     CategoryModel(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_basketball_rounded,
      color: Color(0xFFE5F4FF),
    ),
    CategoryModel(
      id: 'books',
      name: 'Books',
      icon: Icons.menu_book_rounded,
      color: Color(0xFFEAF7E8),
    ),
     CategoryModel(
      id: 'groceries',
      name: 'Groceries',
      icon: Icons.shopping_basket_rounded,
      color: Color(0xFFFFF3D6),
    ),
  ];
}