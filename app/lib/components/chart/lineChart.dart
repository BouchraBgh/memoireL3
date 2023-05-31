import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<dynamic> data;

  const LineChartWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spots = data.map((item) {
      return FlSpot(item.x, item.y);
    }).toList();
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              dotData: FlDotData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
        swapAnimationDuration: Duration(milliseconds: 150),
      ),
    );
  }
}
