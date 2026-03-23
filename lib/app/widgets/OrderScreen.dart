import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var selectedProduct = "Delivery".obs;
  var selectedOrderType = "Limit".obs;
  var orderType = "BUY".obs;

  void changeProduct(String value) => selectedProduct.value = value;
  void changeOrderType(String value) => selectedOrderType.value = value;
  void changeBuySell(String value) => orderType.value = value;
}

class OrderScreen extends StatelessWidget {
  final String type;
  final String stockName;
  final String price;
  final String percentage;

  OrderScreen({
    super.key,
    required this.type,
    required this.stockName,
    required this.price,
    required this.percentage,
  });

  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    controller.orderType.value = type;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stockName, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              "₹$price  ($percentage%)",
              style: TextStyle(
                fontSize: 12,
                color: percentage.startsWith('-') ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),

        actions: [
          Obx(
            () => Row(
              children: [
                _actionButton(
                  "SELL",
                  controller.orderType.value == "SELL",
                  () => controller.changeBuySell("SELL"),
                ),
                const SizedBox(width: 6),
                _actionButton(
                  "BUY",
                  controller.orderType.value == "BUY",
                  () => controller.changeBuySell("BUY"),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                children: [
                  _tab(
                    "Delivery",
                    controller.selectedProduct.value == "Delivery",
                    () => controller.changeProduct("Delivery"),
                  ),
                  _tab(
                    "Intraday",
                    controller.selectedProduct.value == "Intraday",
                    () => controller.changeProduct("Intraday"),
                  ),
                  _tab(
                    "MTF 3.87X",
                    controller.selectedProduct.value == "MTF",
                    () => controller.changeProduct("MTF"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _inputBox("Qty", "1")),

                const SizedBox(width: 10),

                Expanded(
                  child: Obx(() {
                    bool isDisabled =
                        controller.selectedOrderType.value == "Market";

                    return _inputBox(
                      "Price",
                      isDisabled ? "Market Price" : price.toString(),
                      enabled: !isDisabled,
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Obx(
              () => Row(
                children: [
                  _tab(
                    "Limit",
                    controller.selectedOrderType.value == "Limit",
                    () => controller.changeOrderType("Limit"),
                  ),
                  _tab(
                    "Market",
                    controller.selectedOrderType.value == "Market",
                    () => controller.changeOrderType("Market"),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Obx(
              () => Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: controller.orderType.value == "BUY"
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.orderType.value,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputBox(String label, String value, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          enabled: enabled,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: value,
            filled: !enabled,
            fillColor: enabled ? null : Colors.grey.shade200,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (text == "BUY" ? Colors.green : Colors.red)
              : Colors.white,
          border: Border.all(color: text == "BUY" ? Colors.green : Colors.red),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (text == "BUY" ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}
