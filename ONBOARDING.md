# 🎓 Developer Onboarding Checklist

## Welcome to Ads & Promotions App! 👋

Ikuti checklist ini untuk memahami codebase dan siap untuk development.

---

## Phase 1: Understanding (30 minutes)

- [ ] **Baca README.md** (5 min)
  - Overview fitur utama
  - Quick start guide
  - Documentation links

- [ ] **Baca DOCUMENTATION.md** (5 min)
  - Documentation index
  - File organization
  - Learning path

- [ ] **Baca PROJECT_SUMMARY.md** (10 min)
  - Features completed
  - Architecture overview
  - Project structure

- [ ] **Lihat DIAGRAMS.md** (10 min)
  - Navigation flow
  - State management architecture
  - Data relationships
  - Screen hierarchy

---

## Phase 2: Setup (15 minutes)

- [ ] **Install Flutter**
  ```bash
  # Verify Flutter installed
  flutter --version
  ```

- [ ] **Clone/Open Project**
  ```bash
  cd adstab
  ```

- [ ] **Install Dependencies**
  ```bash
  flutter pub get
  ```

- [ ] **Run on Device/Emulator**
  ```bash
  flutter run
  ```

- [ ] **Verify App Running**
  - Lihat carousel dengan 6 sample ads
  - Tap untuk navigate ke detail screen
  - Verify metrics displayed

---

## Phase 3: Code Exploration (30 minutes)

- [ ] **Explore Folder Structure**
  ```
  lib/
  ├── main.dart                    (Entry point)
  ├── models/                      (Data models)
  ├── providers/                   (State management)
  ├── screens/                     (UI screens)
  ├── widgets/                     (Components)
  ├── services/                    (Business logic)
  ├── constants/                   (Constants)
  └── utils/                       (Utilities)
  ```

- [ ] **Read main.dart**
  - MultiProvider setup
  - Route configuration
  - Theme configuration

- [ ] **Explore Models** (lib/models/)
  - [ ] Read `advertisement.dart` - Main ads model
  - [ ] Read `vendor.dart` - Vendor information
  - [ ] Read `interaction.dart` - Tracking & analytics models

- [ ] **Explore Providers** (lib/providers/)
  - [ ] Read `ads_provider.dart` - Ads state management
  - [ ] Read `analytics_provider.dart` - Analytics state

- [ ] **Explore Screens** (lib/screens/)
  - [ ] Read `ads_tab_screen.dart` - Main carousel & list
  - [ ] Read `ad_detail_screen.dart` - Detail screen

- [ ] **Explore Widgets** (lib/widgets/)
  - [ ] Read `ads_carousel.dart` - Carousel component
  - [ ] Read `ad_carousel_card.dart` - Card design
  - [ ] Read `analytics_indicator.dart` - Metrics display

- [ ] **Explore Services** (lib/services/)
  - [ ] Read `ads_service.dart` - Mock data
  - [ ] Read `analytics_service.dart` - Tracking logic

---

## Phase 4: Deep Understanding (45 minutes)

- [ ] **Read ARCHITECTURE.md** (30 min)
  - System design
  - Dependency list
  - Architecture patterns
  - Usage examples
  - Customization guide

- [ ] **Read MODELS.md** (15 min)
  - Detailed model descriptions
  - Enums & relationships
  - JSON serialization examples
  - Computed properties

---

## Phase 5: Analytics Understanding (30 minutes)

- [ ] **Read ANALYTICS.md** (30 min)
  - Tracking system overview
  - 8 interaction types
  - Metrics calculation
  - AnalyticsProvider API
  - Implementation examples

---

## Phase 6: Quick Reference (15 minutes)

- [ ] **Read QUICKSTART.md** (15 min)
  - Common tasks
  - Navigation
  - State management usage
  - Debugging tips
  - Performance tips

---

## Phase 7: Feature Testing (20 minutes)

**Test setiap fitur dengan mock data:**

- [ ] **Carousel**
  - [ ] Auto-scroll working
  - [ ] Manual swipe working
  - [ ] Indicator dots updating
  - [ ] Tap untuk navigate to detail

- [ ] **List View**
  - [ ] Toggle view button working
  - [ ] Scroll smooth
  - [ ] Tap untuk navigate to detail

- [ ] **Detail Screen**
  - [ ] Image gallery showing
  - [ ] Multiple images loading
  - [ ] Vendor info displayed
  - [ ] Promo code visible
  - [ ] Analytics metrics showing
  - [ ] Buttons functioning

- [ ] **Search & Filter**
  - [ ] Search bar working
  - [ ] Results filtering correctly
  - [ ] Category filter working
  - [ ] Reset filters button working

- [ ] **Favorites**
  - [ ] Heart button toggle
  - [ ] Favorites tab showing
  - [ ] State persisting (during session)

- [ ] **Tabs**
  - [ ] All tab showing all ads
  - [ ] Trending tab showing trending ads
  - [ ] Favorites tab showing only favorites

---

## Phase 8: Code Understanding Tasks

**Lakukan tasks ini untuk deeper understanding:**

