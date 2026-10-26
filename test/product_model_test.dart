import 'package:flutter_test/flutter_test.dart';
import 'package:revive_marketplace/models/product.dart';

void main() {
  group('Product Model Tests', () {
    test('Product instantiates with valid parameters and getters', () {
      final product = Product(
        id: 'test-001',
        title: 'Dell XPS 13 Laptop',
        description: 'Excellent condition laptop for programming.',
        price: 45000.0,
        originalPrice: 90000.0,
        category: 'Electronics',
        condition: ProductCondition.likeNew,
        imageUrl: 'https://example.com/laptop.jpg',
        sellerName: 'Riyaz Shaik',
        sellerLocation: 'Hyderabad',
        sellerContact: '+91 98480 12345',
        isFeatured: true,
        postedDate: DateTime(2026, 1, 1),
        sustainabilityImpact: 'Saves ~100 kg CO2 emissions.',
        isFavorite: false,
      );

      expect(product.id, 'test-001');
      expect(product.title, 'Dell XPS 13 Laptop');
      expect(product.price, 45000.0);
      expect(product.originalPrice, 90000.0);
      expect(product.discountPercentage, 50);
      expect(product.formattedPrice, contains('45,000'));
      expect(product.heroTag, 'product-hero-image-test-001');
      expect(product.condition.label, 'Like New');
    });

    test('ProductCondition fromString parses correctly', () {
      expect(ProductCondition.fromString('Like New'), ProductCondition.likeNew);
      expect(ProductCondition.fromString('likenew'), ProductCondition.likeNew);
      expect(ProductCondition.fromString('Good'), ProductCondition.good);
      expect(ProductCondition.fromString('Fair'), ProductCondition.fair);
      expect(ProductCondition.fromString('unknown'), ProductCondition.good);
    });

    test('Product copyWith works correctly', () {
      final product = Product(
        id: 'test-002',
        title: 'Original Title',
        description: 'Original Desc',
        price: 1000.0,
        originalPrice: 2000.0,
        category: 'Books',
        condition: ProductCondition.good,
        imageUrl: 'https://example.com/book.jpg',
        sellerName: 'John',
        sellerLocation: 'Bengaluru',
        sellerContact: '+91 90000 00000',
        postedDate: DateTime.now(),
        sustainabilityImpact: 'Saves water',
        isFavorite: false,
      );

      final updated = product.copyWith(
        title: 'Updated Title',
        isFavorite: true,
        price: 800.0,
      );

      expect(updated.title, 'Updated Title');
      expect(updated.isFavorite, true);
      expect(updated.price, 800.0);
      expect(updated.id, 'test-002');
      expect(updated.category, 'Books');
    });
  });
}
