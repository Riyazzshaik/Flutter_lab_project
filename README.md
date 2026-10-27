# ReVive — Second-Hand Marketplace
> **"Give Good Things a Second Life."**  
> *Academic Flutter Laboratory Project | Evaluation Rubric: 25 Marks*  
> **Primary UN Sustainable Development Goal:** **SDG 12 — Responsible Consumption and Production**

---

## 📌 1. Project Title & Overview

**ReVive** is a modern, responsive, and eco-conscious mobile marketplace built with Flutter and Material 3. The platform addresses modern urban consumerism and electronic/material waste by establishing a local circular economy. It enables students, young professionals, and conscious consumers to discover, purchase, and sell high-quality pre-owned items—such as smartphones, laptops, study desks, academic textbooks, sports equipment, and home appliances.

By extending the operational lifecycle of everyday products, ReVive directly contributes to **United Nations Sustainable Development Goal 12 (Responsible Consumption & Production)**, preventing premature disposal into landfills, cutting carbon emissions from new manufacturing, and making essential goods affordable.

---

## 🎯 2. Problem Statement & Objectives

### Problem Statement
Rapid consumption cycles, fast tech refresh rates, and consumer culture generate millions of tons of avoidable e-waste and solid waste each year. College students and young professionals frequently purchase costly new items (electronics, textbooks, study furniture) and discard or abandon them upon graduation or relocation, while incoming students struggle with the financial burden of purchasing brand-new goods. Existing general-purpose classifieds platforms often suffer from clutter, poor mobile UX, lack of sustainability context, and absence of reliable condition classification.

### Project Objectives
1. **Promote Sustainable Consumption (SDG 12):** Explicitly visualize environmental savings (avoided carbon emissions, diverted landfill waste, conserved water) for each pre-owned transaction.
2. **Deliver Superior Mobile UI/UX (5 Marks):** Build a warm, minimal, high-contrast Material 3 interface using an eco-inspired Forest Green design system with zero layout overflow and intuitive visual hierarchy.
3. **Flawless Hero Animation Navigation (Phase 4 Core Requirement):** Implement Flutter's native `Hero` widget with unique tags (`product-hero-image-$id`) for seamless image transitions between product feeds and detail views.
4. **Comprehensive Real-Time Functionality (7 Marks):**
   * Multi-criteria product search (by title, category, description, and location).
   * Horizontally scrollable category filtering (Electronics, Furniture, Books, Fashion, Sports, Appliances).
   * Synchronized favorite toggling across all screens.
   * In-memory listing creation (Sell Form) with strict input validation.
   * Interactive seller enquiry modal simulation.
5. **Clean Flutter Architecture & State Management (5 Marks):** Null-safe Dart code using `ChangeNotifier` and reactive `ProductScope` / `Provider` pattern, separating presentation, state, and domain models.
6. **Academic Documentation & Viva Preparedness (3 Marks):** Complete technical report, reproducible test scripts, and comprehensive viva preparation guides.

---

## 👥 3. Intended Users & Personas

* **University Students:** Looking for affordable textbooks, laptops, monitors, study desks, and bicycles within campus or city radius.
* **Young Professionals:** Relocating between cities who need reliable, pre-owned furniture, home appliances, and workspace gear.
* **Eco-Conscious Consumers:** Individuals dedicated to reducing their personal carbon footprint and diverting usable products from landfills.
* **Student Sellers:** Individuals moving out of dorms or upgrading gadgets who wish to declutter responsibly and recoup fair value.

---

## ✨ 4. Main Features

