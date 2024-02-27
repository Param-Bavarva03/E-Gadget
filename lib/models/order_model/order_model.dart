import 'package:mad_project/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.orderId,
    required this.totalPrice,
    required this.products,
    required this.payment,
    required this.status,
  });

  String payment;
  String status;
  List<ProductModel> products;
  double totalPrice;
  String orderId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];

    // Check if the 'orderId', 'status', 'payment' are null before using them as strings
    String orderId =
        json["orderId"] ?? ""; // Assign an empty string if it's null
    String status = json["status"] ?? ""; // Assign an empty string if it's null
    String payment =
        json["payment"] ?? ""; // Assign an empty string if it's null

    List<ProductModel> products =
        productMap.map((e) => ProductModel.fromJson(e)).toList();

    double totalPrice = json["totalPrice"] ?? 0.0; // Assign 0.0 if it's null

    return OrderModel(
      orderId: orderId,
      products: products,
      totalPrice: totalPrice,
      status: status,
      payment: payment,
    );
  }
}
