<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\ProductCategory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run(): void
    {
        // Disable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        
        // Clear existing data
        Product::truncate();
        ProductCategory::truncate();
        
        // Re-enable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Create product categories
        $categories = [
            ['name' => 'Electronics', 'active' => true],
            ['name' => 'Clothing', 'active' => true],
            ['name' => 'Books', 'active' => true],
            ['name' => 'Food & Beverages', 'active' => true],
            ['name' => 'Home & Garden', 'active' => true],
            ['name' => 'Sports & Outdoors', 'active' => true],
            ['name' => 'Toys & Games', 'active' => true],
            ['name' => 'Health & Beauty', 'active' => true],
        ];

        foreach ($categories as $category) {
            ProductCategory::create($category);
        }

        // Create sample products
        $products = [
            // Electronics
            ['name' => 'iPhone 15 Pro', 'category_id' => 1, 'price' => 999.99, 'active' => true],
            ['name' => 'Samsung Galaxy S24', 'category_id' => 1, 'price' => 899.99, 'active' => true],
            ['name' => 'MacBook Pro 16"', 'category_id' => 1, 'price' => 2499.99, 'active' => true],
            ['name' => 'Sony WH-1000XM5', 'category_id' => 1, 'price' => 399.99, 'active' => true],
            
            // Clothing
            ['name' => 'Nike Air Max Sneakers', 'category_id' => 2, 'price' => 129.99, 'active' => true],
            ['name' => 'Levi\'s 501 Jeans', 'category_id' => 2, 'price' => 89.99, 'active' => true],
            ['name' => 'Adidas Hoodie', 'category_id' => 2, 'price' => 59.99, 'active' => true],
            
            // Books
            ['name' => 'The Great Gatsby', 'category_id' => 3, 'price' => 14.99, 'active' => true],
            ['name' => 'Clean Code', 'category_id' => 3, 'price' => 39.99, 'active' => true],
            ['name' => 'Atomic Habits', 'category_id' => 3, 'price' => 24.99, 'active' => true],
            
            // Food & Beverages
            ['name' => 'Organic Coffee Beans', 'category_id' => 4, 'price' => 19.99, 'active' => true],
            ['name' => 'Green Tea Set', 'category_id' => 4, 'price' => 29.99, 'active' => true],
            
            // Home & Garden
            ['name' => 'Plant Pot Set', 'category_id' => 5, 'price' => 34.99, 'active' => true],
            ['name' => 'LED Desk Lamp', 'category_id' => 5, 'price' => 45.99, 'active' => true],
            
            // Sports & Outdoors
            ['name' => 'Yoga Mat', 'category_id' => 6, 'price' => 29.99, 'active' => true],
            ['name' => 'Camping Tent', 'category_id' => 6, 'price' => 199.99, 'active' => true],
            
            // Toys & Games
            ['name' => 'LEGO Star Wars Set', 'category_id' => 7, 'price' => 79.99, 'active' => true],
            ['name' => 'PlayStation 5 Controller', 'category_id' => 7, 'price' => 69.99, 'active' => true],
            
            // Health & Beauty
            ['name' => 'Vitamin D Supplements', 'category_id' => 8, 'price' => 19.99, 'active' => true],
            ['name' => 'Facial Cleanser', 'category_id' => 8, 'price' => 15.99, 'active' => true],
        ];

        foreach ($products as $product) {
            Product::create($product);
        }

        $this->command->info('Database seeded successfully!');
        $this->command->info('Created ' . ProductCategory::count() . ' categories');
        $this->command->info('Created ' . Product::count() . ' products');
    }
}