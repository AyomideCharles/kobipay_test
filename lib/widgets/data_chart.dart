import 'package:flutter/material.dart';
import 'package:kobipayy/model/transaction_model.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpenseChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ExpenseChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      for (var tx in transactions) tx.merchant: tx.amount,
    };

    return PieChart(
      dataMap: dataMap.isEmpty ? {"No Data": 1} : dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartRadius: MediaQuery.of(context).size.width / 2.2,
      colorList: const [
        Colors.blue,
        Colors.green,
        Color.fromARGB(255, 188, 93, 205),
      ],
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
      legendOptions: const LegendOptions(
        showLegends: false,
        // legendPosition: LegendPosition.top,
        legendTextStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: false,
        showChartValuesInPercentage: false,
        decimalPlaces: 2,
      ),
    );
  }
}
