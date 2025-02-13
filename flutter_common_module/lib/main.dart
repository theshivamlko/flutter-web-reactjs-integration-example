import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_module/constants/app_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/color_constants.dart';
import 'pages/pages.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: webConfig,name: "[DEFAULT]");
  } else {
    await Firebase.initializeApp(options: androidConfig,name: "[DEFAULT]");
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({required this.prefs});

  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
            prefs: this.prefs,
            firebaseFirestore: this._firebaseFirestore,
          ),
        ),
        Provider<SettingProvider>(
          create: (_) => SettingProvider(
            prefs: this.prefs,
            firebaseFirestore: this._firebaseFirestore,
            firebaseStorage: this._firebaseStorage,
          ),
        ),
        Provider<HomeProvider>(
          create: (_) => HomeProvider(
            firebaseFirestore: this._firebaseFirestore,
          ),
        ),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this._firebaseFirestore,
            firebaseStorage: this._firebaseStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: ColorConstants.themeColor,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

const webConfig = FirebaseOptions(
    apiKey: "AIzaSyAweQXnFGLTgEmU6o4y76A25TpTs31rr18",
    authDomain: "testproject-d920b.firebaseapp.com",
    projectId: "testproject-d920b",
    storageBucket: "testproject-d920b.appspot.com",
    messagingSenderId: "606983125847",
    appId: "1:606983125847:web:22147a8df6dda246bb1c12",
    measurementId: "G-DDDQMFSXCJ");

const androidConfig = FirebaseOptions(
    apiKey: "AIzaSyAZLnyBoioiYTkc4y8pZ5I88RMM4us9aEQ",
    authDomain: "testproject-d920b.firebaseapp.com",
    projectId: "testproject-d920b",
    storageBucket: "testproject-d920b.appspot.com",
    messagingSenderId: "606983125847",
    appId: '1:606983125847:android:c230f345900527b5bb1c12' );
