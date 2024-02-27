import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig{
  static FirebaseOptions get platformOptions{
    if(Platform.isIOS){
      return const FirebaseOptions(
        apiKey: 'YOUR_KEY', 
        appId: 'YOUR_KEY', 
        messagingSenderId: 'YOUR_KEY', 
        projectId: 'YOUR_KEY',
        iosBundleId: 'YOUR_KEY',
        );
    }
    else{
      return const FirebaseOptions(
        apiKey: 'YOUR_KEY', 
        appId: 'YOUR_KEY', 
        messagingSenderId: 'YOUR_KEY', 
        projectId: 'YOUR_KEY'
        );
    }
  }
}