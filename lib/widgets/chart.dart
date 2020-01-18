import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';



class Chart extends StatelessWidget {

  final List<Transaction> tList;

  Chart(this.tList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {


      //weekday contains value of day in terms of =current date -index
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < tList.length; i++) {
        if (tList[i].date.day == weekDay.day &&
            tList[i].date.month == weekDay.month &&
            tList[i].date.year == weekDay.year) {
          totalSum += tList[i].amount;
        }
      }


      
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Row(
        children: <Widget>[

        ],
      ),
    );
  }
}