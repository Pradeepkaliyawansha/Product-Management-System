class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  static const String categoriesEndpoint = '$baseUrl/categories';
  static const String productsEndpoint = '$baseUrl/products';

  static const Duration timeoutDuration = Duration(seconds: 30);

  // HTTP Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
