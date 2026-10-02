import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  final products = <ProductModel>[].obs;
  final filteredProducts = <ProductModel>[].obs;

  final selectedCategory = 'all'.obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  // Load all products
  void loadProducts() {
    products.assignAll(ProductService.getProducts());
    filteredProducts.assignAll(products);
  }

  // Category filter
  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;

    if (categoryId == 'all') {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        ProductService.getProductsByCategory(categoryId),
      );
    }

    _applySearch();
  }

  // Search products
  void searchProducts(String query) {
    searchText.value = query;
    _applySearch();
  }

  void _applySearch() {
    final query = searchText.value.toLowerCase().trim();

    List<ProductModel> result;

    if (selectedCategory.value == 'all') {
      result = List<ProductModel>.from(products);
    } else {
      result = products
          .where(
            (product) =>
        product.categoryId == selectedCategory.value,
      )
          .toList();
    }

    if (query.isNotEmpty) {
      result = result.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.categoryName.toLowerCase().contains(query);
      }).toList();
    }

    filteredProducts.assignAll(result);
  }

  // Get product by ID
  ProductModel? getProduct(String id) {
    return ProductService.getProductById(id);
  }

  // Clear search
  void clearSearch() {
    searchText.value = '';
    _applySearch();
  }
}