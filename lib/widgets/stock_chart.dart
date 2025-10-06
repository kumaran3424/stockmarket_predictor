import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class StockChart extends StatelessWidget {
  final String symbol;
  const StockChart({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    final spots = List<FlSpot>.generate(50, (i) {
      final x = i.toDouble();
      final y = 150 + 10 * sin(i / 5) + Random(i).nextDouble()*2;
      return FlSpot(x, y);
    });

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: LineChart(LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(spots: spots, isCurved: true, dotData: FlDotData(show: false), belowBarData: BarAreaData(show: true))
        ],
      )),
    );
  }
}
