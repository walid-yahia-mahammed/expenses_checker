import 'package:expenses_checker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactionList;

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double totalDayAmount = 0.00;
      for (var i = 0; i < recentTransactionList.length; i++) {
        if (recentTransactionList[i].date.day == weekDay.day &&
            recentTransactionList[i].date.month == weekDay.month &&
            recentTransactionList[i].date.year == weekDay.year) {
          totalDayAmount += recentTransactionList[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalDayAmount,
      };
    }).reversed.toList();
  }

  double get weekTotalAmount {
    return groupedTransactionValue.fold(0.00, (sum, ele) {
      return (sum as double) + (ele['amount'] as double);
    }) as double;
  }

  Chart(this.recentTransactionList);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValue.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'].toString(),
              data['amount'] as double,
              weekTotalAmount == 0.0
                  ? 0.0
                  : (data['amount'] as double) / weekTotalAmount,
            ),
          );
        }).toList(),
      ),
    );
  }
}
