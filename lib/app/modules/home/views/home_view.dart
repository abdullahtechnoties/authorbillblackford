import 'package:blackford/app/modules/cart/controllers/cart_controller.dart';
import 'package:blackford/app/modules/home/views/product.dart';
import 'package:blackford/utilities/colors.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());
  final CartController cart = Get.put(CartController());
  final items = [
    "assets/images/banner.png",
    "assets/images/banner.png",
    "assets/images/banner.png",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primarycolor,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColor.darkskyblue,
          foregroundColor: AppColor.white,
          leading: GestureDetector(
            onTap: () async {
              await controller.getProducts();
            },
            child: const Icon(Icons.search)),
          actions: [
            IconButton(
              onPressed: () {
                controller.logUserOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: ListView(
          children: [
            cs.CarouselSlider.builder(
              options: cs.CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
                height: 200,
                onPageChanged: (index, reason) =>
                    controller.currentBanner.value = index,
              ),
              itemCount: items.length,
              itemBuilder: (context, index, realIndex) => Container(
                margin: EdgeInsets.only(top: 25, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  items[index],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => controller.currentBanner.value = entry.key,
                  child: Obx(() {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 1.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (controller.currentBanner.value == entry.key)
                            ? AppColor.white
                            : AppColor.darkskyblue,
                      ),
                    );
                  }),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latest Books",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 0),
                          indicatorColor: AppColor.yellowish,
                          labelColor: AppColor.yellowish,
                          unselectedLabelColor: AppColor.white,
                          dividerColor: AppColor.primarycolor,
                          tabs: [
                            Tab(
                              text: "Best Sellers",
                            ),
                            Tab(
                              text: "Latest",
                            ),
                            Tab(
                              text: "Coming Soon",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: TabBarView(
                            children: [
                              Product(),
                              Product(),
                              Product(),
                            ],
                          ),
                        ),
                      ],
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
