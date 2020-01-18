import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';



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


      //print(DateFormat.E().format(weekDay).substring(0, 1));
      //print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }


  double get totalSpending{
    return groupedTransactionValues.fold(
      //first argument is starting value
      0.0,
      //second argument is function
      (sum,item){
        return sum+item['amount'];
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight ,
              child: ChartBar(
                data['day'], 
                data['amount'],
                totalSpending==0.0? 0.0:(data['amount'] as double)/totalSpending
                //if total spending is 0 then send 0
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}