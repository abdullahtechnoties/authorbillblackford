import 'package:blackford/app/modules/home/controllers/home_controller.dart';
import 'package:blackford/utilities/colors.dart';
import 'package:blackford/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product extends GetView<HomeController> {
  Product({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      body: Container(
        width: Get.width,
        child: Obx(() {
          // Ensure the products list is loaded and not empty
          if (controller.allproducts.isEmpty) {
            return Center(child: CircularProgressIndicator(
              color: AppColor.yellowish,
            ));
          }    
          return ListView.builder(
            padding: EdgeInsets.only(top: 20,),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.allproducts.length,
            itemBuilder: (context, index) {
              final product = controller.allproducts[index];

              String imageUrl = '';
              if (product.images.isNotEmpty) {
                imageUrl = product.images.first.src ?? ''; 
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),               
                child: GestureDetector(
                   onTap: () => Get.toNamed("/single-product", arguments: product),
                  child: SizedBox(
                    height: 120,
                    child: productCard(
                      name: product.name ?? "Unknown",  
                      author: 'Bill Blackford', 
                      price: product.price ?? "0.0",  
                      image: imageUrl,
                      tags: product.tags.map((tag) => tag.name ?? "").toList(),
                      context: context,
                      index: index,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