- [ ] **Task 1: Trace Ad Loading**
  - [ ] Open `ads_tab_screen.dart`
  - [ ] Find `_loadAds()` method
  - [ ] Trace flow to `AdsProvider.loadAds()`
  - [ ] Trace to `AdsService.getAllAds()`
  - [ ] Understand mock data loading

- [ ] **Task 2: Understand State Management**
  - [ ] Open `main.dart`
  - [ ] Understand MultiProvider setup
  - [ ] Open `ads_provider.dart`
  - [ ] Understand ChangeNotifier implementation
  - [ ] See how state updates UI

- [ ] **Task 3: Trace Analytics**
  - [ ] Open `ad_carousel_card.dart`
  - [ ] Find favorite button callback
  - [ ] Trace `trackAdFavorite()` call
  - [ ] Go to `analytics_provider.dart`
  - [ ] Understand tracking implementation

- [ ] **Task 4: Find Data Flow**
  - [ ] Pick one ad dari carousel
  - [ ] Trace data flow dari AdsService
  - [ ] Through provider
  - [ ] To widget display
  - [ ] Document the flow

- [ ] **Task 5: Understand Analytics Metrics**
  - [ ] Read `analytics_service.dart`
  - [ ] Find `getAdAnalytics()` method
  - [ ] Understand metric calculation
  - [ ] Check engagement rate formula
  - [ ] Check CTR calculation

---

## Phase 9: Hands-On (30 minutes)

**Try modifying code:**

- [ ] **Change App Title**
  - [ ] Open `main.dart`
  - [ ] Change `title: 'Ads & Promotions'`
  - [ ] Hot reload & verify

- [ ] **Change Primary Color**
  - [ ] Open `lib/constants/colors.dart`
  - [ ] Modify `primary` color
  - [ ] Hot reload & verify

- [ ] **Change Carousel Auto-scroll Duration**
  - [ ] Open `lib/widgets/ads_carousel.dart`
  - [ ] Find `autoPlayInterval`
  - [ ] Change duration
  - [ ] Hot reload & verify

- [ ] **Add Console Logging**
  - [ ] Open `ads_provider.dart`
  - [ ] Add `print()` di `loadAds()`
  - [ ] Run & check console
  - [ ] Understand flow

- [ ] **Modify Mock Data**
  - [ ] Open `ads_service.dart`
  - [ ] Change discount percentage
  - [ ] Add/remove ads
  - [ ] Hot reload & verify

---

## Phase 10: Integration Prep (15 minutes)

- [ ] **Understand Current Implementation**
  - [ ] Mock data in `AdsService`
  - [ ] In-memory analytics in `AnalyticsService`

- [ ] **Know What to Change for API**
  - [ ] `AdsService.getAllAds()` - Replace dengan API call
  - [ ] `AnalyticsService.trackInteraction()` - Send to server
  - [ ] Add error handling
  - [ ] Add retry logic

- [ ] **Read Integration Tips**
  - [ ] QUICKSTART.md - Connect to Real API section
  - [ ] ARCHITECTURE.md - Customization section

---

## Phase 11: Documentation Review (10 minutes)

- [ ] **Know Where to Find Info**
  - [ ] For general questions → README.md
  - [ ] For data models → MODELS.md
  - [ ] For analytics → ANALYTICS.md
  - [ ] For architecture → ARCHITECTURE.md
  - [ ] For quick tasks → QUICKSTART.md
  - [ ] For visual reference → DIAGRAMS.md

- [ ] **Bookmark Important Files**
  - [ ] Code structure → lib/ folder
  - [ ] Models → lib/models/index.dart (exports)
  - [ ] Providers → lib/providers/index.dart (exports)
  - [ ] Services → lib/services/index.dart (exports)

---

## ✅ Final Checklist

- [ ] Understand app architecture
- [ ] Know project structure
- [ ] Can navigate codebase
- [ ] Understand state management
- [ ] Know how analytics works
- [ ] Can modify & test code
- [ ] Know where to find documentation
- [ ] Ready to integrate with API
- [ ] Ready to add features
- [ ] Ready to deploy! 🚀

---

## 🎓 Learning Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Provider Package**: https://pub.dev/packages/provider
- **Dart Language**: https://dart.dev/guides

---

## 🤔 Common Questions

**Q: Dari mana saya mulai?**
A: Phase 1 - Understanding (baca dokumentasi)

**Q: Bagaimana cara navigate codebase?**
A: Phase 2-3 - Setup & Code Exploration

**Q: Gimana cara track analytics?**
A: Phase 5 - Analytics Understanding

**Q: Gimana cara add feature baru?**
A: ARCHITECTURE.md - Customization section

**Q: Gimana cara integrate dengan API?**
A: QUICKSTART.md - Connect to Real API

---

## 📞 Support

Jika ada pertanyaan:
1. Check relevant documentation file
2. Search in code comments
3. Read related issues in code
4. Ask team lead

---

## 🎉 You're Ready!

Setelah menyelesaikan semua phase di checklist ini, Anda siap untuk:
✅ Understand codebase  
✅ Modify & extend features  
✅ Integrate dengan API  
✅ Add new functionality  
✅ Deploy ke production  

**Happy Coding! 🚀**

---

**Estimated Time**: 4-5 jam untuk complete

**Progress Tracking**: Update checklist saat progress

**Next Step**: Choose your first task & start coding!
