import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDEE_u1eJuSD-TrYltBeepqCjkEs8Ao-Ds',
    appId: '1:179669913661:web:unsikafinderweb',
    messagingSenderId: '179669913661',
    projectId: 'unsika-finder-2026',
    authDomain: 'unsika-finder-2026.firebaseapp.com',
    storageBucket: 'unsika-finder-2026.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEE_u1eJuSD-TrYltBeepqCjkEs8Ao-Ds',
    appId: '1:179669913661:android:b89fd5d5d7ea08e9429a54',
    messagingSenderId: '179669913661',
    projectId: 'unsika-finder-2026',
    storageBucket: 'unsika-finder-2026.firebasestorage.app',
  );
}
