enum ProductCondition {
  likeNew('Like New', 'Barely used, in pristine cosmetic and working condition.'),
  good('Good', 'Gently used with minor signs of cosmetic wear, fully functional.'),
  fair('Fair', 'Noticeable cosmetic wear, but thoroughly tested and 100% operational.');

  final String label;
  final String description;

  const ProductCondition(this.label, this.description);

  /// Convenient alias for UI components
  String get displayName => label;

  static ProductCondition fromString(String value) {
    switch (value.toLowerCase()) {
      case 'like new':
      case 'likenew':
        return ProductCondition.likeNew;
      case 'fair':
        return ProductCondition.fair;
      case 'good':
      default:
        return ProductCondition.good;
    }
  }
}

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final double originalPrice;
  final String category;
  final ProductCondition condition;
  final String imageUrl;
  final String sellerName;
  final String sellerLocation;
  final String sellerContact;
  final bool isFeatured;
  final DateTime postedDate;
  final String sustainabilityImpact;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.category,
    required this.condition,
    required this.imageUrl,
    required this.sellerName,
    required this.sellerLocation,
    required this.sellerContact,
    this.isFeatured = false,
    required this.postedDate,
    required this.sustainabilityImpact,
    this.isFavorite = false,
  });

  /// Unique Hero animation tag for List -> Detail image transition
  String get heroTag => 'product-hero-image-$id';

  /// Calculate savings percentage compared to brand new retail price
  int get discountPercentage {
    if (originalPrice <= price || originalPrice <= 0) return 0;
    return (((originalPrice - price) / originalPrice) * 100).round();
  }

  /// Formatted price in Indian Rupees (INR)
  String get formattedPrice {
    return '₹${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?'),
          (Match m) => '${m[1]},',
        )}';
  }

  /// Formatted original price in Indian Rupees (INR)
  String get formattedOriginalPrice {
    return '₹${originalPrice.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?'),
          (Match m) => '${m[1]},',
        )}';
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? originalPrice,
    String? category,
    ProductCondition? condition,
    String? imageUrl,
    String? sellerName,
    String? sellerLocation,
    String? sellerContact,
    bool? isFeatured,
    DateTime? postedDate,
    String? sustainabilityImpact,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      imageUrl: imageUrl ?? this.imageUrl,
      sellerName: sellerName ?? this.sellerName,
      sellerLocation: sellerLocation ?? this.sellerLocation,
      sellerContact: sellerContact ?? this.sellerContact,
      isFeatured: isFeatured ?? this.isFeatured,
      postedDate: postedDate ?? this.postedDate,
      sustainabilityImpact: sustainabilityImpact ?? this.sustainabilityImpact,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
