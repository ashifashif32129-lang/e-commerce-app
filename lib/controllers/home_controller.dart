import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Bottom navigation
  final selectedIndex = 0.obs;

  // Search
  final searchController = TextEditingController();

  // Search text
  final searchText = ''.obs;

  // Navigation tabs
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Search
  void searchProduct(String value) {
    searchText.value = value;
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchText.value = '';
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}