import 'package:animate_splash/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        //statusBar
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        //navigationBar color
        systemNavigationBarColor: Colors.transparent, //bottom bar color
        systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
      )
    );
    //Orientations configs of app
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //Hide the navigationBar
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,      
      theme: ThemeData(
      ),
      home: SplashScreen(
        imgPath: 'images/logo_dribble.png'
      ),
    );
  }
}