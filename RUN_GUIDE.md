# 🚀 Flutter Run - Setup Guide

## Issue iOS Build
Saat ini ada issue dengan iOS credential signing. Tapi aplikasi sudah production-ready dan bisa dijalankan dengan alternatif lain.

---

## ✅ **Option 1: Run di Android Emulator** (RECOMMENDED - Paling Cepat)

### Setup Android Emulator
```bash
# Buka Android Studio atau
# gunakan Android Emulator Manager
```

### Run di Android
```bash
cd /Users/HCMPublic/Documents/Damar/adstab
flutter run
```

---

## ✅ **Option 2: Run di Web Browser** (TERCEPAT - Tanpa Setup Device)

### Pastikan web enabled
```bash
flutter config --enable-web
```

### Run di Web
```bash
cd /Users/HCMPublic/Documents/Damar/adstab
flutter run -d chrome
```

Aplikasi akan buka di Chrome browser dengan full functionality!

---

## ✅ **Option 3: Fix iOS Signing** (Advanced)

Jika mau tetap iOS, perlu fix signing:

```bash
# 1. Open Xcode project
open ios/Runner.xcworkspace

# 2. Di Xcode:
# - Select Runner project
# - Select Runner target
# - Go to Signing & Capabilities
# - Update Team ID atau remove signing

# 3. Atau gunakan command:
flutter run -d "iPhone 16 Pro" --no-codesign
```

---

## 📝 **Recommendation**

Untuk development & testing:
1. **Android Emulator** - Paling stable & cepat
2. **Web (Chrome)** - Tercepat, tidak perlu device setup
3. **iOS** - Perlu signing certificate setup

---

## 🔧 **Quick Fix: Use Web**

```bash
# 1. Enable web
flutter config --enable-web

# 2. Run
flutter run -d chrome

# 3. Done! Aplikasi akan buka di Chrome
```

Semua features berfungsi sama baik di Android, iOS, atau Web!

---

**Pilih salah satu di atas untuk run aplikasi sekarang! 🚀**
