import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/sample_products.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = List<Product>.from(initialSampleProducts);
  final Set<String> _favoriteIds = {'prod-002'}; // Pre-favorite prod-002 as a clear demonstration
  String _searchQuery = '';
  String _selectedCategory = 'All';

  ProductProvider() {
    // Sync initial favorite state
    for (int i = 0; i < _products.length; i++) {
      if (_favoriteIds.contains(_products[i].id)) {
        _products[i] = _products[i].copyWith(isFavorite: true);
      }
    }
  }

  // Getters
  List<Product> get allProducts => List.unmodifiable(_products);
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  int get totalFavoritesCount => _favoriteIds.length;
  int get totalProductsCount => _products.length;

  /// Returns featured products matching optional active category
  List<Product> get featuredProducts {
    return _products.where((p) => p.isFeatured).toList();
  }

  /// Returns all products marked as favorite
  List<Product> get favoriteProducts {
    return _products.where((p) => _favoriteIds.contains(p.id)).toList();
  }

  /// Returns products matching both active search query and category filter
  List<Product> get filteredProducts {
    return _products.where((product) {
      // 1. Category Filter
      final matchesCategory = _selectedCategory == 'All' ||
          product.category.toLowerCase() == _selectedCategory.toLowerCase();

      // 2. Search Query Filter
      if (_searchQuery.trim().isEmpty) {
        return matchesCategory;
      }

      final query = _searchQuery.toLowerCase().trim();
      final matchesTitle = product.title.toLowerCase().contains(query);
      final matchesCategoryName = product.category.toLowerCase().contains(query);
      final matchesDesc = product.description.toLowerCase().contains(query);
      final matchesLocation = product.sellerLocation.toLowerCase().contains(query);

      return matchesCategory &&
          (matchesTitle || matchesCategoryName || matchesDesc || matchesLocation);
    }).toList();
  }

  /// Check if a product is marked as favorite
  bool isProductFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  /// Toggle favorite status of a product
  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index == -1) return;

    final product = _products[index];
    final bool newFavoriteStatus;

    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      newFavoriteStatus = false;
    } else {
      _favoriteIds.add(productId);
      newFavoriteStatus = true;
    }

    _products[index] = product.copyWith(isFavorite: newFavoriteStatus);
    notifyListeners();
  }

  /// Update active search query
  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  /// Reset search query
  void clearSearch() {
    if (_searchQuery.isEmpty) return;
    _searchQuery = '';
    notifyListeners();
  }

  /// Update active category
  void setSelectedCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  /// Reset all filters (category & search)
  void resetFilters() {
    _selectedCategory = 'All';
    _searchQuery = '';
    notifyListeners();
  }

  /// Add a newly created product (from Sell form) to in-memory collection
  void addProduct(Product product) {
    // Insert at beginning of the list so user immediately sees their listed item!
    _products.insert(0, product);
    notifyListeners();
  }

  /// Lookup a single product by ID
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Calculate total rupee savings enabled by ReVive listings
  double get totalRupeeSavings {
    double totalOriginal = 0;
    double totalSecondHand = 0;
    for (final p in _products) {
      totalOriginal += p.originalPrice;
      totalSecondHand += p.price;
    }
    return totalOriginal - totalSecondHand;
  }
}

/// An InheritedNotifier wrapper allowing zero-dependency or Provider-compatible access
class ProductScope extends InheritedNotifier<ProductProvider> {
  const ProductScope({
    super.key,
    required ProductProvider notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ProductProvider of(BuildContext context, {bool listen = true}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<ProductScope>()
        : (context.getElementForInheritedWidgetOfExactType<ProductScope>()?.widget as ProductScope?);

    if (scope == null || scope.notifier == null) {
      throw FlutterError(
        'ProductScope.of() called with a context that does not contain a ProductScope.\n'
        'Ensure that the widget tree has a ProductScope ancestor providing ProductProvider.',
      );
    }
    return scope.notifier!;
  }
}
