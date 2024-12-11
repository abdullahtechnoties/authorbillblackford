import 'package:blackford/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  // Retrieve shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if the user is logged in
  String jsonData = prefs.getString('userrecord') ?? '';
  bool isLogin = jsonData.isNotEmpty;

  // Check if this is the first time the user has launched the app
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // Set initial route based on the conditions
  String initialRoute;
  if (isFirstTime) {
    // If it's the user's first time, redirect them to the welcome screen
    initialRoute = '/onboarding';
    prefs.setBool('isFirstTime', false);  // Update that it's no longer the first time
  } else if (isLogin) {
    // If the user is logged in, redirect them to the home screen
    initialRoute = '/bottom-nav';
  } else {
    // Otherwise, direct them to the login screen
    initialRoute = '/login';
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blackford",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: AppColor.primarycolor,
        textTheme: GoogleFonts.interTextTheme(
          Get.theme.textTheme
              .apply(bodyColor: AppColor.white, displayColor: AppColor.white),
        ),
      ),
    ),
  );
}
