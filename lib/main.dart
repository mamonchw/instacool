import 'package:flutter/material.dart';
import 'package:url_navigation_web/LandingPage.dart';
import 'package:url_navigation_web/Routes.dart';
import 'package:url_navigation_web/SplashScreen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(MyApp()
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
    void initState() {
      super.initState();
      Flurorouter.setupRouter();
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
    );
  }
}

// now we have to initialise the router....

// thats it...all things are done now i think... :)
