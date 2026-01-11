import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/product.dart';

/// API Service for making HTTP requests to Laravel backend
class ApiService {
  /// Fetch all active categories from the API
  /// GET /api/v1/categories
  Future<List<ProductCategory>> getCategories() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.categoriesEndpoint),
            headers: ApiConfig.headers,
          )
          .timeout(ApiConfig.timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'] as List<dynamic>;
        return data
            .map(
              (json) => ProductCategory.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  /// Fetch all products from the API
  /// GET /api/v1/products
  Future<List<Product>> getProducts() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.productsEndpoint),
            headers: ApiConfig.headers,
          )
          .timeout(ApiConfig.timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'] as List<dynamic>;
        return data
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Create a new product
  /// POST /api/v1/products
  Future<Product> createProduct(Product product) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.productsEndpoint),
            headers: ApiConfig.headers,
            body: json.encode(product.toJson()),
          )
          .timeout(ApiConfig.timeoutDuration);

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Product.fromJson(jsonData['data'] as Map<String, dynamic>);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  /// Update an existing product
  /// PUT /api/v1/products/{id}
  Future<Product> updateProduct(int id, Product product) async {
    try {
      final response = await http
          .put(
            Uri.parse('${ApiConfig.productsEndpoint}/$id'),
            headers: ApiConfig.headers,
            body: json.encode(product.toJson()),
          )
          .timeout(ApiConfig.timeoutDuration);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Product.fromJson(jsonData['data'] as Map<String, dynamic>);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  /// Delete a product
  /// DELETE /api/v1/products/{id}
  Future<void> deleteProduct(int id) async {
    try {
      final response = await http
          .delete(
            Uri.parse('${ApiConfig.productsEndpoint}/$id'),
            headers: ApiConfig.headers,
          )
          .timeout(ApiConfig.timeoutDuration);

      if (response.statusCode != 200) {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
