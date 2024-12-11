import 'package:blackford/api_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <WooCartItems>[].obs; // Observing cart items
  var totalPrice = 0.0.obs; // Observing total price
  var isLoading = false.obs; // For showing loading indicators



  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  // Fetch cart items
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      var cart = await woocommerce.getMyCart(
      );
      cartItems.value = cart.items!;
     totalPrice.value = double.tryParse(cart.totals!.lineTotal ?? '0') ?? 1.0;
    } catch (e) {
      print("Error fetching cart items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Add product to cart
  Future<void> addToCart(String productId) async {
    try {
      isLoading.value = true;
      await woocommerce.addToMyCart(itemId: productId.toString(), quantity: '1');
      await fetchCartItems(); 
      Get.snackbar("Added to Cart", "Product added to cart successfully.", 
      backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      print("Error adding to cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String key) async {
    try {
      isLoading.value = true;
      await woocommerce.deleteMyCartItem(key: key);
      await fetchCartItems(); // Refresh cart after removal
    } catch (e) {
      print("Error removing from cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
