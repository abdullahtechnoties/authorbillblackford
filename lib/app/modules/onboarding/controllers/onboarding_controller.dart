import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:blackford/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: deprecated_member_use
class OnboardingController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  RxInt currentIndex = 0.obs; // Observable variable to track the current index

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      currentIndex.value =
          tabController.index; // Update current index when tab changes
    });
    super.onInit();
  }

  void completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Get.offAllNamed(Routes.LOGIN); // Redirect to login after onboarding
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
