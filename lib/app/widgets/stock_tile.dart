import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/stock_model.dart';
import '../routes/app_routes.dart';

class StockTile extends StatelessWidget {
  final Stock stock;

  const StockTile({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stock.change >= 0;

    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Get.toNamed(Routes.DETAIL, arguments: stock);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),

          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 1,
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.6)
                  : Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                stock.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: Text(
                "₹${stock.price.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withOpacity(
                          theme.brightness == Brightness.dark ? 0.2 : 0.1,
                        )
                      : Colors.red.withOpacity(
                          theme.brightness == Brightness.dark ? 0.2 : 0.1,
                        ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${isPositive ? '+' : ''}${stock.change.toStringAsFixed(2)}%",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: isPositive ? Colors.green : Colors.red,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
