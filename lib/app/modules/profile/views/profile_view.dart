import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic homeController = Get.find<HomeController>().retrievedData;
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'Profile',
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Heading
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
            SizedBox(height: 20),

            // Name Field
            Text(
              'Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText: homeController['username'],
                enabled: false,
                labelStyle: TextStyle(color: Color(0xFFB8B8B8)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              style: TextStyle(color: AppColor.darkskyblue),
            ),
            SizedBox(height: 20),
            // Password Field with Change Option
            Text(
              'Password',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Stack(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "********",
                    labelStyle: TextStyle(color: Color(0xFFB8B8B8)),
                    filled: true,
                    enabled: false,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  style: TextStyle(color: AppColor.darkskyblue),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: AppColor.primarycolor,
                        context: context,                       
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password Change',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller:
                                      profileController.oldPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Enter old Password',
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: Color(0xFFB8B8B8),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Old password is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  controller:
                                      profileController.newPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Enter New Password',
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: Color(0xFFB8B8B8),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'New password is required';
                                    }
                                    if (value ==
                                        profileController
                                            .oldPasswordController.text) {
                                      return 'New password cannot be the same as old password';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters long';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  controller: profileController
                                      .confirmPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm New Password',
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: Color(0xFFB8B8B8),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.white,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm password is required';
                                    }
                                    if (value !=
                                        profileController
                                            .newPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 25),
                                Obx(() {
                                  return SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                AppColor.yellowish),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          )
                                        )        
                                      ),
                                      onPressed: () async {
                                        if (profileController.isPLoading.value)
                                          return; // Prevent multiple taps
                                        if (profileController
                                            .formKey.currentState!
                                            .validate()) {
                                          // Call the password change API
                                          profileController.changePassword(
                                            profileController
                                                .oldPasswordController.text,
                                            profileController
                                                .newPasswordController.text,
                                          );
                                        }
                                      },
                                      child: profileController.isPLoading.value
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : const Text(
                                              "Update",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: AppColor.darkskyblue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
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
