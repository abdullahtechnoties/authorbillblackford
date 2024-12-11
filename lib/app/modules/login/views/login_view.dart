import 'package:blackford/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import 'package:flutter/cupertino.dart';

class LoginView extends GetView<LoginController> {
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        CupertinoIcons.hand_raised,
                        color: Color(0xFFFFCF4D),
                        size: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Sign in to your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: controller.email.value,
                          decoration: InputDecoration(
                            labelText: "Your Email",
                            labelStyle: TextStyle(
                              color: Color(0xFFB8B8B8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          style: TextStyle(
                            color: AppColor.darkskyblue,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => TextFormField(
                            controller: controller.password.value,
                            decoration: InputDecoration(
                              labelText: "Your Password",
                              labelStyle: TextStyle(
                                color: Color(0xFFB8B8B8),
                              ),
                              filled: true,
                              fillColor: AppColor.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: AppColor.darkskyblue,
                                      ),
                                      onPressed: () {
                                        controller.togglePasswordVisibility();
                                      },
                                    ),),
                               obscureText: !controller.isPasswordVisible.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  } else if (value.length < 8) {
                                    return "Password must be at least 8 characters long";
                                  }
                                  return null;
                                },
                            style: TextStyle(
                              color: AppColor.darkskyblue,
                            ),                         
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed('/forgot-password');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),                      
                         Obx(() => SizedBox(
                            width: Get.width,
                          height: 50,
                           child: ElevatedButton(
                                 onPressed: controller.loader.value
                                     ? null // Disable button when loading
                                     : () {
                                         if (_formKey.currentState!.validate()) {
                                           controller.loginCustomer();
                                         }
                                       },
                                 style: ButtonStyle(
                                   shape: WidgetStateProperty.all<
                                       RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(8.0),
                                     ),
                                   ),
                                   backgroundColor:
                                       WidgetStateProperty.resolveWith<Color>(
                                     (Set<WidgetState> states) {
                                       if (states.contains(WidgetState.disabled)) {
                                         return const Color.fromARGB(255, 155, 149, 97); 
                                       }
                                       return AppColor.yellowish; // Enabled button color
                                     },
                                   ),
                                   foregroundColor:
                                       WidgetStateProperty.all(Colors.white),
                                 ),                      
                                 child: controller.loader.value
                                     ? const SizedBox(
                                         height: 30,
                                         width: 30,
                                         child: CircularProgressIndicator(
                                           strokeWidth: 3,
                                           color: Colors.black,
                                         ),
                                       )
                                     : const Text(
                                         'Sign in',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                               ),
                         )),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/signup');
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColor.white,
                                thickness: 1,
                                endIndent: 15,
                              ),
                            ),
                            Text(
                              " Or with ",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColor.white,
                                thickness: 1,
                                indent: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            './assets/images/google-icon.png',
                            height: 25,
                            width: 25,
                          ),
                          label: Text(
                            " Sign in with Google",
                            style: TextStyle(color: AppColor.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(60),
                            backgroundColor: AppColor.primarycolor,
                            side: BorderSide(color: AppColor.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/apple-icon.png',
                            height: 25,
                            width: 25,
                          ),
                          label: Text(
                            " Sign in with Apple",
                            style: TextStyle(color: AppColor.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(60),
                            backgroundColor: AppColor.primarycolor,
                            side: BorderSide(color: AppColor.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
