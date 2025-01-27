import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Statistiche di Riciclo',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: 'Plastica',
                    color: Colors.green[300],
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: 'Carta',
                    color: Colors.blue[300],
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: 'Vetro',
                    color: Colors.orange[300],
                  ),
                  PieChartSectionData(
                    value: 10,
                    title: 'Altro',
                    color: Colors.yellow[300],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
