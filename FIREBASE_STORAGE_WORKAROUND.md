# Firebase Storage Workaround

## Issue

Firebase Storage requires upgrading from Spark (free) to Blaze (pay-as-you-go) plan as of September 2024. Attempting to upload files to Storage on a Spark plan results in HTTP 402 errors.

## Current Solution

The app now stores images as **base64-encoded strings directly in Firestore** as a temporary workaround. This allows uploads to work on the free Spark plan.

### Limitations

- **Document Size Limit**: Firestore has a 1MB document size limit. Each Parah document can store approximately 10-15 small images.
- **Performance**: Base64 decoding happens on each view, which is slower than network image loading from Storage.
- **Bandwidth**: Base64 data is ~33% larger than binary data.

### Files Modified

- `lib/screens/quranScreen/quran-e-aziz/add_parah_screen.dart`: Converts images to base64 before Firestore upload
- `lib/screens/quranScreen/quran-e-aziz/parah-detail/parah-detail-page.dart`: Decodes base64 strings back to images for display
- `pubspec.yaml`: Removed `firebase_storage` dependency

## Recommended Production Solution

**Upgrade Firebase to Blaze plan** to use Firebase Storage properly:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (`quran-e-aziz-8ee51`)
3. Navigate to **Project Settings → Usage and Billing**
4. Click **Modify Plan** → **Upgrade to Blaze**
5. Set a budget alert to avoid unexpected charges

### Once Upgraded

Revert to Firebase Storage by:

1. Adding `firebase_storage: ^12.3.3` back to `pubspec.yaml`
2. Restoring the original upload code that uses `FirebaseStorage.instance.ref().child(...).putFile()`
3. Updating the detail page to load from network URLs instead of decoding base64

### Cost Estimate (Blaze Plan)

- Storage: $0.026/GB/month
- Download: $0.12/GB
- Upload: $0.05/GB
- Example: 1000 Parah images (~500MB) + 10,000 downloads/month ≈ $1-2/month
