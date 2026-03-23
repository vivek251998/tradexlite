import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../routes/app_routes.dart';
import 'market_controller.dart';

class MarketView extends StatelessWidget {
  final controller = Get.put(MarketController());

  MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: const Text("Market Watch"),
        centerTitle: false,


        actions: [
          Obx(() {
            final themeController = Get.find<ThemeController>();

            return IconButton(
              icon: Icon(
                themeController.isDark.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            );
          }),
        ],
      ),

      body: Obx(
            () => Column(
          children: [
            _buildSearch(context),
            _buildOverview(context),
            Divider(color: theme.dividerColor),

            Expanded(
              child: ListView.builder(
                itemCount: controller.stocks.length,
                itemBuilder: (_, index) {
                  final stock = controller.stocks[index];
                  return _buildStockRow(context, stock);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSearch(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 45,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: theme.hintColor),
          const SizedBox(width: 10),
          Text(
            'Search for "Stocks"',
            style: TextStyle(color: theme.hintColor),
          ),
        ],
      ),
    );
  }


  Widget _buildOverview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildIndexCard(
              context,
              title: "NIFTY 50",
              value: "23401.25",
              change: "+286.75 (+1.24%)",
              isPositive: true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildIndexCard(
              context,
              title: "SENSEX",
              value: "76145.84",
              change: "+1612.88 (+2.16%)",
              isPositive: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexCard(
      BuildContext context, {
        required String title,
        required String value,
        required String change,
        required bool isPositive,
      }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: theme.brightness == Brightness.dark
                ? Colors.black.withOpacity(0.6)
                : Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: theme.hintColor)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildStockRow(BuildContext context, stock) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.DETAIL, arguments: stock);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(
            bottom: BorderSide(color: theme.dividerColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "NSE EQ",
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.hintColor,
                  ),
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
                    fontWeight: FontWeight.w600,
                    color:
                    stock.change >= 0 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${stock.change >= 0 ? "+" : ""}${stock.change.toStringAsFixed(2)} (${stock.percent.toStringAsFixed(2)}%)",
                  style: TextStyle(
                    fontSize: 13,
                    color:
                    stock.change >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}