import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seesights/firebase_options.dart';
import 'package:seesights/pages/authentication_repository.dart';
import 'package:seesights/pages/search_flight.dart';
import 'package:seesights/pages/splash_screen.dart';
import 'package:seesights/theme.dart';
import 'package:seesights/pages/greeting_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthenticationRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
