/// Product Category Model
/// Represents a category that products can belong to
class ProductCategory {
  final int id;
  final String name;

  ProductCategory({required this.id, required this.name});

  /// Create ProductCategory from JSON response
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(id: json['id'] as int, name: json['name'] as String);
  }

  /// Convert ProductCategory to JSON for API requests
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() => 'ProductCategory(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCategory && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// Product Model
/// Represents a product in the inventory system
class Product {
  final int? id;
  final String name;
  final int categoryId;
  final double price;
  final bool active;
  final ProductCategory? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    required this.categoryId,
    required this.price,
    required this.active,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  /// {
  ///   "id": 1,
  ///   "name": "iPhone 15 Pro",
  ///   "category_id": 1,
  ///   "price": "999.99",
  ///   "active": true,
  ///   "category": {"id": 1, "name": "Electronics"},
  ///   "created_at": "2024-01-01T00:00:00.000000Z",
  ///   "updated_at": "2024-01-01T00:00:00.000000Z"
  /// }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      categoryId: json['category_id'] as int,
      price: double.parse(json['price'].toString()),
      active: json['active'] == 1 || json['active'] == true,
      category: json['category'] != null
          ? ProductCategory.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Convert Product to JSON for API requests (POST/PUT)
  /// Excludes id, createdAt, updatedAt, and category
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category_id': categoryId,
      'price': price,
      'active': active,
    };
  }

  /// Create a copy of Product with some fields updated
  Product copyWith({
    int? id,
    String? name,
    int? categoryId,
    double? price,
    bool? active,
    ProductCategory? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      active: active ?? this.active,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, categoryId: $categoryId, price: \$$price, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.categoryId == categoryId &&
        other.price == price &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        categoryId.hashCode ^
        price.hashCode ^
        active.hashCode;
  }

  /// Get status as string
  String get statusText => active ? 'Active' : 'Inactive';

  /// Get formatted price with currency symbol
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Check if product is valid for submission
  /// validation for name, categoryId, and price for client-side character limit
  bool get isValid {
    return name.trim().isNotEmpty &&
        name.trim().length <= 255 &&
        categoryId > 0 &&
        price >= 0;
  }
}
