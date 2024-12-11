import 'package:blackford/api_key.dart';
import 'package:flutter_wp_woocommerce/models/order_payload.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    createOrder();
  }

  @override
  void onReady() {
    super.onReady();
  }

 void createOrder() async {
     try{
      // create order using woocommerce package
       await woocommerce.createOrder(

       WooOrderPayload(
          paymentMethod: 'cash_on_delivery',
          paymentMethodTitle: 'Cash on Delivery',
          setPaid: true,
          status: 'processing',
          shipping: WooOrderPayloadShipping(
            firstName: 'John',
            lastName: 'Doe',
            address1: '123 Main St',
            city: 'Anytown',  
            state: 'CA',        
          )));
        
      // clear cart items
      // cartItems.clear();
      // show success message or navigate to checkout page
   

  }
  catch(e){
    print(e);
  }
 }




  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