| Feature | Description |
| :--- | :--- |
| **Branded Home Hub** | Branded header, live category stats, introductory sustainability banner, and real-time market counter. |
| **Hero Image Transitions** | Native Flutter `Hero` widget animating product images between grid cards and the full detail page. |
| **Instant Search & Query Reset** | Live search filtering matching keywords across titles, descriptions, categories, and seller locations with one-tap clear. |
| **Category Filter Bar** | Horizontally scrolling chip selector (`All`, `Electronics`, `Furniture`, `Books`, `Fashion`, `Sports`, `Appliances`) with active state badges. |
| **Interactive Favorites System** | One-tap heart button on product cards and detail screens, synchronized with a dedicated Saved Items screen. |
| **Sell / Listing Form** | Complete form to post pre-owned items with title, price, category, condition, description, seller contact, and automated SDG impact estimation. |
| **Seller Enquiry Modal** | In-app contact dialog displaying seller details, preset inquiry chips ("Is price negotiable?", "Can we meet today?"), and simulated messaging confirmation. |
| **Eco Impact Dashboard** | Profile screen displaying community metrics: items diverted from landfills, rupee savings, and SDG 12 educational references. |
| **Offline Resilience** | Self-contained sample dataset with network image loading indicators and offline placeholder fallbacks. |

---

## 🛠️ 5. Technology Stack

* **Framework:** Flutter (Channel stable, Material 3 enabled)
* **Language:** Dart (v3.x, 100% Sound Null Safety)
* **Design System:** Custom Forest Green Palette (`#1B4332`, `#2D6A4F`, `#D8F3DC`, `#F8F9FA`)
* **State Management:** `ChangeNotifier` + `InheritedNotifier<ProductProvider>` / `Provider`
* **Navigation:** `MaterialPageRoute` with custom transitions and `Hero` animations
* **Icons:** Material Icons & Cupertino Icons
* **Testing:** `flutter_test` suite (Unit & Widget testing)

---

## 🏗️ 6. Flutter Project Architecture

The codebase strictly adheres to clean architectural separation of concerns:

```text
c:\Users\Riyaz\OneDrive\Desktop\flutter\
├── lib/
│   ├── main.dart                      # Application entry point & SystemChrome config
│   ├── app.dart                       # ReViveApp widget, IndexedStack & persistent BottomNav
│   ├── models/
│   │   └── product.dart               # Product domain model, ProductCondition enum & getters
│   ├── data/
│   │   └── sample_products.dart       # Realistic Indian marketplace seed data & categories
│   ├── providers/
│   │   └── product_provider.dart      # ChangeNotifier & ProductScope state management
│   ├── theme/
│   │   ├── app_colors.dart            # Semantic brand color tokens (Forest Green, Mint, Slate)
│   │   └── app_theme.dart             # Material 3 ThemeData, typography, and card stylings
│   ├── widgets/
│   │   ├── product_card.dart          # Reusable 2-column grid card with Hero & favorite badge
│   │   ├── featured_product_card.dart # Horizontal highlight card with collision-free Hero tag
│   │   ├── category_selector.dart     # Horizontal scrollable category pill bar
│   │   ├── search_bar_widget.dart     # Responsive search input with instant clear button
│   │   ├── sustainability_banner.dart # Gradient SDG 12 callout banner
│   │   ├── empty_state.dart           # Reusable empty/no-match feedback component
│   │   └── app_bottom_navigation.dart # Material 3 NavigationBar with dynamic favorite badge
│   └── screens/
│       ├── home_screen.dart           # Primary catalog feed, search, featured & grid
│       ├── product_detail_screen.dart # Large Hero image, pricing, seller card, enquiry modal
│       ├── favorites_screen.dart      # Reactive grid of saved items with empty state
│       ├── sell_screen.dart           # Validated listing creation form adding to live feed
│       └── profile_screen.dart        # User profile, community eco metrics & viva info
├── test/
│   ├── product_model_test.dart        # Unit tests for Product model, pricing, and tags
│   ├── product_provider_test.dart     # Unit tests for filtering, search, favorites, addProduct
│   └── widget_test.dart               # Widget tests for app startup, navigation & validation
├── docs/
│   └── PROJECT_REPORT.md              # Complete 25-mark academic lab project report
├── pubspec.yaml                       # Dependencies, metadata, and asset declarations
└── .gitignore                         # Standard Flutter gitignore excluding build artifacts
```

