import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ImageSpeak/routes/app_routes.dart';
import 'package:ImageSpeak/theme/theme_helper.dart';

import 'core/utils/size_utils.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
late List<CameraDescription> cameras;

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.white, // Set the status bar color
    statusBarIconBrightness: Brightness.dark, // Set the status bar icon color to dark
    statusBarBrightness: Brightness.light, // For iOS, this controls the status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'Image Speak',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
