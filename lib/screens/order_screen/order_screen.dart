import 'package:flutter/material.dart';

import '../../firebase_helper/firebase_firestore_helper/firebase_firestore.dart';
import '../../models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key})
      : super(key: key); // Corrected constructor syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Your Orders",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          // Updated the parameter type
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Check for data before accessing it
            return const Center(
              child: Text("No Order Found"),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 55.0),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 2.3)),
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red, width: 2.3)),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 125,
                          width: 125,
                          color: Colors.red.withOpacity(0.5),
                          child: Image.network(orderModel.products[0].image),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.products[0].name,
                                    style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  orderModel.products.length > 1
                                      ? SizedBox.fromSize()
                                      : Column(
                                          children: [
                                            Text(
                                              "Quantity: ${orderModel.products[0].qty.toString()}",
                                              style: const TextStyle(
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                          ],
                                        ),
                                  Text(
                                    "Total Price: \$${orderModel.totalPrice.toString()}",
                                    style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    "Order Status: ${orderModel.status}",
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                          const Text("Details"),
                            const Divider(
                              color: Colors.red,
                            ),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Colors.red.withOpacity(0.5),
                                          child:
                                              Image.network(singleProduct.image),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    singleProduct.name,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Quantity: ${singleProduct.qty.toString()}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12.0,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "Price: \$${singleProduct.price.toString()}",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
