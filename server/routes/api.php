<?php

use App\Http\Controllers\Api\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

/*
|--------------------------------------------------------------------------
| Product Management API Routes - Version 1
|--------------------------------------------------------------------------
|
| All routes are prefixed with /api/v1
| Example: http://127.0.0.1:8000/api/v1/products
|
*/

Route::prefix('v1')->group(function () {
    
    /*
    |--------------------------------------------------------------------------
    | Category Routes
    |--------------------------------------------------------------------------
    */
    
    // GET /api/v1/categories - Get all active categories for dropdown
    Route::get('/categories', [ProductController::class, 'getCategories'])
        ->name('api.categories.index');
    
    /*
    |--------------------------------------------------------------------------
    | Product Routes
    |--------------------------------------------------------------------------
    */
    
    // GET /api/v1/products - Get all products with categories
    Route::get('/products', [ProductController::class, 'index'])
        ->name('api.products.index');
    
    // POST /api/v1/products - Create a new product
    Route::post('/products', [ProductController::class, 'store'])
        ->name('api.products.store');
    
    // GET /api/v1/products/{id} - Get a single product by ID
    Route::get('/products/{id}', [ProductController::class, 'show'])
        ->name('api.products.show');
    
    // PUT /api/v1/products/{id} - Update an existing product
    Route::put('/products/{id}', [ProductController::class, 'update'])
        ->name('api.products.update');
    
    // PATCH /api/v1/products/{id} - Partial update of a product
    Route::patch('/products/{id}', [ProductController::class, 'update'])
        ->name('api.products.patch');
    
    // DELETE /api/v1/products/{id} - Delete a product
    Route::delete('/products/{id}', [ProductController::class, 'destroy'])
        ->name('api.products.destroy');
});

/*
|--------------------------------------------------------------------------
| Health Check & Status Routes
|--------------------------------------------------------------------------
*/

// GET /api/health - Check API status
Route::get('/health', function () {
    return response()->json([
        'status' => 'OK',
        'message' => 'Product Management API is running',
        'timestamp' => now()->toDateTimeString(),
        'version' => '1.0.0'
    ]);
})->name('api.health');

// GET /api/version - Get API version info
Route::get('/version', function () {
    return response()->json([
        'api_version' => '1.0.0',
        'laravel_version' => app()->version(),
        'php_version' => PHP_VERSION,
        'environment' => config('app.env')
    ]);
})->name('api.version');