---

## 📦 7. Detailed Feature Explanations

### A. The Product Model (`lib/models/product.dart`)
* Every listing is encapsulated by an immutable `Product` class.
* Includes: `id`, `title`, `description`, `price`, `originalPrice`, `category`, `condition` (`ProductCondition` enum: Like New, Good, Fair), `imageUrl`, `sellerName`, `sellerLocation`, `sellerContact`, `isFeatured`, `postedDate`, `sustainabilityImpact`, and `isFavorite`.
* Provides computed getters:
  * `heroTag`: Generates a stable identifier: `'product-hero-image-$id'`.
  * `discountPercentage`: Computes savings: `((originalPrice - price) / originalPrice * 100).round()`.
  * `formattedPrice` & `formattedOriginalPrice`: Indian Rupee formatting with thousands grouping (`₹34,999`).

### B. State Management (`lib/providers/product_provider.dart`)
* Built using Dart's native `ChangeNotifier` and wrapped in `ProductScope` (an `InheritedNotifier`).
* Eliminates heavy third-party boilerplate while remaining 100% compatible with `provider: ^6.1.2`.
* Guarantees O(1) favorite lookup using an internal `Set<String> _favoriteIds`.
* Coordinates multi-predicate filtering: `filteredProducts` executes both active category checking and search query matching in a single pipeline.
* `addProduct(Product product)` inserts new user-submitted items at index `0` of `_products` and calls `notifyListeners()`, causing the home feed to refresh immediately.

### C. Hero Animation Implementation (`Hero` Widget)
* **Requirement:** Phase 4 specifically demands seamless image expansion from list cards to detail view.
* **Mechanism:**
  1. On `ProductCard` (grid): The image is wrapped in `Hero(tag: product.heroTag, child: ClipRRect(...))`.
  2. On `ProductDetailScreen`: The `SliverAppBar` flexible space is wrapped in `Hero(tag: heroTag, child: ClipRRect(...))`.
  3. **Duplicate Tag Prevention:** For `FeaturedProductCard`, tags are differentiated as `${product.heroTag}-featured` and passed into `ProductDetailScreen`, preventing runtime `duplicate Hero tag` exceptions if the same product is featured and listed in the grid simultaneously.
  4. Both screens enforce identical `ClipRRect` geometry, ensuring a fluid, glitch-free shared-element transition during navigation and reverse pop.

### D. Sell Form & Validation (`lib/screens/sell_screen.dart`)
* Backed by `GlobalKey<FormState>` and `TextEditingController` instances.
* Validates:
  * Product Title: Required, minimum 4 characters.
  * Selling Price: Required, numeric, strictly greater than 0.
  * Description: Required, minimum 15 characters to ensure quality descriptions.
  * Seller Name & Location: Required for local pickup transparency.
* Automatically synthesizes realistic SDG 12 environmental metrics based on selected category (e.g. e-waste avoidance for Electronics, timber preservation for Furniture).
* Calls `provider.addProduct(...)` and routes the user directly to the top of the Home feed to view their listing.

---

## 🌍 8. UN SDG 12 Relevance & Social Impact

**Goal 12: Ensure sustainable consumption and production patterns.**

1. **E-Waste & Bulky Waste Diversion:** In India alone, millions of tonnes of consumer electronics and furniture enter unregulated landfills annually. ReVive keeps functioning goods in active use.
2. **Embodied Carbon & Resource Conservation:** Manufacturing a new smartphone produces ~80 kg of CO2 equivalent and consumes precious rare-earth minerals. Choosing pre-owned prevents this upstream footprint entirely.
3. **Consumer Economy & Affordability:** Enables university students to save an average of 40%–65% on core academic essentials (textbooks, laptops, ergonomic chairs) compared to brand-new retail prices.
4. **Mindset Shift:** Introduces transparent eco-impact chips on every product card, educating users on the direct ecological benefit of their purchasing choices.

