import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  final List<double> prices;

  const ChartWidget({
    super.key,
    required this.prices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // 🔥 Dark background
      padding: const EdgeInsets.all(8),
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.black,


          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 20,
            verticalInterval: 5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.white.withOpacity(0.05),
              strokeWidth: 1,
            ),
          ),


          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    "${value.toInt()}",
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),

            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),

          borderData: FlBorderData(show: false),


          lineBarsData: [
            LineChartBarData(
              spots: _generateSpots(),
              isCurved: false,
              color: Colors.redAccent,
              barWidth: 2,
              dotData: FlDotData(show: false),


              belowBarData: BarAreaData(
                show: true,
                color: Colors.red.withOpacity(0.1),
              ),
            ),
          ],


          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
             // tooltipBgColor: Colors.black87,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    spot.y.toStringAsFixed(2),
                    const TextStyle(color: Colors.white),
                  );
                }).toList();
              },
            ),
          ),

          minY: _getMinY(),
          maxY: _getMaxY(),
        ),
      ),
    );
  }


  List<FlSpot> _generateSpots() {
    return List.generate(
      prices.length,
          (index) => FlSpot(index.toDouble(), prices[index]),
    );
  }

  double _getMinY() {
    return prices.reduce((a, b) => a < b ? a : b) - 10;
  }

  double _getMaxY() {
    return prices.reduce((a, b) => a > b ? a : b) + 10;
  }
}