class ApiConfig {
  // ==========================================
  // IMPORTANT: Configure your API URL here
  // ==========================================

  // For Android Emulator (recommended for testing)
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  // For iOS Simulator - Uncomment this and comment above
  // static const String baseUrl = 'http://localhost:8000/api/v1';

  // For Physical Device - Replace with your computer's IP address
  // Find your IP: Windows (ipconfig) | Mac/Linux (ifconfig)
  // static const String baseUrl = 'http://192.168.1.100:8000/api/v1';

  // ==========================================
  // API Endpoints
  // ==========================================
  static const String categoriesEndpoint = '$baseUrl/categories';
  static const String productsEndpoint = '$baseUrl/products';

  // ==========================================
  // Configuration
  // ==========================================
  static const Duration timeoutDuration = Duration(seconds: 30);

  // HTTP Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
