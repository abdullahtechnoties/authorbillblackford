import 'dart:convert';
import 'package:blackford/api_key.dart';
import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  late dynamic homeController = Get.find<HomeController>().retrievedData ?? {};

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeStripe(); // Initialize Stripe during controller initialization
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Initialize Stripe with your publishable key
  Future<void> initializeStripe() async {
    Stripe.publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx'; // Replace with your actual publishable key
    await Stripe.instance.applySettings();
  }

  // Create an order in WooCommerce
  Future<void> createOrder() async {
    print("Creating Order");
    try {
      final response = await woocommerce.createOrder(
        WooOrderPayload(
          paymentMethod: 'stripe',
          paymentMethodTitle: 'Credit Card',
          setPaid: false,
          status: 'processing',
          shipping: WooOrderPayloadShipping(
            firstName: 'John',
            lastName: 'Doe',
            address1: '123 Main St',
            city: 'Anytown',
            state: 'CA',
          ),
          billing: WooOrderPayloadBilling(
            firstName: 'John',
            lastName: 'Doe',
            address1: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            phone: '123-456-7890',
            email: 'john@example.com',
            country: 'US',
          ),
          lineItems: [
            LineItems(
              productId: 1045,
              quantity: 1,
              name: 'Book 3',
              total: '10.00',
            ),
          ],
          customerId: homeController['id'],
           metaData: [
             WooOrderPayloadMetaData(
               key: '_stripe_client_secret',
             ),          
    ],
        ),
      );

      print("Order Created: $response");

      // Retrieve the Payment Intent client_secret
      await _startStripePayment(response);

    } catch (e) {
      print('Error creating order: $e');
    }
  }

Future<void> _startStripePayment(WooOrder orderResponse) async {
  try {
    // Assuming WooOrder has an `id` property
    final orderId = orderResponse.id;

    // Simulate creating a Stripe Checkout Session (or call your backend to create it)
  //  final sessionId = await createStripeCheckoutSession(orderResponse);
  print("Order Id: $orderId");
     final sessionId =  await _fetchClientSecret(orderId!.toInt());

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: sessionId, // Use your real client secret
        merchantDisplayName: 'Your Merchant Name',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    // Check payment status
    final paymentIntentStatus = await Stripe.instance.retrievePaymentIntent(sessionId!);

    if (paymentIntentStatus.status == 'succeeded') {
      // Payment successful
      print('Payment successful');
    } else {
      // Payment failed
      print('Payment failed');
    }

    print('Redirected to Stripe Checkout');
  } catch (e) {
    print('Error during Stripe payment: $e');
  }
}

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
