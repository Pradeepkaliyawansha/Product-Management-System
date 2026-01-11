# Product Management System

A full-stack product management application with a Flutter mobile client and Laravel REST API backend. This system allows users to manage products and categories with full CRUD operations.

## ✨ Features

## 🛠 Tech Stack

### Backend
- **Framework:** Laravel 12.0
- **Language:** PHP 8.2+
- **Database:** MY SQL
- **API:** RESTful architecture
- **Validation:** Laravel Form Requests
- **CORS:** Enabled for cross-origin requests

### Frontend
- **Framework:** Flutter 3.10.7
- **Language:** Dart 3.10.7
- **State Management:** Provider 6.1.5
- **HTTP Client:** http 1.6.0
- **Formatting:** intl 0.19.0
- **Platforms:** Android, iOS, Web, Windows, macOS, Linux

### Development Tools
- **Backend Build:** Composer
- **Frontend Build:** Flutter SDK
- **Version Control:** Git
- **Package Manager:** Pub (Flutter), Composer (Laravel)

## 📁 Project Structure

```
product-management-system/
├── client/                          # Flutter mobile application
│   ├── lib/
│   │   ├── config/                  # Configuration files
│   │   │   └── api_config.dart      # API endpoint configuration
│   │   ├── models/                  # Data models
│   │   │   └── product.dart         # Product and Category models
│   │   ├── providers/               # State management
│   │   │   └── product_provider.dart
│   │   ├── screens/                 # UI screens
│   │   │   ├── product_list_screen.dart
│   │   │   └── add_product_screen.dart
│   │   ├── services/                # API services
│   │   │   └── api_service.dart
│   │   ├── widgets/                 # Reusable widgets
│   │   │   └── product_card.dart
│   │   └── main.dart                # Application entry point
│   ├── android/                     # Android platform files
│   ├── ios/                         # iOS platform files
│   └── pubspec.yaml                 # Flutter dependencies
│
└── server/                          # Laravel REST API
    ├── app/
    │   ├── Http/
    │   │   ├── Controllers/
    │   │   │   └── ProductController.php
    │   │   └── Requests/
    │   │       └── StoreProductRequest.php
    │   └── Models/
    │       ├── Product.php
    │       └── ProductCategory.php
    ├── database/
    │   ├── migrations/
    │   │   ├── create_product_categories_table.php
    │   │   └── create_products_table.php
    │   └── seeders/
    │       └── DatabaseSeeder.php
    ├── routes/
    │   └── api.php                  # API routes
    ├── config/
    │   └── cors.php                 # CORS configuration
    └── composer.json                # PHP dependencies
```

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

### For Backend (Laravel)
- PHP 8.2 or higher
- Composer 2.x
- MySql
- Git

### For Frontend (Flutter)
- Flutter SDK 3.10.7 or higher
- Dart SDK 3.10.7 or higher
- VS Code or Android Studio (recommended IDEs)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd product-management-system
```

### 2. Backend Setup (Laravel)

```bash
# Navigate to server directory
cd server

# Install PHP dependencies
composer install

# Copy environment file
cp .env.example  .env

# Generate application key
php artisan key:generate

# Create SQLite database file
touch database/database.sqlite

# Run migrations
php artisan migrate

# Seed the database with sample data
php artisan db:seed
```

### 3. Frontend Setup (Flutter)

```bash
# Navigate to client directory
cd ../client

# Install Flutter dependencies
flutter pub get

# Run Flutter doctor to check for issues
flutter doctor
```

## ⚙️ Configuration

### Backend Configuration

Edit `server/.env` file:

```env
APP_NAME="Product Management System"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=sqlite

# CORS Configuration (already set in config/cors.php)
# Allows requests from Flutter app
```

**Important:** Replace the IP address based on your setup:
- **Android Emulator:** `10.0.2.2` (localhost alias)
- **iOS Simulator:** `localhost` or `127.0.0.1`
- **Physical Device:** Your computer's local IP address (e.g., `192.168.1.100`)
- **Production:** Your deployed API URL

## 🏃 Running the Application

### Start Backend Server

```bash
# From server directory
cd server

# Start Laravel development server
php artisan serve

# Server will run at http://localhost:8000
```

The API will be available at: `http://localhost:8000/api/v1`

### Run Flutter Application

#### Android Emulator

```bash
# From client directory
cd client

# List available devices
flutter devices

# Run on Android emulator
flutter run
```
### Base URL

```
http://localhost:8000/api/v1
```

### Endpoints

#### Categories

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/categories` | Get all active categories |

#### Products

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/products` | Get all products with categories |
| POST | `/products` | Create a new product |
| GET | `/products/{id}` | Get a single product |
| PUT | `/products/{id}` | Update a product |
| DELETE | `/products/{id}` | Delete a product |

### Request/Response Examples

#### Get All Products

**Request:**
```bash
GET /api/v1/products
```

**Product Creation/Update:**
- `name`: Required, string, max 255 characters
- `category_id`: Required, integer, must exist in categories table
- `price`: Required, numeric, minimum 0, max 2 decimal places
- `active`: Required, boolean

## 🗄 Database Schema

### Product Categories Table

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO_INCREMENT |
| name | VARCHAR(255) | NOT NULL |
| active | BOOLEAN | DEFAULT true |
| created_at | TIMESTAMP | |
| updated_at | TIMESTAMP | |

### Products Table

| Column | Type | Constraints |
|--------|------|-------------|
| id | INTEGER | PRIMARY KEY, AUTO_INCREMENT |
| name | VARCHAR(255) | NOT NULL |
| category_id | INTEGER | FOREIGN KEY → product_categories(id) |
| price | DECIMAL(10,2) | NOT NULL |
| active | BOOLEAN | DEFAULT true |
| created_at | TIMESTAMP | |
| updated_at | TIMESTAMP | |


### Mobile App Screens

1. **Product List Screen**
   - Displays all products with category and price
   - Shows active/inactive status with color-coded badges
   - Floating action button to add new products

2. **Add/Edit Product Screen**
   - Form with validation
   - Category dropdown selection
   - Price input with currency formatting
   - Active status toggle switch

3. **Product Card**
   - Status indicator (green for active, grey for inactive)
   - Product name, category, and price
   - Action menu for edit/delete operations
---

**Happy Coding! 🚀**
