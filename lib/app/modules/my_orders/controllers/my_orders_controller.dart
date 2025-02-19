import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blackford/api_key.dart';
import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_wp_woocommerce/models/order.dart';

import 'package:get/get.dart';

class MyOrdersController extends GetxController {
final RxList<WooOrder> allorders = <WooOrder>[].obs;
  late dynamic homeController = Get.find<HomeController>().retrievedData ?? {};
  late int customer_id;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    homeController = Get.find<HomeController>().retrievedData;
    customer_id = homeController['id'];
    print("Customer ID: $customer_id");
    getOrders();
  }

  Future<void> getOrders() async {
      try {
        isLoading.value = true;
        final response = await http.get(Uri.parse("${woocommerce.baseUrl}/wp-json/wc/v3/orders?customer=${customer_id}&consumer_key=${woocommerce.consumerKey}&consumer_secret=${woocommerce.consumerSecret}"));  
        print(response);
        var data = jsonDecode(response.body.toString());
        allorders.value = data.map<WooOrder>((json) => WooOrder.fromJson(json)).toList();
        print("Fetched ${allorders.toString()} orders");
      } catch (e) {
        print("Error fetching orders: $e");
      }
      finally {
        isLoading.value = false;
      }
  }
}
