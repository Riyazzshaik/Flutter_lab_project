import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final String? heroTagOverride;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
    this.heroTagOverride,
  });

  String get effectiveHeroTag => heroTagOverride ?? product.heroTag;

  Color _getConditionBg(ProductCondition condition) {
    switch (condition) {
      case ProductCondition.likeNew:
        return AppColors.likeNewBg;
      case ProductCondition.good:
        return AppColors.goodBg;
      case ProductCondition.fair:
        return AppColors.fairBg;
    }
  }

  Color _getConditionTextColor(ProductCondition condition) {
    switch (condition) {
      case ProductCondition.likeNew:
        return AppColors.likeNewText;
      case ProductCondition.good:
        return AppColors.goodText;
      case ProductCondition.fair:
        return AppColors.fairText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.divider, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack with Hero Animation & Badges
            Expanded(
              flex: 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: effectiveHeroTag,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: AppColors.surfaceVariant,
                            child: const Center(
                              child: SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surfaceVariant,
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.inventory_2_outlined,
                                    size: 32,
                                    color: AppColors.textTertiary,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Product',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.textTertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Condition Chip (Top Left)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: _getConditionBg(product.condition).withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        product.condition.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _getConditionTextColor(product.condition),
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button (Top Right)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onFavoriteToggle,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            product.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 18,
                            color: product.isFavorite
                                ? AppColors.favoriteRed
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Discount Badge (Bottom Right of Image)
                  if (product.discountPercentage > 0)
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${product.discountPercentage}% OFF',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Product Details Section
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category & Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),

                    // Price & Original Price with Wrap
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              product.formattedPrice,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              product.formattedOriginalPrice,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: AppColors.originalPrice,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 11,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                product.sellerLocation.split(',').first.trim(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
