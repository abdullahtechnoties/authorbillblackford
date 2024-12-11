import 'package:blackford/app/modules/account/views/account_view.dart';
import 'package:blackford/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:blackford/app/modules/cart/views/cart_view.dart';
import 'package:blackford/app/modules/home/views/home_view.dart';
import 'package:blackford/app/modules/search_product/views/search_product_view.dart';
import 'package:blackford/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavView extends GetView<BottomNavController> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, controller) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            backgroundColor: AppColor.darkskyblue,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: AppColor.dark,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.book,
                    size: 20.0,
                  ),
                ),
                label: 'Books',
                backgroundColor: AppColor.dark,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 20.0,
                  ),
                ),
                label: 'Cart',
                backgroundColor: AppColor.dark,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.person,
                    size: 20.0,
                  ),
                ),
                label: 'Profile',
                backgroundColor: AppColor.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final LandingPageController landingPageController =
    //     Get.put(LandingPageController(), permanent: false);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationMenu(context, controller),
        body: Obx(
          () => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomeView(),
              SearchProductView(),
              CartView(),
              AccountView(),
            ],
          ),
        ),
      ),
    );
  }
}
