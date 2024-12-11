import 'package:blackford/app/modules/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

// ignore: must_be_immutable
class SignupView extends GetView<SignupController> {
  SignupView({Key? key}) : super(key: key);

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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Create account and choose favorite menu",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: controller.name.value,
                          decoration: InputDecoration(
                            labelText: "Your Name",
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
                                vertical: 16, horizontal: 15),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          style: TextStyle(
                            color: AppColor.darkskyblue,
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
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
                            fillColor: AppColor.white,
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
                        Obx(() =>
                          TextFormField(
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
                                  vertical: 16, horizontal: 20),
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
                        SizedBox(height: 30),
                     
                         SizedBox(
                           width: Get.width,
                          height: 50,
                          child: Obx(
                            () => ElevatedButton(
                               onPressed: controller.loader.value
                                    ? null // Disable button when loading
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          controller.createCustomer();
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
                                      return AppColor.yellowish; 
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
                                        'Sign up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              )),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an Account?",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60, left: 60, bottom: 50),
                child: Text(
                  "By signing up, you agree to our Terms of Service and Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
