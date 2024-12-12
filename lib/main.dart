import 'package:blackford/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
    try {
    // Initialize Stripe
    Stripe.publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
    await Stripe.instance.applySettings();

    // Retrieve shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString('userrecord') ?? '';
    bool isLogin = jsonData.isNotEmpty;
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    String initialRoute;
    if (isFirstTime) {
      initialRoute = '/onboarding';
      prefs.setBool('isFirstTime', false);
    } else if (isLogin) {
      initialRoute = '/bottom-nav';
    } else {
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
  } catch (e) {
    print("Error during Stripe initialization: $e");
  }
}