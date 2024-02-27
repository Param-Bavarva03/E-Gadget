import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import 'package:mad_project/models/category_model/category_model.dart';
import 'package:mad_project/models/product_model/product_model.dart';
import 'package:mad_project/provider/app_provider.dart';
import 'package:mad_project/screens/category_view/category_view.dart';
import 'package:mad_project/screens/product_details/product_details.dart';
import 'package:mad_project/widgets/primary_button/top_titles/top_titles.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();

    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    setState(() {
    isLoading = false;
  });
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProduct(String value) {
    searchList = productModelList
        .where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopTitles(subtitle: "", title: "E Gadgets"),
                        TextFormField(
                          controller: search,
                          onChanged: (String value) {
                            searchProduct(value);
                          },
                          decoration:
                              const InputDecoration(hintText: "Search..."),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Category is Empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget: CategoryView(
                                              categoryModel: e,
                                            ),
                                            context: context);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            e.image,
                                            height: 100, // Specify image height
                                            width: 100, // Specify image width
                                            fit: BoxFit
                                                .contain, // Ensure image fits within the dimensions
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  !isSearched()
                      ? const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Text(
                            "Best Products",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox.fromSize(),
                  const SizedBox(
                    height: 22.0,
                  ),
                  search.text.isNotEmpty && searchList.isEmpty
                      ? const Center(child: Text("No Product Found"))
                      : searchList.isNotEmpty
                          ? GridView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,

                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable grid scrolling
                              itemCount: searchList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct = searchList[index];
                                return Card(
                                  color:
                                      const Color.fromARGB(170, 218, 218, 218),
                                  elevation: 3.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                    singleProduct:
                                                        singleProduct),
                                                context: context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.red,
                                            backgroundColor: const Color
                                                    .fromARGB(255, 231, 231,
                                                231), // Set text color to red
                                            elevation: 3.0, // Add elevation
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                            )
                          : productModelList.isEmpty
                              ? const Center(
                                  child: Text("Best Product is Empty"),
                                )
                              : GridView.builder(
                                  padding: const EdgeInsets.only(bottom: 50),
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
                                      color: const Color.fromARGB(
                                          170, 218, 218, 218),
                                      elevation: 3.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 120, // Specify image height
                                            width: 120, // Specify image width
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                        singleProduct:
                                                            singleProduct),
                                                    context: context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                backgroundColor: const Color
                                                        .fromARGB(255, 231, 231,
                                                    231), // Set text color to red
                                                elevation: 3.0, // Add elevation
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0), // Add border radius
                                                  side: const BorderSide(
                                                      color: Colors
                                                          .red), // Add border color
                                                ),
                                              ),
                                              child: const Text(
                                                "Buy",
                                                style: TextStyle(
                                                  fontSize:
                                                      14, // Adjust font size
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

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (searchList.isNotEmpty && search.text.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
