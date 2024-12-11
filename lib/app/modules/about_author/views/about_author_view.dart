import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../utilities/colors.dart';
import '../controllers/about_author_controller.dart';

class AboutAuthorView extends GetView<AboutAuthorController> {
  AboutAuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        title: Text(
          'About Author',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColor.darkskyblue,
                  height: 120,
                  width: double.infinity,
                ),
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Text(
                        'Author',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Bill Blackford',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: 4.0,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 30,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '(4.0)',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        'About',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Bill Blackford, the author of It Aint Just About Planes, reflects on a life marked by profound struggles and significant triumphs. Born in the small town of Geneseo, Illinois, Blackford\'s early years were defined by hardship and an overwhelming sense of not belonging.\n\nDespite enduring emotional and physical challenges in his family life, he found solace and direction in his love for aviation. His journey from a troubled childhood to becoming a successful aviator is a testament to his resilience and determination.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColor.yellowish,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/Arthur.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
