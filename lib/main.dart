import 'package:flutter/material.dart';
import 'package:techdaily/screens/content_list_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:techdaily/services/firebase_signin.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirebaseSignIn(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Techs',
        // home: ContentListScreen(),
        home: AnimatedSplashScreen(
          duration: 2500,
          splash: 'assets/images/techlogo.png',
          nextScreen: ContentListScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}