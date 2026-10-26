import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/category_selector.dart';
import '../widgets/empty_state.dart';
import '../widgets/featured_product_card.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/sustainability_banner.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToFavorites;

  const HomeScreen({super.key, this.onNavigateToFavorites});

  void _openProductDetail(BuildContext context, Product product, {String? customHeroTag}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          heroTag: customHeroTag ?? product.heroTag,
        ),
      ),
    );
  }

  void _showSdgInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.eco_rounded, color: AppColors.primary, size: 26),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'UN SDG 12 Alignment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Responsible Consumption & Production',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ReVive actively supports United Nations Sustainable Development Goal 12 by fostering a circular economy for second-hand goods.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
              SizedBox(height: 12),
              Text(
                'Key Impacts:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 6),
              Text('• Reduces municipal solid waste and electronics in landfills.',
                  style: TextStyle(fontSize: 12.5, height: 1.35)),
              Text('• Decreases carbon emissions from new industrial manufacturing.',
                  style: TextStyle(fontSize: 12.5, height: 1.35)),
              Text('• Promotes equitable, affordable access to tech and study essentials.',
                  style: TextStyle(fontSize: 12.5, height: 1.35)),
              Text('• Extends functional lifecycle of consumer items by 2-5x.',
                  style: TextStyle(fontSize: 12.5, height: 1.35)),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ProductScope.of(context);
    final filteredProducts = provider.filteredProducts;
    final featuredProducts = provider.featuredProducts;
    final hasSearchOrCategory =
        provider.searchQuery.isNotEmpty || provider.selectedCategory != 'All';

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.recycling_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'ReVive',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'Give Good Things a Second Life',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
            tooltip: 'SDG 12 Information',
            onPressed: () => _showSdgInfoDialog(context),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.favorite_outline_rounded, color: AppColors.textPrimary),
                if (provider.totalFavoritesCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${provider.totalFavoritesCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            tooltip: 'View Favorites',
            onPressed: onNavigateToFavorites,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Search & Filter Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: SearchBarWidget(
                query: provider.searchQuery,
                onChanged: provider.setSearchQuery,
                onClear: provider.clearSearch,
              ),
            ),
          ),

          // Sustainability Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SustainabilityBanner(
                onTap: () => _showSdgInfoDialog(context),
              ),
            ),
          ),

          // Category Selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: CategorySelector(
                selectedCategory: provider.selectedCategory,
                onCategorySelected: provider.setSelectedCategory,
              ),
            ),
          ),

          // Featured Products Section (Show when not actively searching or when in All)
          if (!hasSearchOrCategory && featuredProducts.isNotEmpty) ...[
            SliverToBoxAdapter(
                                          child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Featured Pre-Owned',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${featuredProducts.length} items',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 242,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    final product = featuredProducts[index];
                    return FeaturedProductCard(
                      product: product,
                      onTap: () => _openProductDetail(
                        context,
                        product,
                        customHeroTag: '${product.heroTag}-featured',
                      ),
                      onFavoriteToggle: () => provider.toggleFavorite(product.id),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
          ],

          // Product Grid Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        provider.selectedCategory == 'All'
                            ? 'All Market Listings'
                            : '${provider.selectedCategory} Listings',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Text(
                          '${filteredProducts.length}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (hasSearchOrCategory)
                    TextButton(
                      onPressed: provider.resetFilters,
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Reset', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ),
          ),

          // Main Responsive Product Grid or Empty State
          if (filteredProducts.isEmpty)
            SliverToBoxAdapter(
              child: EmptyStateWidget(
                icon: Icons.search_off_rounded,
                title: 'No Products Found',
                message: provider.searchQuery.isNotEmpty
                    ? 'No second-hand items matched "${provider.searchQuery}". Try searching for phones, books, or chairs.'
                    : 'No items currently available in "${provider.selectedCategory}". Check back soon or list an item!',
                buttonText: 'Reset Filters',
                onButtonPressed: provider.resetFilters,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(heroTagOverride: "hero-home-${product.id}",
                      product: product,
                      onTap: () => _openProductDetail(context, product, customHeroTag: "hero-home-${product.id}"),
                      onFavoriteToggle: () => provider.toggleFavorite(product.id),
                    );
                  },
                  childCount: filteredProducts.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
