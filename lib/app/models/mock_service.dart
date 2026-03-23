import 'dart:async';
import 'dart:math';
import '../models/stock_model.dart';

class MockService {
  static final Random _random = Random();

  static List<Stock> stocks = [
    Stock(name: "ADANIENT", price: 2045.00, change: 117.90, percent: 6.12),
    Stock(name: "ADANIPORTS", price: 1488.00, change: 122.60, percent: 8.98),
    Stock(name: "APOLLOHOSP", price: 6767.00, change: -597.50, percent: -8.11),
    Stock(name: "ASIANPAINT", price: 2217.40, change: 22.00, percent: 1.00),
    Stock(name: "AXISBANK", price: 1232.60, change: 28.70, percent: 2.38),
    Stock(name: "BAJAJ-AUTO", price: 8481.00, change: -570.00, percent: -6.30),
    Stock(name: "BAJFINANCE", price: 838.90, change: 8.35, percent: 1.01),
    Stock(name: "BAJAJFINSV", price: 1844.00, change: 133.70, percent: 7.82),
    Stock(name: "BEL", price: 210.50, change: 5.40, percent: 2.63),
    Stock(name: "BHARTIARTL", price: 1412.00, change: 18.50, percent: 1.32),
    Stock(name: "BPCL", price: 615.20, change: -12.40, percent: -1.98),
    Stock(name: "BRITANNIA", price: 5020.00, change: 45.00, percent: 0.90),
    Stock(name: "CIPLA", price: 1480.00, change: -10.20, percent: -0.68),
    Stock(name: "COALINDIA", price: 480.00, change: 6.50, percent: 1.37),
    Stock(name: "DIVISLAB", price: 3900.00, change: -25.00, percent: -0.64),
    Stock(name: "DRREDDY", price: 6200.00, change: 80.00, percent: 1.30),
    Stock(name: "EICHERMOT", price: 4850.00, change: -60.00, percent: -1.22),
    Stock(name: "GRASIM", price: 2450.00, change: 35.00, percent: 1.45),
    Stock(name: "HCLTECH", price: 1520.00, change: 12.00, percent: 0.79),
    Stock(name: "HDFCBANK", price: 1650.00, change: 14.00, percent: 0.85),
    Stock(name: "HDFCLIFE", price: 620.00, change: -8.00, percent: -1.27),
    Stock(name: "HEROMOTOCO", price: 4550.00, change: 22.00, percent: 0.49),
    Stock(name: "HINDALCO", price: 690.00, change: 10.00, percent: 1.47),
    Stock(name: "HINDUNILVR", price: 2600.00, change: -15.00, percent: -0.57),
    Stock(name: "ICICIBANK", price: 1080.00, change: 20.00, percent: 1.89),
    Stock(name: "INDUSINDBK", price: 1450.00, change: -18.00, percent: -1.23),
    Stock(name: "INFY", price: 1620.00, change: 25.00, percent: 1.56),
    Stock(name: "ITC", price: 430.00, change: 3.00, percent: 0.70),
    Stock(name: "JSWSTEEL", price: 920.00, change: 14.00, percent: 1.55),
    Stock(name: "KOTAKBANK", price: 1750.00, change: 10.00, percent: 0.57),
    Stock(name: "LT", price: 3600.00, change: 45.00, percent: 1.27),
    Stock(name: "LTIM", price: 5200.00, change: -30.00, percent: -0.57),
    Stock(name: "M&M", price: 1850.00, change: 20.00, percent: 1.09),
    Stock(name: "MARUTI", price: 11500.00, change: 120.00, percent: 1.05),
    Stock(name: "NESTLEIND", price: 24500.00, change: -200.00, percent: -0.81),
    Stock(name: "NTPC", price: 340.00, change: 4.50, percent: 1.34),
    Stock(name: "ONGC", price: 290.00, change: -5.00, percent: -1.69),
    Stock(name: "POWERGRID", price: 310.00, change: 3.20, percent: 1.04),
    Stock(name: "RELIANCE", price: 2950.00, change: 35.00, percent: 1.20),
    Stock(name: "SBILIFE", price: 1400.00, change: -10.00, percent: -0.71),
    Stock(name: "SBIN", price: 780.00, change: 12.00, percent: 1.56),
    Stock(name: "SHRIRAMFIN", price: 2100.00, change: 18.00, percent: 0.86),
    Stock(name: "SUNPHARMA", price: 1700.00, change: 22.00, percent: 1.31),
    Stock(name: "TATACONSUM", price: 1050.00, change: 9.00, percent: 0.86),
    Stock(name: "TATAMOTORS", price: 980.00, change: -12.00, percent: -1.21),
    Stock(name: "TATASTEEL", price: 155.00, change: 2.50, percent: 1.64),
    Stock(name: "TCS", price: 4100.00, change: 50.00, percent: 1.23),
    Stock(name: "TECHM", price: 1350.00, change: -8.00, percent: -0.59),
    Stock(name: "TITAN", price: 3700.00, change: 40.00, percent: 1.09),
    Stock(name: "ULTRACEMCO", price: 10000.00, change: 80.00, percent: 0.80),
    Stock(name: "WIPRO", price: 520.00, change: 6.00, percent: 1.17),
  ];

  static Stream<List<Stock>> getStockStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));

      for (var stock in stocks) {
        double oldPrice = stock.price;


        double changePercent = (_random.nextDouble() * 4 - 2);

        double newPrice = oldPrice + (oldPrice * changePercent / 100);

        stock.change = newPrice - oldPrice;
        stock.percent = (stock.change / oldPrice) * 100;
        stock.price = newPrice;
      }

      yield List.from(stocks);
    }
  }

  double get52WeekHigh(List<Stock> stocks) {
    return stocks
        .map((e) => e.price)
        .reduce((a, b) => a > b ? a : b);
  }

  double get52WeekLow(List<Stock> stocks) {
    return stocks
        .map((e) => e.price)
        .reduce((a, b) => a < b ? a : b);
  }
}