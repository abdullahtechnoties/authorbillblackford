import 'package:flutter/material.dart';
import 'package:flutter_wp_woocommerce/models/products.dart';
import 'package:get/get.dart';
import 'package:blackford/utilities/colors.dart';
import '../../../../widgets/product_card.dart';
import 'package:blackford/app/modules/home/controllers/home_controller.dart';  // Import the controller

class SearchProductView extends StatefulWidget {
  const SearchProductView({super.key});

  @override
  _SearchProductViewstate createState() => _SearchProductViewstate();
}

class _SearchProductViewstate extends State<SearchProductView> {
  final HomeController controller = Get.find();  // Get the controller to fetch products
  TextEditingController searchController = TextEditingController();  // Controller for the search input
  List<WooProduct> filteredProducts = [];  // List for storing filtered products

  @override
  void initState() {
    super.initState();
    // Initially, populate filteredProducts with all products from the controller
    filteredProducts = controller.allproducts;
    
    // Add a listener to the search field to filter products on input change
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);  // Remove listener when the widget is disposed
    searchController.dispose();
    super.dispose();
  }

  // Function to filter the products list based on the search query
  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    
    if (query.isEmpty) {
      setState(() {
        filteredProducts = controller.allproducts;
      });
    } else {
      setState(() {
        filteredProducts = controller.allproducts.where((product) {
          return product.name?.toLowerCase().contains(query) ?? false;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColor.darkskyblue,
        foregroundColor: AppColor.white,
      ),
      body: GestureDetector(
        onTap: () =>  FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FocusScope(
                  node: FocusScopeNode(),
                  child: TextFormField(
                    controller: searchController,  // Use the search controller
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(
                        color: Color(0xFFB8B8B8),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFB8B8B8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: searchController.text.isNotEmpty ? GestureDetector(
                          onTap: () => searchController.clear(),
                          child: Icon( 
                            Icons.clear,),
                        ) : SizedBox.shrink(),
                      
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: TextStyle(
                      color: AppColor.darkskyblue,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'All Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 15),
                // Use the filteredProducts list for displaying products
                ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  shrinkWrap: true,
                  itemCount: filteredProducts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    String imageUrl = '';
                    if (product.images.isNotEmpty) {
                      imageUrl = product.images.first.src ?? ''; // Get the first image URL
                    }
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () => Get.toNamed("/single-product", arguments: product),
                        child: SizedBox(
                          height: 120,
                          child: productCard(
                            name: product.name ?? "Unknown",  // Handle null
                            author: product.name ?? "Unknown",  // Handle null
                            price: product.price ?? "0.0",  // Handle null
                            image: imageUrl,
                            tags: product.tags.map((tag) => tag.name ?? "").toList() ?? [],  // Safely handle tags
                            context: context,
                            index: index,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
