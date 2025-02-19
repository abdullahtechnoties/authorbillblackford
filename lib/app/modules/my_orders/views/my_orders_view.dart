import 'package:blackford/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: AppColor.primarycolor,
          appBar: AppBar(
            title: Text(
              'My Orders',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColor.darkskyblue,
            foregroundColor: AppColor.white,
          ),
          body: SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.yellowish),
              ),
            ),
          ),        
        );       
      }
    if(controller.allorders.isEmpty){
      return Scaffold(
        backgroundColor: AppColor.primarycolor,
        appBar: AppBar(
          backgroundColor: AppColor.darkskyblue,
          foregroundColor: AppColor.white,
          centerTitle: true,
          title: Text(
            'My Orders',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColor.white
            ),
          )
          ),
          body: SizedBox(
            child: Center(
              child: Text(
                'No Orders Found',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            )
          )
        )
      ;
    }
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
      ),
      body: FocusScope(
        node: FocusScopeNode(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
               ListView.builder(
                shrinkWrap: true,    
                physics: NeverScrollableScrollPhysics(),         
                itemCount: controller.allorders.length,
                itemBuilder: (context, index) {
        
                final order = controller.allorders[index];
                 return Card(
                   color: AppColor.yellowish,
                   margin: EdgeInsets.only(bottom: 16),
                   elevation: 2,
                   child: Row(
                     children: [
                       // Order Details
                       Expanded(
                         child: Padding(
                           padding: EdgeInsets.all(16.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     "ORDER: ",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                   Expanded(
                                     child: SelectableText(controller.allorders[index].orderKey.toString()),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 8),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     "DATE: ",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                   Expanded(
                                     child: Text(order.dateCreated.toString()),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 8),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     "STATUS: ",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                   Expanded(
                                     child: Text(order.status.toString() == "wc-completed" ? "Completed" : "Pending"),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 8),
                               Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     "TOTAL: ",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                   ),
                                   Expanded(
                              child: Text("\$${(double.parse(order.total!) / 100)}"),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                       // Image and Button
                      //  Padding(
                      //    padding: EdgeInsets.all(16.0),
                      //    child: Column(
                      //      mainAxisAlignment: MainAxisAlignment.center,
                      //      children: [
                      //       //  Image.network(
                      //       //    'assets/images/Logo.png',
                      //       //    width: 100,
                      //       //    height: 100,
                      //       //  ),
                      //        SizedBox(height: 8),
                      //        ElevatedButton(
                      //          onPressed: () {
                      //            Get.toNamed('/single-product');
                      //          },
                      //          style: ElevatedButton.styleFrom(
                      //            backgroundColor: AppColor.darkskyblue,
                      //            shape: RoundedRectangleBorder(
                      //              borderRadius: BorderRadius.circular(50),
                      //            ),
                      //          ),
                      //          child: Text(
                      //            "View",
                      //            style: TextStyle(
                      //              color: Colors.white,
                      //              fontWeight: FontWeight.bold,
                      //            ),
                      //          ),
                      //        ),
                      //      ],
                      //    ),
                      //  ),
                     ],
                   ),
                 );
               })
        
              // Second Order
              // Card(
              //   color: AppColor.yellowish,
              //   margin: EdgeInsets.only(bottom: 16),
              //   elevation: 2,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.all(16.0),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "ORDER: ",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                   Expanded(
              //                     child: Text("#1067"),
              //                   ),
              //                 ],
              //               ),
              //               SizedBox(height: 8),
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "DATE: ",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                   Expanded(
              //                     child: Text("December 10, 2024"),
              //                   ),
              //                 ],
              //               ),
              //               SizedBox(height: 8),
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "STATUS: ",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                   Expanded(
              //                     child: Text("Processing"),
              //                   ),
              //                 ],
              //               ),
              //               SizedBox(height: 8),
              //               Row(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "TOTAL: ",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                   Expanded(
              //                     child: Text("\$264.00 for 3 items"),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       // Image and Button
              //       Padding(
              //         padding: EdgeInsets.all(16.0),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Image.asset(
              //               'assets/images/Book-1.png',
              //               width: 100,
              //               height: 100,
              //             ),
              //             SizedBox(height: 8),
              //             ElevatedButton(
              //               onPressed: () {
              //                 Get.toNamed('/single-product');
              //               },
              //               style: ElevatedButton.styleFrom(
              //                 backgroundColor: AppColor.darkskyblue,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(50),
              //                 ),
              //               ),
              //               child: Text(
              //                 "View",
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
    });
  }
}