---

## 🚀 9. Setup & Running Instructions

### Prerequisites
* Flutter SDK (3.x or higher) installed and configured in PATH.
* Android Studio / VS Code with Flutter & Dart extensions.
* Connected Android device or running Android Emulator.

### Installation Steps

1. **Clone or Open the Repository:**
   ```bash
   cd c:\Users\Riyaz\OneDrive\Desktop\flutter
   ```

2. **Fetch Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Static Code Quality:**
   ```bash
   flutter analyze
   ```

4. **Run the Automated Test Suite:**
   ```bash
   flutter test
   ```

5. **Launch the Application:**
   ```bash
   # Run on connected device or emulator
   flutter run
   ```

---

## 🧪 10. Automated & Manual Test Results

### Automated Tests (`test/`)
* ✅ `product_model_test.dart`: Validates constructor, getters, discount percentage, rupee string formatting, and `copyWith`.
* ✅ `product_provider_test.dart`: Validates category filtering, multi-keyword search, favorite toggling, and new product insertion (`addProduct`).
* ✅ `widget_test.dart`: Validates startup UI rendering, bottom navigation tab switching, and Sell form validation rules.

### Manual Test Checklist
* [x] App boots into Home screen with ReVive branding and Forest Green theme.
* [x] Category selector chips filter listings instantly upon tap.
* [x] Search bar filters by keyword and shows clear 'X' button.
* [x] Tapping heart icon adds/removes item from Favorites and updates badge counter.
* [x] Tapping any product triggers smooth, fluid Hero image transition to `ProductDetailScreen`.
* [x] Product detail screen shows accurate price, savings percentage, seller card, and SDG impact.
* [x] "Contact Seller / Enquiry" opens modal with preset message chips and confirmation snackbar.
* [x] Sell form validates inputs, accepts new listing, and publishes it to the top of the feed.
* [x] Profile screen displays community eco metrics and architecture information.

---

## 🔮 11. Known Limitations & Future Enhancements

### Current Academic Boundaries
* **In-Memory Storage:** Newly created products and favorite modifications are held in memory during the active session. SQLite (`sqflite`) or `shared_preferences` can be integrated for permanent local persistence.
* **Simulated Enquiry:** The enquiry dialog demonstrates local buyer-seller workflow without an active WebSocket or Firebase messaging backend.
* **Sample Product Imagery:** Uses curated Unsplash image URLs with network caching and offline icon fallbacks.

### Roadmap / Future Scope
1. **Firebase Authentication & Cloud Firestore:** Multi-user authentication with phone OTP and persistent cloud database.
2. **In-App Buyer-Seller Chat:** Real-time messaging with push notifications via Firebase Cloud Messaging (FCM).
3. **Geo-Location Radius Filtering:** Integration with Google Maps API to filter second-hand items within walking or cycling radius of campuses.
4. **UPI Payment Escrow:** Safe tokenized payments releasing funds only upon physical item inspection.

---

## 🔗 12. Submission & Deployment Details

* **Live Web Application (GitHub Pages):** [https://riyazzshaik.github.io/Flutter_lab_project/](https://riyazzshaik.github.io/Flutter_lab_project/)
* **GitHub Repository URL:** [https://github.com/Riyazzshaik/Flutter_lab_project](https://github.com/Riyazzshaik/Flutter_lab_project)
* **Deployment Target:** GitHub Pages via official GitHub Actions artifact pipeline (`.github/workflows/deploy.yml`)
* **Student Name:** Shaik Riyaz
* **Academic Course:** Flutter Mobile Application Laboratory
* **Evaluation Total:** 25 Marks

---
*Created for the Flutter Laboratory Project Evaluation. Built with passion for sustainable software engineering.*
