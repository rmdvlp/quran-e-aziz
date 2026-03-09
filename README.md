# Quran-e-Aziz

Quran-e-Aziz is a Flutter Islamic app that combines Quran-related content, Hadith, Ibadat utilities, and guidance tools like Qibla direction and prayer timings.

## Overview

- **Framework:** Flutter (Dart)
- **State management:** `flutter_bloc`
- **Backend:** Firebase (`firebase_core`, `firebase_auth`, `cloud_firestore`)
- **Authentication:** Email/Password + Google Sign-In
- **Primary content source:** Firestore (dynamic content and links)

## Features

### 1) Onboarding & Authentication

- Intro slider shown on first launch (`shared_preferences` flag `seenIntro`)
- Splash screen with auto-login logic
- Email/password sign up and login
- Google sign-in
- Logout from drawer

### 2) Home Dashboard

- Loads quote/image cards from Firestore collection `quotesImages`
- Tap any card to open full-screen zoom view (`PhotoView`)
- Responsive layout (mobile and large screen variants)

### 3) Quran Module

- **Quran-e-Aziz**
  - Lists Parahs from Firestore collection `quran-e-aziz`
  - Open Parah details with lazy-loaded pages and zoom (`InteractiveViewer`)
  - Add new Parah with multiple images (admin/content upload flow)
- **Serat-un-Nabi**
  - Fetches remote PDF URL from Firestore
  - Downloads locally via `dio` and renders in `flutter_pdfview`
- **Khatm-ul-Quran Dua**
  - Loads and displays dua image from Firestore

### 4) Hadith Module

- Hadith categories loaded from Firestore collection `ahadiths`
- Category detail screen fetches PDF URLs for supported collections
- Current detail screen UI shows placeholder text (`No Data found`) while PDF view code is present but commented

### 5) Ibadat Module

- **Prayer Timings**
  - Calculates daily prayer times using `adhan`
  - Uses fixed coordinates (currently Lahore: 31.5204, 74.3587)
- **Fasting Dua**
  - Displays fasting dua image from Firestore
- **Hajj / Umrah**
  - Downloads and opens PDF guidance
- **Namaz-e-Janaza**
  - Displays Janaza dua/instruction image from Firestore
- **Tasbih Counter**
  - Select target (33 / 100 / 1000)
  - Full-screen tap counter with completion state and reset

### 6) More Module

- **Biography**
  - Downloads and opens scholar biography PDF
- **Qibla Direction**
  - Uses sensors + location permission to show live Qibla compass
  - Handles disabled location/permanent permission denial gracefully
- **About Us**
  - About screen exists in codebase, but navigation from More menu is currently commented out

### 7) Navigation & UX

- Animated bottom navigation for primary sections
- Drawer with contact and logout actions
- Adaptive behavior for wider layouts

---

## Project Structure (Important Paths)

- `lib/main.dart` – app bootstrap, Firebase init, intro/splash flow
- `lib/screens/` – all main modules (Quran, Hadith, Ibadat, More, Auth)
- `lib/widgets/navBar.dart` – bottom navigation shell
- `lib/services/auth.dart` – Google sign-in flow
- `lib/firebase_options.dart` – FlutterFire generated config

---

## Prerequisites

Install:

1. Flutter SDK (stable, Dart >= 3.3.0)
2. Xcode (for iOS/macOS), Android Studio (for Android)
3. CocoaPods (`sudo gem install cocoapods`) for iOS/macOS
4. Firebase project access (for auth + Firestore content)

Verify setup:

```bash
flutter --version
flutter doctor
```

---

## Firebase Setup

This app requires Firebase to work.

1. Ensure these files exist and match your Firebase project:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
2. Confirm `lib/firebase_options.dart` is generated for your project.
3. In Firebase Console, enable:
   - Authentication (Email/Password + Google)
   - Cloud Firestore

### Firestore Notes

- App content (Quran pages metadata, hadith categories, dua links, etc.) is fetched from Firestore collections.
- Read/write behavior depends on your Firebase rules and signed-in user state.

### Firestore Collections Reference

Use this as a quick backend setup checklist.

