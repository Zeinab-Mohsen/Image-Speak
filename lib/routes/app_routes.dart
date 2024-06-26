import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/camera_screen/camera_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String cameraScreen = '/camera_screen';

  static const String resultPage = '/result_page';


  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    cameraScreen: (context) => CameraScreen(),
    // resultTabContainerScreen: (context) => ResultTabContainerScreen(),
    // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
