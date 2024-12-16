import 'package:blackford/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BILLING DETAILS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
             controller: controller.nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Color(0xFFB8B8B8),
                ),
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
              style: TextStyle(
                color: AppColor.darkskyblue,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
           
            SizedBox(height: 15),
            TextFormField(
             controller: controller.emailController,
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              style: TextStyle(
                color: AppColor.darkskyblue,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 32),
            Text(
              'ADDITIONAL INFORMATION',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 25),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColor.yellowish, width: 1),
                      ),
                    ),
                    child: Text(
                      'YOUR ORDER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColor.yellowish,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:  Get.find<CartController>().cartItems.length,
                    itemBuilder: (context, index ) {
                    final cartItem =  Get.find<CartController>().cartItems[index];
                    var totalPrice =
                              double.parse(cartItem.price.toString()) / 100;
                    return ListTile(
                      title: Text(
                        cartItem.name.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                         "\$${totalPrice.toStringAsFixed(2) ?? '0.00'}",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },),
                 
                  Divider(),
                  ListTile(
                    title: Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.yellowish,
                        fontSize: 18,
                      ),
                    ),
                    trailing: Text(
                    "\$${Get.find<CartController>().totalPrice.value / 100}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : () {
                          controller.createOrder();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.yellowish,
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),),
                          child: controller.isLoading.value
                          ? CircularProgressIndicator(
                            color: Colors.white,  
                          ):
                           Text(
                            'PLACE ORDER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.5,
                            ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}