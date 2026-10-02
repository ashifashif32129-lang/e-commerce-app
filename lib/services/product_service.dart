import '../data/product_data.dart';
import '../models/product_model.dart';

class ProductService {
  static List<ProductModel> getProducts() {
    return ProductData.products;
  }

  static ProductModel? getProductById(String id) {
    try {
      return ProductData.products.firstWhere(
            (product) => product.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  static List<ProductModel> getProductsByCategory(
      String categoryId,
      ) {
    if (categoryId == 'all') {
      return ProductData.products;
    }

    return ProductData.products
        .where(
          (product) => product.categoryId == categoryId,
    )
        .toList();
  }

  static List<ProductModel> searchProducts(
      String query,
      ) {
    if (query.trim().isEmpty) {
      return ProductData.products;
    }

    final searchQuery = query.toLowerCase().trim();

    return ProductData.products.where((product) {
      return product.name.toLowerCase().contains(searchQuery) ||
          product.categoryName.toLowerCase().contains(searchQuery);
    }).toList();
  }
}