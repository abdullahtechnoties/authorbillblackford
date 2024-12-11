import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    late dynamic homeController = Get.find<HomeController>().retrievedData ?? {};
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: Container(child: Image.asset('assets/images/Logo.png', fit: BoxFit.cover,),),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              homeController != null && homeController['username'] != null ? homeController['username'] : "No username",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
            Text(
             homeController != null && homeController['email'] != null ? homeController['email'] : "No email",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.white,
              ),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/profile');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColor.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: AppColor.white),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed('/checkout');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColor.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: AppColor.white),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/privacy-policy');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: AppColor.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: AppColor.white),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/terms-of-service');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: AppColor.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Terms of Service',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
