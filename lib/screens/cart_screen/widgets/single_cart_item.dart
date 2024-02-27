import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/models/product_model/product_model.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Colors.red.withOpacity(0.5),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                widget.singleProduct.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
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
                                        appProvider.updateQty(
                                            widget.singleProduct, qty);
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    color: Theme.of(context)
                                        .primaryColor, // Use the primary swatch color
                                    child: const CircleAvatar(
                                      maxRadius: 13,
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors
                                            .white, // Set the icon color to white
                                        size: 16, // Adjust the icon size
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  qty.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        qty++;
                                      });
                                      appProvider.updateQty(
                                          widget.singleProduct, qty);
                                    },
                                    padding: EdgeInsets.zero,
                                    color: Theme.of(context)
                                        .primaryColor, // Use the primary swatch color
                                    child: const CircleAvatar(
                                      maxRadius: 13,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors
                                            .white, // Set the icon color to white
                                        size: 16, // Adjust the icon size
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (!appProvider.getFavouriteProductList
                                    .contains(widget.singleProduct)) {
                                  appProvider.addFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Added to Wishlist");
                                } else {
                                  appProvider.removeFavouriteProduct(
                                      widget.singleProduct);
                                  showMessage("Removed From Wishlist");
                                }
                              },
                              child: Text(
                                appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)
                                    ? "Remove from WishList"
                                    : "Add to WishList",
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${widget.singleProduct.price.toString()}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        appProvider.removeCartProduct(widget.singleProduct);
                        showMessage("Removed From Cart");
                      },
                      child: const CircleAvatar(
                        maxRadius: 13,
                        child: Icon(
                          Icons.delete,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
