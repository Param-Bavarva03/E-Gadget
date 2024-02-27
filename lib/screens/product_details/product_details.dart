import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants/constants.dart';
import 'package:mad_project/models/product_model/product_model.dart';
import 'package:mad_project/provider/app_provider.dart';
import 'package:mad_project/screens/cart_screen/cart_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../Check_out/check_out.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const CartScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 300,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.singleProduct.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavourite =
                            !widget.singleProduct.isFavourite;
                      });
                      if (widget.singleProduct.isFavourite) {
                        appProvider.addFavouriteProduct(widget.singleProduct);
                      } else {
                        appProvider
                            .removeFavouriteProduct(widget.singleProduct);
                      }
                    },
                    icon: Icon(appProvider.getFavouriteProductList
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(widget.singleProduct.description),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CupertinoButton(
                      onPressed: () {
                        if (qty >= 2) {
                          setState(() {
                            qty--;
                          });
                        }
                      },
                      padding: EdgeInsets.zero,
                      color: Theme.of(context)
                          .primaryColor, // Use the primary swatch color
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white, // Set the icon color to white
                          size: 16, // Adjust the icon size
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          qty++;
                        });
                      },
                      padding: EdgeInsets.zero,
                      color: Theme.of(context)
                          .primaryColor, // Use the primary swatch color
                      child: const CircleAvatar(
                        child: Icon(
                          Icons.add,
                          color: Colors.white, // Set the icon color to white
                          size: 16, // Adjust the icon size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ProductModel productModel =
                          widget.singleProduct.copyWith(qty: qty);
                      appProvider.addCartProduct(productModel);
                      showMessage("Added To Cart");
                    },
                    child: const Text("Add To Cart"),
                  ),
                  const SizedBox(
                    width: 34.0,
                  ),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        Routes.instance.push(
                            widget: Checkout(
                              singleProduct: productModel,
                            ),
                            context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .primaryColor, // Use the primary swatch color
                      ),
                      child: const Text(
                        "Buy",
                        style: TextStyle(
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