| Collection        | Document ID(s) used in app                         | Expected fields                                                                                             | Used by                                     |
| ----------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| `quotesImages`    | `mHSlN67s3G910ChbUC9N`                             | `image1`, `image2`, ... (string URL)                                                                        | Home dashboard quotes/images                |
| `quran-e-aziz`    | Dynamic (Parah name-based doc id), plus list query | `name` (string), `documentId` (string), `timestamp` (int), `image-1`, `image-2`, ... (base64 string or URL) | Quran-e-Aziz list, add Parah, Parah details |
| `serat-ul-Nabi`   | `J9reqGaAxCrPfEL0yWzn`                             | `sarat-ul-NabiUrl` (string URL)                                                                             | Serat-un-Nabi PDF screen                    |
| `duaKhatmulQuran` | `dH2pcMF6R7eO70n9Ipdk`                             | `duaKhatmulQuranUrl` (string URL)                                                                           | Khatm-ul-Quran dua screen                   |
| `ahadiths`        | Dynamic (multiple docs)                            | `hadithImage` (string URL)                                                                                  | Hadith categories grid                      |
| `sahiBukhari`     | `whQsi9ZLDeped4HZMDZY`                             | `sahiBukhariUrl` (string URL)                                                                               | Hadith details                              |
| `sahiMuslim`      | `VyoFNGWcPGh4HQB2HXz2`                             | `sahiMuslimUrl` (string URL)                                                                                | Hadith details                              |
| `jamiaTirmizi`    | `XhFhCTyFO8FAEU3a65vl`                             | `jamiaTirmiziUrl` (string URL)                                                                              | Hadith details                              |
| `fastingDua`      | `oUcKxaepnGQMHqmeCK6R`                             | `fastingDuaUrl` (string URL)                                                                                | Fasting dua screen                          |
| `hajj-o-umrah`    | `n1Y0YUeBk4AqLTW8V21c`                             | `hajj-o-umrahUrl` (string URL)                                                                              | Hajj/Umrah PDF screen                       |
| `nmaz-e-janaza`   | `POVb3J9VlrDNLRdf0FJo`                             | `nmaz-e-jnazaUrl` (string URL)                                                                              | Namaz-e-Janaza screen                       |
| `hazratBioGraphy` | `eAPwInOypx53eNi5MlP3`                             | `bioGraphyUrl` (string URL)                                                                                 | Biography PDF screen                        |

#### Notes

- `quran-e-aziz` is both **content list** and **content details** collection.
- For `quran-e-aziz` ordering, `timestamp` is required because list view uses `.orderBy('timestamp')`.
- Hadith detail mapping is currently title-based in code (Arabic titles route to `sahiBukhari`, `sahiMuslim`, `jamiaTirmizi`).
- Missing docs/fields in any of the above collections can cause loader-only behavior or empty screens.

### Firestore Seed Template (Ready to Import)

Included files:

- `scripts/firestore_seed_template.json` – full collection/doc template matching app expectations
- `scripts/seed_firestore.js` – Node script that imports the JSON into Firestore

1. Install seeder dependency:

```bash
npm install firebase-admin
```

2. Authenticate with Google Cloud (Application Default Credentials):

```bash
gcloud auth application-default login
```

3. Set your Firebase project ID:

```bash
export FIREBASE_PROJECT_ID="your-project-id"
```

4. Import seed data:

```bash
node scripts/seed_firestore.js scripts/firestore_seed_template.json
```

> The script uses `merge: true`, so it updates/creates docs without deleting other fields.

### Storage Workaround (Important)

This project currently stores uploaded Parah images as **base64 strings in Firestore** (instead of Firebase Storage) to support Spark/free-plan constraints. See:

- `FIREBASE_STORAGE_WORKAROUND.md`

---

## How to Run the Project

From project root:

```bash
flutter pub get
```

### Run on Android

```bash
flutter run -d android
```

### Run on iOS (macOS only)

```bash
cd ios && pod install && cd ..
flutter run -d ios
```

### Run on Web

```bash
flutter run -d chrome
```

### Build APK (release)

```bash
flutter build apk --release
```

---

## Useful Development Commands

```bash
flutter analyze
flutter test
```

---

## Known Limitations

- Hadith detail screen currently displays placeholder text while PDF viewer is present but disabled in UI.
- `About Us` screen is implemented but not currently linked from More menu.
- Prayer timings use fixed coordinates (not GPS-based yet).
- Base64 image storage in Firestore has document-size/performance limits.

---

## Troubleshooting

### Firebase auth/content not loading

- Check Firebase config files are present and correct.
- Confirm your Firebase project has required auth providers enabled.
- Verify Firestore documents/collections expected by app exist.

### Google sign-in fails on Android

- Verify SHA fingerprints are added in Firebase project settings.
- Re-download `google-services.json` if needed.

### iOS build issues

```bash
cd ios
pod repo update
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

---

## Tech Stack

- Flutter, Dart
- Firebase Auth
- Cloud Firestore
- BLoC (`flutter_bloc`)
- `dio`, `flutter_pdfview`, `photo_view`, `adhan`, `geolocator`, `smooth_compass`

---

## Maintainers

Team details are available in the `About Us` module data.
