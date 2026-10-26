import '../models/product.dart';

final List<Product> initialSampleProducts = [
  Product(
    id: 'prod-001',
    title: 'OnePlus 11 5G (16GB RAM, 256GB)',
    description:
        'Titan Black color variant with original fast charger, protective case, and box. Used with screen protector from day one. Battery health is at 94%. No scratches on frame or display. Flawless Hasselblad camera performance.',
    price: 34999.0,
    originalPrice: 61999.0,
    category: 'Electronics',
    condition: ProductCondition.likeNew,
    imageUrl:
        'https://images.unsplash.com/photo-1598327105666-5b89351aff97?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Arjun Sharma',
    sellerLocation: 'Indiranagar, Bengaluru',
    sellerContact: '+91 98765 43210',
    isFeatured: true,
    postedDate: DateTime.now().subtract(const Duration(days: 2)),
    sustainabilityImpact:
        'Saves ~82 kg CO2 equivalent and 55 kg raw mineral extraction by extending smartphone operational lifecycle.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-002',
    title: 'MacBook Air M1 (8GB, 256GB SSD) Space Grey',
    description:
        'Used gently for university assignments and coding. Battery cycle count is only 142. Includes original 30W USB-C adapter and braided charging cable. Screen and keyboard are in pristine condition.',
    price: 47500.0,
    originalPrice: 84900.0,
    category: 'Electronics',
    condition: ProductCondition.likeNew,
    imageUrl:
        'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Priya Narang',
    sellerLocation: 'Hitec City, Hyderabad',
    sellerContact: '+91 98111 22334',
    isFeatured: true,
    postedDate: DateTime.now().subtract(const Duration(days: 3)),
    sustainabilityImpact:
        'Prevents 160 kg CO2 emissions and reduces toxic e-waste runoff from circuit board fabrication.',
    isFavorite: true,
  ),
  Product(
    id: 'prod-003',
    title: 'Ergonomic Mesh High-Back Office Chair',
    description:
        'Green Soul breathable mesh desk chair with adjustable 3D lumbar support, multi-lock recline, and cushioned armrests. Very comfortable for long study and work-from-home sessions. Moving out of city sale.',
    price: 4200.0,
    originalPrice: 9999.0,
    category: 'Furniture',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1580481077195-c3a821a58875?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Karthik Rao',
    sellerLocation: 'Koramangala, Bengaluru',
    sellerContact: '+91 97400 55667',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 4)),
    sustainabilityImpact:
        'Diverts 18 kg of heavy plastic and steel structural components from ending up in local landfills.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-004',
    title: 'Sony WH-1000XM4 Noise Canceling Headphones',
    description:
        'Industry-leading active noise cancellation. 30 hours battery life, touch sensor controls, and pristine high-resolution audio. Ear cushions sanitized and thoroughly maintained. Comes with audio cable and flight adapter.',
    price: 13999.0,
    originalPrice: 24990.0,
    category: 'Electronics',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Sneha Kulkarni',
    sellerLocation: 'Kothrud, Pune',
    sellerContact: '+91 99220 88990',
    isFeatured: true,
    postedDate: DateTime.now().subtract(const Duration(days: 1)),
    sustainabilityImpact:
        'Eliminates the demand for fresh lithium battery extraction and micro-acoustic alloy smelting.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-005',
    title: 'Solid Teak Wood Study Table with 3 Drawers',
    description:
        'Handcrafted pure teak wood study desk with cable grommet and smooth telescopic drawer runners. Sturdy enough to last generations. Natural honey wood polish with light surface patina.',
    price: 6800.0,
    originalPrice: 15500.0,
    category: 'Furniture',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Vikram Mehta',
    sellerLocation: 'Andheri West, Mumbai',
    sellerContact: '+91 98200 44556',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 5)),
    sustainabilityImpact:
        'Avoids harvesting mature hardwood timber, preserving 0.35 cubic meters of forest canopy.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-006',
    title: 'Complete B.Tech Computer Science Core Books (Set of 6)',
    description:
        'Includes Cormen (Algorithms), Tanenbaum (Networks), Galvin (OS), Korth (DBMS), Pressman (SE), and Sedra (Digital Logic). Neat pencil markings on only a few pages. Perfect for semester exams & GATE prep.',
    price: 1450.0,
    originalPrice: 4200.0,
    category: 'Books',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Rohit Verma',
    sellerLocation: 'Dwarka, New Delhi',
    sellerContact: '+91 98711 33445',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 6)),
    sustainabilityImpact:
        'Saves ~3,200 liters of industrial water and prevents deforestation for virgin paper pulp.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-007',
    title: 'Firefox Target 21-Speed Mountain Bicycle (27.5T)',
    description:
        'Lightweight alloy frame, front suspension with lockout, Shimano Tourney derailleurs, and dual disc brakes. Recently serviced with new puncture-resistant tubes and chain lubrication. Free bottle cage included.',
    price: 8900.0,
    originalPrice: 18500.0,
    category: 'Sports',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1485965120184-e220f721d03e?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Deepak Nair',
    sellerLocation: 'Velachery, Chennai',
    sellerContact: '+91 94440 12345',
    isFeatured: true,
    postedDate: DateTime.now().subtract(const Duration(days: 1)),
    sustainabilityImpact:
        'Promotes zero-emission urban micro-mobility and conserves 45 kg of specialized bicycle alloy fabrication.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-008',
    title: 'Canon EOS 1500D DSLR with 18-55mm IS II Lens',
    description:
        '24.1 MP APS-C CMOS sensor with built-in Wi-Fi and NFC. Shutter count is under 4,500 clicks. Includes 32GB Class 10 SD card, UV filter, lens hood, carrying bag, and original battery + charger.',
    price: 22500.0,
    originalPrice: 41995.0,
    category: 'Electronics',
    condition: ProductCondition.likeNew,
    imageUrl:
        'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Ananya Sen',
    sellerLocation: 'Salt Lake, Kolkata',
    sellerContact: '+91 98300 77889',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 7)),
    sustainabilityImpact:
        'Prevents precision optical glass and rare-earth semiconductor disposal into municipal waste streams.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-009',
    title: 'Levi’s Premium Vintage Trucker Denim Jacket (Size M)',
    description:
        'Authentic 100% cotton rigid denim jacket in washed indigo. Brass buttons and classic chest flap pockets. Worn a handful of times, washed properly with eco-friendly detergent. Zero rips or fraying.',
    price: 1800.0,
    originalPrice: 4999.0,
    category: 'Fashion',
    condition: ProductCondition.likeNew,
    imageUrl:
        'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Rohan Gupta',
    sellerLocation: 'Banjara Hills, Hyderabad',
    sellerContact: '+91 97000 66778',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 3)),
    sustainabilityImpact:
        'Conserves over 7,500 liters of fresh water required to grow and dye new cotton crops.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-010',
    title: 'Philips Air Fryer HD9200 (4.1 Litre Rapid Air)',
    description:
        'Healthy oil-free cooking with Rapid Air technology. 60-minute timer with auto-off and dishwasher-safe basket. Used for 8 months during college hostel stay. Works perfectly with crisp results.',
    price: 3600.0,
    originalPrice: 7995.0,
    category: 'Appliances',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1584269600464-37b1b58a9fe7?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Meera Iyer',
    sellerLocation: 'Whitefield, Bengaluru',
    sellerContact: '+91 96111 88990',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 4)),
    sustainabilityImpact:
        'Extends the lifespan of household heating appliances and prevents premature landfilling of electrical elements.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-011',
    title: 'Decathlon Domyos Adjustable Dumbbell Set (20 kg)',
    description:
        'Includes 2 threaded chrome bars, 4 x 2kg cast iron plates, 4 x 1kg plates, 4 spinlock collars, and rugged transport case. Compact home workout gear. Shows light surface marks from normal use.',
    price: 2400.0,
    originalPrice: 4999.0,
    category: 'Sports',
    condition: ProductCondition.good,
    imageUrl:
        'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Varun Joshi',
    sellerLocation: 'Aundh, Pune',
    sellerContact: '+91 98222 11223',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 8)),
    sustainabilityImpact:
        'Avoids energy-intensive blast furnace smelting of 20 kg virgin cast iron.',
    isFavorite: false,
  ),
  Product(
    id: 'prod-012',
    title: 'Kindle Paperwhite (10th Gen, 8GB, Waterproof)',
    description:
        '300 ppi glare-free display that reads like real paper even in bright sunlight. Adjustable warm backlight. Battery easily lasts 4-5 weeks on a single charge. Bundled with magnetic leather sleep cover.',
    price: 5200.0,
    originalPrice: 12999.0,
    category: 'Electronics',
    condition: ProductCondition.likeNew,
    imageUrl:
        'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    sellerName: 'Divya Soni',
    sellerLocation: 'Sector 62, Noida',
    sellerContact: '+91 99100 55443',
    isFeatured: false,
    postedDate: DateTime.now().subtract(const Duration(days: 2)),
    sustainabilityImpact:
        'Facilitates hundreds of digital book readings, eliminating continuous paper publishing footprint.',
    isFavorite: false,
  ),
];

const List<String> productCategories = [
  'All',
  'Electronics',
  'Furniture',
  'Books',
  'Fashion',
  'Sports',
  'Appliances',
];
