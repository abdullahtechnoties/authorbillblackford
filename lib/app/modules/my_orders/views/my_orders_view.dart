import 'package:blackford/app/modules/my_orders/controllers/my_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
             ListView.builder(
              shrinkWrap: true,
              
              itemCount: controller.allorders.length,
              itemBuilder: (context, index) {
                print(controller.allorders.length.toString());
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
                                   child: Text(controller.allorders[index].orderKey.toString()),
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
                                   child: Text("\$${order.total.toString()}"),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     ),
                     // Image and Button
                     Padding(
                       padding: EdgeInsets.all(16.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.network(
                             'assets/images/Logo.png',
                             width: 100,
                             height: 100,
                           ),
                           SizedBox(height: 8),
                           ElevatedButton(
                             onPressed: () {
                               Get.toNamed('/single-product');
                             },
                             style: ElevatedButton.styleFrom(
                               backgroundColor: AppColor.darkskyblue,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(50),
                               ),
                             ),
                             child: Text(
                               "View",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
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
    );
  }
}