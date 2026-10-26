import 'package:flutter/material.dart';
import '../data/sample_products.dart';
import '../theme/app_colors.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.devices_rounded;
      case 'furniture':
        return Icons.chair_rounded;
      case 'books':
        return Icons.menu_book_rounded;
      case 'fashion':
        return Icons.checkroom_rounded;
      case 'sports':
        return Icons.sports_basketball_rounded;
      case 'appliances':
        return Icons.kitchen_rounded;
      case 'all':
      default:
        return Icons.grid_view_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: productCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = productCategories[index];
          final isSelected = category.toLowerCase() == selectedCategory.toLowerCase();

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onCategorySelected(category),
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      size: 18,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
