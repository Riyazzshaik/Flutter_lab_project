import 'package:flutter/material.dart';
import '../data/sample_products.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../theme/app_colors.dart';

class SellScreen extends StatefulWidget {
  final VoidCallback onProductCreated;

  const SellScreen({super.key, required this.onProductCreated});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sellerNameController = TextEditingController(text: 'Riyaz Shaik');
  final _sellerLocationController = TextEditingController(text: 'Madhapur, Hyderabad');
  final _sellerContactController = TextEditingController(text: '+91 98480 12345');

  String _selectedCategory = 'Electronics';
  ProductCondition _selectedCondition = ProductCondition.likeNew;
  int _selectedImageIndex = 0;

  final List<Map<String, String>> _sampleImages = [
    {
      'name': 'Smartphone / Gadget',
      'url': 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Laptop / Tablet',
      'url': 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Study Desk / Furniture',
      'url': 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Books / Academics',
      'url': 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    },
    {
      'name': 'Cycle / Sports Gear',
      'url': 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?auto=format&fit=crop&w=800&q=80',
    },
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _originalPriceController.dispose();
    _descriptionController.dispose();
    _sellerNameController.dispose();
    _sellerLocationController.dispose();
    _sellerContactController.dispose();
    super.dispose();
  }

  String _generateSustainabilityImpact(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return 'Prevents ~45 kg toxic e-waste and saves rare earth semiconductor elements.';
      case 'furniture':
        return 'Preserves timber, saving ~0.2 cubic meters of forest trees and diverted landfill bulky waste.';
      case 'books':
        return 'Saves ~2,000 liters of industrial water and prevents virgin paper pulp harvesting.';
      case 'fashion':
        return 'Conserves ~5,000 liters of fresh water and prevents textile microplastic shedding.';
      case 'sports':
        return 'Avoids industrial metal smelting and encourages eco-friendly physical fitness.';
      case 'appliances':
      default:
        return 'Extends appliance duty cycle, cutting municipal electrical waste.';
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final double price = double.parse(_priceController.text.trim());
    final double originalPrice = double.tryParse(_originalPriceController.text.trim()) ?? (price * 1.4);

    final newProduct = Product(
      id: 'prod-user-${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      price: price,
      originalPrice: originalPrice > price ? originalPrice : (price * 1.3),
      category: _selectedCategory,
      condition: _selectedCondition,
      imageUrl: _sampleImages[_selectedImageIndex]['url']!,
      sellerName: _sellerNameController.text.trim(),
      sellerLocation: _sellerLocationController.text.trim(),
      sellerContact: _sellerContactController.text.trim(),
      isFeatured: false,
      postedDate: DateTime.now(),
      sustainabilityImpact: _generateSustainabilityImpact(_selectedCategory),
      isFavorite: false,
    );

    final provider = ProductScope.of(context, listen: false);
    provider.addProduct(newProduct);

    // Show confirmation
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
            SizedBox(width: 10),
            Text('Listing Published!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"${newProduct.title}" has been successfully added to your local session listings and is immediately browseable.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.eco_rounded, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'SDG 12 Impact: ${newProduct.sustainabilityImpact}',
                      style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _titleController.clear();
              _priceController.clear();
              _originalPriceController.clear();
              _descriptionController.clear();
              widget.onProductCreated();
            },
            child: const Text('View on Marketplace'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = productCategories.where((c) => c != 'All').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('List a Second-Hand Item'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Intro Banner with explicit local session notice
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.volunteer_activism_rounded, color: AppColors.primary, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Selling pre-owned keeps working items out of landfills. Note: Listed items are stored in your active session and display instantly across the marketplace.',
                            style: TextStyle(fontSize: 12, color: AppColors.textPrimary, height: 1.35),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Field
                  const Text('Product Title *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: 'e.g., iPhone 13 128GB Blue / Study Table',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Please enter a product title.';
                      if (value.trim().length < 4) return 'Title must be at least 4 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Category & Condition Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Category *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              initialValue: _selectedCategory,
                              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                              items: categories.map((cat) {
                                return DropdownMenuItem(value: cat, child: Text(cat, style: const TextStyle(fontSize: 13)));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedCategory = val);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Condition *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            DropdownButtonFormField<ProductCondition>(
                              isExpanded: true,
                              initialValue: _selectedCondition,
                              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                              items: ProductCondition.values.map((cond) {
                                return DropdownMenuItem(value: cond, child: Text(cond.label, style: const TextStyle(fontSize: 13)));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedCondition = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Pricing Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Selling Price (₹) *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'e.g., 4500',
                                prefixText: '₹ ',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) return 'Enter selling price.';
                                final parsed = double.tryParse(value.trim());
                                if (parsed == null || parsed <= 0) return 'Enter valid price > 0.';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Original Retail Price (₹)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _originalPriceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'e.g., 9000',
                                prefixText: '₹ ',
                              ),
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  final parsed = double.tryParse(value.trim());
                                  if (parsed == null || parsed <= 0) return 'Enter valid price.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sample Image Selector
                  const Text('Select Sample Image *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const SizedBox(height: 4),
                  const Text(
                    'Select a representative photo for this local demonstration listing.',
                    style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _sampleImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final item = _sampleImages[index];
                        final isSelected = _selectedImageIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedImageIndex = index),
                          child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.divider,
                                width: isSelected ? 2.5 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    item['url']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: AppColors.surfaceVariant,
                                      child: const Icon(Icons.photo, size: 20, color: AppColors.textTertiary),
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      child: const Center(
                                        child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  const Text('Product Description *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Detail the age, operational condition, included accessories, reasons for selling...',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Please describe the product.';
                      if (value.trim().length < 15) return 'Description should be at least 15 characters.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Seller Info Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Name *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _sellerNameController,
                              decoration: const InputDecoration(hintText: 'Full Name'),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your name.' : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Location / City *', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _sellerLocationController,
                              decoration: const InputDecoration(hintText: 'City, Area'),
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter location.' : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.add_task_rounded, size: 20),
                      label: const Text('Post Second-Hand Listing'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
