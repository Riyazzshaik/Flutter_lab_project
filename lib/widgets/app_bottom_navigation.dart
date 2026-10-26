import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final int favoritesCount;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    this.favoritesCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onIndexChanged,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.accentLight,
        height: 65,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded, color: AppColors.primary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: favoritesCount > 0
                ? Badge(
                    label: Text(
                      '$favoritesCount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.favorite_outline_rounded),
                  )
                : const Icon(Icons.favorite_outline_rounded),
            selectedIcon: favoritesCount > 0
                ? Badge(
                    label: Text(
                      '$favoritesCount',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.favorite_rounded, color: AppColors.primary),
                  )
                : const Icon(Icons.favorite_rounded, color: AppColors.primary),
            label: 'Favorites',
          ),
          const NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            selectedIcon: Icon(Icons.add_circle_rounded, color: AppColors.primary),
            label: 'Sell',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
