import 'package:flutter_test/flutter_test.dart';
import 'package:revive_marketplace/models/product.dart';
import 'package:revive_marketplace/providers/product_provider.dart';

void main() {
  group('ProductProvider Tests', () {
    late ProductProvider provider;

    setUp(() {
      provider = ProductProvider();
    });

    test('Initial state contains sample products', () {
      expect(provider.allProducts.isNotEmpty, isTrue);
      expect(provider.totalProductsCount, greaterThanOrEqualTo(10));
      expect(provider.selectedCategory, 'All');
      expect(provider.searchQuery, '');
    });

    test('Category filtering works correctly', () {
      provider.setSelectedCategory('Books');
      final books = provider.filteredProducts;
      expect(books.isNotEmpty, isTrue);
      for (final item in books) {
        expect(item.category.toLowerCase(), 'books');
      }

      provider.setSelectedCategory('Electronics');
      final electronics = provider.filteredProducts;
      expect(electronics.isNotEmpty, isTrue);
      for (final item in electronics) {
        expect(item.category.toLowerCase(), 'electronics');
      }
    });

    test('Search filtering finds products by title', () {
      provider.setSearchQuery('MacBook');
      final results = provider.filteredProducts;
      expect(results.length, 1);
      expect(results.first.title, contains('MacBook'));

      provider.clearSearch();
      expect(provider.searchQuery, '');
      expect(provider.filteredProducts.length, provider.allProducts.length);
    });

    test('Search returns empty list when no matches exist', () {
      provider.setSearchQuery('NonExistentKeywordXYZ123');
      expect(provider.filteredProducts.isEmpty, isTrue);
    });

    test('Favorite toggling adds and removes correctly', () {
      final firstProductId = provider.allProducts.first.id;
      final initialFavStatus = provider.isProductFavorite(firstProductId);

      provider.toggleFavorite(firstProductId);
      expect(provider.isProductFavorite(firstProductId), !initialFavStatus);

      provider.toggleFavorite(firstProductId);
      expect(provider.isProductFavorite(firstProductId), initialFavStatus);
    });

    test('addProduct adds new product to top of the list', () {
      final initialCount = provider.totalProductsCount;
      final customProduct = Product(
        id: 'new-user-item-01',
        title: 'Ergonomic Standing Desk',
        description: 'Motorized dual motor standing desk.',
        price: 12000.0,
        originalPrice: 24000.0,
        category: 'Furniture',
        condition: ProductCondition.likeNew,
        imageUrl: 'https://example.com/desk.jpg',
        sellerName: 'Riyaz',
        sellerLocation: 'Hyderabad',
        sellerContact: '+91 98480 12345',
        postedDate: DateTime.now(),
        sustainabilityImpact: 'Saves landfill space.',
        isFavorite: false,
      );

      provider.addProduct(customProduct);
      expect(provider.totalProductsCount, initialCount + 1);
      expect(provider.allProducts.first.id, 'new-user-item-01');
      expect(provider.allProducts.first.title, 'Ergonomic Standing Desk');
    });

    test('Reset filters resets search and category', () {
      provider.setSelectedCategory('Electronics');
      provider.setSearchQuery('Sony');
      expect(provider.selectedCategory, 'Electronics');
      expect(provider.searchQuery, 'Sony');

      provider.resetFilters();
      expect(provider.selectedCategory, 'All');
      expect(provider.searchQuery, '');
    });
  });
}
