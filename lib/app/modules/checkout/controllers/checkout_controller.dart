import 'dart:convert';
import 'package:blackford/api_key.dart';
import 'package:blackford/app/modules/cart/controllers/cart_controller.dart';
import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:blackford/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  late dynamic homeController = Get.find<HomeController>().retrievedData ?? {};
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  RxBool isLoading = false.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>().retrievedData;
    
    nameController.text = homeController['username'] ?? '';
    emailController.text = homeController['email'] ?? '';
    
  }

  @override
  void onReady() {
    super.onReady();
  }

  

  Future<void> createOrder() async {
    print("Creating Order");
    isLoading.value = true;
    try {
      var cartItems = Get.find<CartController>().cartItems;
  // Create an order in WooCommerce
       final lineItems = cartItems.map((item) {
      return LineItems(
        productId: item.id, // Assuming you have a productId in your WooCartItems
        quantity: item.quantity,
        total: item.linePrice.toString(), // Assuming you have a totalPrice field
        subtotal: item.linePrice.toString(), // Assuming you have a price field
      );
    }).toList();

      final response = await woocommerce.createOrder(
        WooOrderPayload(
          paymentMethod: 'cash',
          paymentMethodTitle: 'Cash on Delivery',
          setPaid: false,
          status: 'processing',
          shipping: WooOrderPayloadShipping(
            firstName: nameController.text,
            lastName: '',
            address1: addressController.text,
            city: cityController.text,
            state: stateController.text,
          ),
          billing: WooOrderPayloadBilling(
            firstName: nameController.text,
            lastName: '',
            address1: addressController.text,
            city: cityController.text,
            state: stateController.text,
            phone: phoneController.text,
            email: emailController.text,
            country: countryController.text,
          ),
          lineItems: [
            // add cart items
            ...lineItems
          ],
          customerId: homeController['id'],
  
        ),
      );
      isLoading.value = false;
      print("Order Created: $response");
       Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            elevation: 5,
            backgroundColor: AppColor.white,
            title:  Text('Order Placed', style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.brown)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lottie.asset(
                //   'assets/images/Animation.json',
                //   width: 150,
                //   height: 150,
                // ),
               
                Text(
                  "Your order has been placed successfully.",
                  style: TextStyle(color: AppColor.darkskyblue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SelectableText(
                 "Your Order# is: ${response.orderKey}",
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    color: AppColor.darkskyblue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(               
                  style: ElevatedButton.styleFrom(                 
                    backgroundColor: AppColor.yellowish,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async{                  
                    await woocommerce.deleteAllMyCartItems();
                    cartItems.clear();
                    nameController.clear();
                    emailController.clear();
                    Get.offAllNamed("/bottom-nav");
                  },
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
                  ),
                                ),
                ),
              ],
            ),
           
          ),
        );
      // Retrieve the Payment Intent client_secret
     // await _startStripePayment(response);

    } catch (e) {
      print('Error creating order: $e');
    }
    finally {
      isLoading.value = false;
    }
  }

// ignore: unused_element


  // Fetch the Payment Intent client_secret from WooCommerce
  Future<String?> _fetchClientSecret(int orderId) async {
    final url = 'https://authorbillblackford.com/wp-json/wc/v3/orders/$orderId';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('${woocommerce.consumerKey}:${woocommerce.consumerSecret}'))}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final metadata = data['meta_data'] as List<dynamic>;
      final clientSecretEntry = metadata.firstWhere(
        (meta) => meta['key'] == '_stripe_client_secret',
        orElse: () => null,
      );
      return clientSecretEntry?['value'];
    } else {
      print("Failed to fetch order details: ${response.statusCode} ${response.body}");
      return null;
    }
  }

  // Update WooCommerce order status
  // ignore: unused_element
  Future<void> _updateOrderStatus(int orderId, String status) async {
    final url = 'https://authorbillblackford.com/wp-json/wc/v3/orders/$orderId';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('${woocommerce.consumerKey}:${woocommerce.consumerSecret}'))}',
        'Content-Type': 'application/json',
      },
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      print("Order status updated to $status");
    } else {
      print("Failed to update order status: ${response.statusCode} ${response.body}");
    }
  }
}
