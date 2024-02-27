import 'package:flutter/material.dart';
import 'package:mad_project/models/category_model/category_model.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/product_model/product_model.dart';
import '../product_details/product_details.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight * 1,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(widget.categoryModel.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Best Product is Empty"),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable grid scrolling
                          itemCount: productModelList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (ctx, index) {
                            ProductModel singleProduct =
                                productModelList[index];
                            return Card(
                              color: const Color.fromARGB(170, 218, 218, 218),
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 120, // Specify image height
                                    width: 120, // Specify image width
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      child: Image.network(
                                        singleProduct.image,
                                        fit: BoxFit
                                            .contain, // Ensure image fits within the dimensions
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    singleProduct.name,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Price: \$${singleProduct.price}",
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  SizedBox(
                                    height: 36,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: ProductDetails(
                                                singleProduct: singleProduct),
                                            context: context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        backgroundColor: const Color.fromARGB(
                                            255,
                                            231,
                                            231,
                                            231), // Set text color to red
                                        elevation: 3.0, // Add elevation
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), // Add border radius
                                          side: const BorderSide(
                                              color: Colors
                                                  .red), // Add border color
                                        ),
                                      ),
                                      child: const Text(
                                        "Buy",
                                        style: TextStyle(
                                          fontSize: 14, // Adjust font size
                                          fontWeight: FontWeight
                                              .bold, // Add bold font weight
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
