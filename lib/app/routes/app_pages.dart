import 'package:get/get.dart';

import '../market/market_view.dart';
import '../modules/auth/login_view.dart';
import '../widgets/StockDetailView.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.MARKET, page: () => MarketView()),
    GetPage(name: Routes.DETAIL, page: () => StockDetailScreen()),
  ];
}