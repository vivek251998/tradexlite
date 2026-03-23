import 'package:get/get.dart';

class OrderController extends GetxController {
  var selectedProduct = "Delivery".obs;
  var selectedOrderType = "Limit".obs;

  void changeProduct(String value) {
    selectedProduct.value = value;
  }

  void changeOrderType(String value) {
    selectedOrderType.value = value;
  }
}