import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyDJlGygkLLURxo56ty313uIo5R-IFpm0Q0',
      appId: '1:231899319276:android:158f2821685dc596f1cec9',
      messagingSenderId: '231899319276',
      projectId: 'student-information-7322e',
      storageBucket: 'student-information-7322e.firebasestorage.app',
      databaseURL:
      'https://student-information-7322e-default-rtdb.firebaseio.com');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyDJlGygkLLURxo56ty313uIo5R-IFpm0Q0',
      appId: '1:231899319276:android:158f2821685dc596f1cec9',
      messagingSenderId: '231899319276',
      projectId: 'student-information-7322e',
      storageBucket: 'student-information-7322e.firebasestorage.app',
      iosBundleId: 'com.myapp.student_information_firebase',
      databaseURL:
      'https://student-information-7322e-default-rtdb.firebaseio.com');
}