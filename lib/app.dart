import 'package:flutter/material.dart';
import 'providers/product_provider.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/sell_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_bottom_navigation.dart';

class ReViveApp extends StatefulWidget {
  const ReViveApp({super.key});

  @override
  State<ReViveApp> createState() => _ReViveAppState();
}

class _ReViveAppState extends State<ReViveApp> {
  final ProductProvider _productProvider = ProductProvider();
  int _currentIndex = 0;

  @override
  void dispose() {
    _productProvider.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }

  void _navigateToFavorites() {
    setState(() {
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductScope(
      notifier: _productProvider,
      child: MaterialApp(
        title: 'ReVive — Second-Hand Marketplace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: Builder(
          builder: (context) {
            final provider = ProductScope.of(context);
            final favoritesCount = provider.totalFavoritesCount;

            final List<Widget> pages = [
              HomeScreen(onNavigateToFavorites: _navigateToFavorites),
              FavoritesScreen(onExploreTap: _navigateToHome),
              SellScreen(onProductCreated: _navigateToHome),
              const ProfileScreen(),
            ];

            return Scaffold(
              body: IndexedStack(
                index: _currentIndex,
                children: pages,
              ),
              bottomNavigationBar: AppBottomNavigation(
                currentIndex: _currentIndex,
                onIndexChanged: _onBottomNavTapped,
                favoritesCount: favoritesCount,
              ),
            );
          },
        ),
      ),
    );
  }
}
