<?php

use App\Http\Controllers\Api\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});



Route::prefix('v1')->group(function () {
    
    /*
    |--------------------------------------------------------------------------
    | Category Routes
    |--------------------------------------------------------------------------
    */
    
    Route::get('/categories', [ProductController::class, 'getCategories'])
        ->name('api.categories.index');
    
    /*
    |--------------------------------------------------------------------------
    | Product Routes
    |--------------------------------------------------------------------------
    */
    
    Route::get('/products', [ProductController::class, 'index'])
        ->name('api.products.index');
    
    Route::post('/products', [ProductController::class, 'store'])
        ->name('api.products.store');
    
    Route::get('/products/{id}', [ProductController::class, 'show'])
        ->name('api.products.show');
    
    Route::put('/products/{id}', [ProductController::class, 'update'])
        ->name('api.products.update');
    
    Route::patch('/products/{id}', [ProductController::class, 'update'])
        ->name('api.products.patch');
    
    Route::delete('/products/{id}', [ProductController::class, 'destroy'])
        ->name('api.products.destroy');
});



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