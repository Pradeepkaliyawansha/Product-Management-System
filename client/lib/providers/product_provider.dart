import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  // API Service instance
  final ApiService _apiService = ApiService();

  // ==========================================
  // Private State Variables
  // ==========================================
  List<Product> _products = [];
  List<ProductCategory> _categories = [];
  bool _isLoading = false;
  String? _error;

  // ==========================================
  // Public Getters
  // ==========================================

  /// Get list of all products
  List<Product> get products => _products;

  /// Get list of all categories
  List<ProductCategory> get categories => _categories;

  /// Check if data is currently loading
  bool get isLoading => _isLoading;

  /// Get current error message (if any)
  String? get error => _error;

  /// Get total number of products
  int get productCount => _products.length;

  /// Get total number of categories
  int get categoryCount => _categories.length;

  /// Get only active products
  List<Product> get activeProducts =>
      _products.where((product) => product.active).toList();

  /// Get only inactive products
  List<Product> get inactiveProducts =>
      _products.where((product) => !product.active).toList();

  /// Check if there are any products
  bool get hasProducts => _products.isNotEmpty;

  /// Check if there are any categories
  bool get hasCategories => _categories.isNotEmpty;

  // ==========================================
  // Category Management Methods
  // ==========================================

  Future<void> loadCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _categories = await _apiService.getCategories();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();

      // Log error for debugging
      if (kDebugMode) {
        print('Error loading categories: $e');
      }
    }
  }

  /// Get category by ID
  ProductCategory? getCategoryById(int id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // ==========================================
  // Product Management Methods
  // ==========================================

  Future<void> loadProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _products = await _apiService.getProducts();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();

      // Log error for debugging
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    }
  }

  /// Add a new product to the database
  /// Returns true if successful, false otherwise
  Future<bool> addProduct(Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newProduct = await _apiService.createProduct(product);

      // Add to the beginning of the list (most recent first)
      _products.insert(0, newProduct);

      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Product added successfully: ${newProduct.name}');
      }

      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();

      // Log error for debugging
      if (kDebugMode) {
        print('Error adding product: $e');
      }

      return false;
    }
  }

  /// Update an existing product in the database
  /// Returns true if successful, false otherwise
  Future<bool> updateProduct(int id, Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updatedProduct = await _apiService.updateProduct(id, product);

      // Find and replace the product in the list
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }

      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Product updated successfully: ${updatedProduct.name}');
      }

      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();

      // Log error for debugging
      if (kDebugMode) {
        print('Error updating product: $e');
      }

      return false;
    }
  }

  /// Delete a product from the database by ID
  /// Returns true if successful, false otherwise
  Future<bool> deleteProduct(int id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _apiService.deleteProduct(id);

      // Remove the product from the list
      _products.removeWhere((p) => p.id == id);

      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Product deleted successfully: ID $id');
      }

      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();

      // Log error for debugging
      if (kDebugMode) {
        print('Error deleting product: $e');
      }

      return false;
    }
  }

  /// Get a product by ID
  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get products by category ID
  List<Product> getProductsByCategory(int categoryId) {
    return _products
        .where((product) => product.categoryId == categoryId)
        .toList();
  }

  /// Search products by name
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;

    final lowerQuery = query.toLowerCase();
    return _products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // ==========================================
  // Utility Methods
  // ==========================================

  /// Clear any error messages
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Refresh all data (categories and products)
  Future<void> refreshAll() async {
    await loadCategories();
    await loadProducts();
  }

  /// Clear all data (useful for logout or reset)
  void clearAll() {
    _products = [];
    _categories = [];
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Sort products by name (A-Z)
  void sortProductsByNameAsc() {
    _products.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  /// Sort products by name (Z-A)
  void sortProductsByNameDesc() {
    _products.sort((a, b) => b.name.compareTo(a.name));
    notifyListeners();
  }

  /// Sort products by price (low to high)
  void sortProductsByPriceAsc() {
    _products.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  /// Sort products by price (high to low)
  void sortProductsByPriceDesc() {
    _products.sort((a, b) => b.price.compareTo(a.price));
    notifyListeners();
  }

  /// Sort products by creation date (newest first)
  void sortProductsByNewest() {
    _products.sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return b.createdAt!.compareTo(a.createdAt!);
    });
    notifyListeners();
  }

  /// Sort products by creation date (oldest first)
  void sortProductsByOldest() {
    _products.sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) return 0;
      return a.createdAt!.compareTo(b.createdAt!);
    });
    notifyListeners();
  }
}
