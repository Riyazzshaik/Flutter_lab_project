import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showArchitectureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.layers_rounded, color: AppColors.primary, size: 24),
            SizedBox(width: 10),
            Text('Architecture Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Flutter Lab Implementation Details:',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary),
              ),
              SizedBox(height: 8),
              Text('• State Management: ChangeNotifier with InheritedNotifier (ProductProvider)', style: TextStyle(fontSize: 12.5)),
              SizedBox(height: 4),
              Text('• Hero Transitions: Stable unique Hero tags per product (product-hero-image-id)', style: TextStyle(fontSize: 12.5)),
              SizedBox(height: 4),
              Text('• Null Safety: 100% sound null safety across models and widgets', style: TextStyle(fontSize: 12.5)),
              SizedBox(height: 4),
              Text('• Material 3: Adaptive theme with custom forest green color palette', style: TextStyle(fontSize: 12.5)),
              SizedBox(height: 4),
              Text('• SDG Alignment: UN SDG 12 (Responsible Consumption and Production)', style: TextStyle(fontSize: 12.5)),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showImpactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.public_rounded, color: AppColors.primary, size: 24),
            SizedBox(width: 10),
            Text('Social & Eco Impact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Why SDG 12 Matters in Mobile Commerce:',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.primary),
              ),
              SizedBox(height: 8),
              Text(
                'Fast consumption cycles generate millions of tons of avoidable electronic and household waste every year.\n\nReVive addresses this by making pre-owned goods trustworthy, accessible, and desirable through seamless mobile experience.',
                style: TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ProductScope.of(context);
    final totalListings = provider.totalProductsCount;
    final totalSavings = provider.totalRupeeSavings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Profile & Impact'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // User Profile Header Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.divider),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 34,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Riyaz Shaik',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.verified_rounded, size: 16, color: AppColors.primary),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Flutter Lab Scholar • B.Tech CSE',
                              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accentLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Eco Champion Level 2',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Eco Impact Dashboard
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Community Eco Metrics',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.energy_savings_leaf_rounded, color: AppColors.accentWarm, size: 20),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$totalListings',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Items Diverted from Landfill',
                                  style: TextStyle(fontSize: 11, color: Color(0xFFD8F3DC)),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.white24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₹${(totalSavings / 1000).toStringAsFixed(1)}k',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.accentWarm,
                                  ),
                                ),
                                const Text(
                                  'Community Rupee Savings',
                                  style: TextStyle(fontSize: 11, color: Color(0xFFD8F3DC)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Action / Info Tiles
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.public_rounded, color: AppColors.primary),
                        title: const Text('UN SDG 12 Commitment', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('Responsible Consumption & Circular Economy', style: TextStyle(fontSize: 12)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: () => _showImpactDialog(context),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        leading: const Icon(Icons.layers_outlined, color: AppColors.primary),
                        title: const Text('App Architecture & Lab Rubrics', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('Evaluation criteria, Hero transitions, State', style: TextStyle(fontSize: 12)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: () => _showArchitectureDialog(context),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        leading: const Icon(Icons.assignment_outlined, color: AppColors.primary),
                        title: const Text('Lab Evaluation Rubric', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('25 Total Marks • 6 Evaluation Criteria', style: TextStyle(fontSize: 12)),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accentLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('25 Marks', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Academic Credits Footer
                Container(
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Text(
                        'ReVive — Second-Hand Marketplace v1.0.0',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Academic Flutter Lab Project • Built with Material 3 & Hero Animations',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textTertiary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
