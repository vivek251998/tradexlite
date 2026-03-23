import 'package:get/get.dart';
import '../models/mock_service.dart';
import '../models/stock_model.dart';


class MarketController extends GetxController {
  var stocks = <Stock>[].obs;

  @override
  void onInit() {
    super.onInit();
    MockService.getStockStream().listen((data) {
      stocks.value = data;
    });
  }
}