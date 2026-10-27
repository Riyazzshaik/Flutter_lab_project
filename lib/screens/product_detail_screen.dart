import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final String heroTag;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.heroTag,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _openEnquiryDialog(BuildContext context, Product product) {
    final messageController = TextEditingController(
      text: 'Hi ${product.sellerName.split(" ").first}, is this "${product.title}" still available?',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Seller Enquiry',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_pin_rounded, color: AppColors.primary, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.sellerName,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          Text(
                            '${product.sellerLocation} • ${product.sellerContact}',
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Your Message:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: messageController,
                maxLines: 3,
                style: const TextStyle(fontSize: 13.5),
                decoration: const InputDecoration(
                  hintText: 'Type your enquiry or price offer...',
                ),
              ),
              const SizedBox(height: 10),
              // Preset message chips
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  ActionChip(
                    label: const Text('Is price negotiable?', style: TextStyle(fontSize: 11)),
                    onPressed: () {
                      messageController.text =
                          'Hi, I am interested in this item. Is the price negotiable?';
                    },
                  ),
                  ActionChip(
                    label: const Text('Can we meet today?', style: TextStyle(fontSize: 11)),
                    onPressed: () {
                      messageController.text =
                          'Hi, can we meet today in ${product.sellerLocation.split(",").first} for inspection?';
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 14, color: AppColors.warning),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Academic demo: Submitting simulates buyer-to-seller messaging.',
                        style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Enquiry sent to ${product.sellerName}! (Local demo simulation)'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            icon: const Icon(Icons.send_rounded, size: 16),
            label: const Text('Send Enquiry'),
          ),
        ],
      ),
    );
  }

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
    final provider = ProductScope.of(context);
    // Observe latest state of the product (for favorite toggle sync)
    final currentProduct = provider.getProductById(widget.product.id) ?? widget.product;
    final isFav = provider.isProductFavorite(currentProduct.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible / Floating App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 330,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  tooltip: 'Back',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFav ? AppColors.favoriteRed : AppColors.textPrimary,
                    ),
                    tooltip: 'Toggle Favorite',
                    onPressed: () => provider.toggleFavorite(currentProduct.id),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.heroTag,
                child: Image.network(
                  currentProduct.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppColors.surfaceVariant,
                      child: const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.surfaceVariant,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Detail Content Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Condition Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accentLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentProduct.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getConditionBg(currentProduct.condition),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Condition: ${currentProduct.condition.label}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _getConditionTextColor(currentProduct.condition),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    currentProduct.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Pricing Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pre-Owned Price',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  currentProduct.formattedPrice,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  currentProduct.formattedOriginalPrice,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.originalPrice,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (currentProduct.discountPercentage > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Save ${currentProduct.discountPercentage}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SDG 12 Environmental Impact Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFBBF7D0)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.eco_rounded,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Wrap(
                                spacing: 6,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    'SDG 12 Impact',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '• Responsible Consumption',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                currentProduct.sustainabilityImpact,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF14532D),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Condition Description
                  const Text(
                    'Item Condition',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    currentProduct.condition.description,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentProduct.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Seller Profile Card
                  const Text(
                    'Seller Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.accentLight,
                          child: Text(
                            currentProduct.sellerName.isNotEmpty
                                ? currentProduct.sellerName[0].toUpperCase()
                                : 'S',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      currentProduct.sellerName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 13,
                                    color: AppColors.textTertiary,
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      currentProduct.sellerLocation,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 90), // Bottom padding for sticky button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(top: BorderSide(color: AppColors.divider)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _openEnquiryDialog(context, currentProduct),
                  icon: const Icon(Icons.forum_rounded, size: 20),
                  label: const Text('Contact Seller / Enquiry'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
