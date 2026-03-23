import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/stock_model.dart';
import 'chart_widget.dart';
import 'OrderScreen.dart';

class StockDetailScreen extends StatelessWidget {
  final Stock stock = Get.arguments;

  StockDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isPositive = stock.change >= 0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      stock.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "EQ",
                      style: TextStyle(fontSize: 12, color: theme.hintColor),
                    ),
                  ],
                ),
                Text(
                  stock.name,
                  style: TextStyle(fontSize: 12, color: theme.hintColor),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.price.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  "${isPositive ? "+" : ""}${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                  style: TextStyle(
                    fontSize: 12,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Get.to(
                Scaffold(
                  appBar: AppBar(title: const Text("Chart")),
                  body: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ChartWidget(prices: generateMockPrices(stock.price)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(children: [_overviewTable(context)]),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.to(
                    () => OrderScreen(
                      type: "SELL",
                      stockName: stock.name,
                      price: stock.price.toStringAsFixed(2),
                      percentage: stock.percent.toStringAsFixed(2),
                    ),
                  );
                },
                child: const Text(
                  "Sell",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.to(
                    () => OrderScreen(
                      type: "BUY",
                      stockName: stock.name,
                      price: stock.price.toStringAsFixed(2),
                      percentage: stock.percent.toStringAsFixed(2),
                    ),
                  );
                },
                child: const Text(
                  "Buy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,)
          ],

        ),


      ),
    );
  }

  Widget _overviewTable(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _row(context, "Open", stock.price.toStringAsFixed(2)),
          _row(context, "High", "380.00"),
          _row(context, "Close", "371.65"),
          _row(context, "Low", "360.50"),
          _row(context, "EPS", "11.07"),
          _row(context, "52W High", "420.00"),
          _row(context, "52W Low", "290.00"),
          _row(context, "Avg. Price", "365.20"),
          _row(context, "Volume", "1,25,000"),
          _row(context, "LTQ", "250"),
          _row(context, "Turnover", "4.5 Cr"),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: theme.cardColor, // 🔥 dynamic
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 13, color: theme.hintColor)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  List<double> generateMockPrices(double basePrice) {
    List<double> data = [];
    double current = basePrice;

    for (int i = 0; i < 60; i++) {
      current += (i % 3 == 0 ? 5 : -3) + (i % 2 == 0 ? 2 : -1);
      data.add(current);
    }

    return data;
  }
}
