import 'package:blackford/api_key.dart';
import 'package:flutter_wp_woocommerce/models/order.dart';

import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  final RxList<WooOrder> allorders = <WooOrder>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<void> getOrders() async {
      try {
        isLoading.value = true;
        final orders = await woocommerce.getOrders(perPage: 20);  
        allorders.value = orders;
        print("Fetched ${allorders.toString()} orders");
      } catch (e) {
        print("Error fetching orders: $e");
      }
      finally {
        isLoading.value = false;
      }
  }
}
