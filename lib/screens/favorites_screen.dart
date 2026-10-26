import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/empty_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final VoidCallback? onExploreTap;

  const FavoritesScreen({super.key, this.onExploreTap});

  void _openProductDetail(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          heroTag: "hero-fav-${product.id}",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ProductScope.of(context);
    final favoriteProducts = provider.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Saved Items'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${favoriteProducts.length}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: favoriteProducts.isEmpty
          ? EmptyStateWidget(
              icon: Icons.favorite_border_rounded,
              title: 'No Favorites Yet',
              message:
                  'Keep track of pre-owned treasures you like. Tap the heart icon on any product card to save it here.',
              buttonText: 'Explore Marketplace',
              onButtonPressed: onExploreTap,
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ProductCard(heroTagOverride: "hero-fav-${product.id}",
                  product: product,
                  onTap: () => _openProductDetail(context, product),
                  onFavoriteToggle: () => provider.toggleFavorite(product.id),
                );
              },
            ),
    );
  }
}
