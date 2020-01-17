import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> _transaction=[
    Transaction(id: 't001',title: 'Food bill',amount: 500.46,date: DateTime.now()),
    Transaction(id: 't002',title: 'New Bag',amount: 1000.46,date: DateTime.now()),
  ];

  final titleController=TextEditingController();
  final amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Container(
              width: double.infinity,
              child: Text('Chart !'),
            ),
            color: Colors.blue,
            elevation: 5.0,

          ),
          Card(
            elevation: 8.0,
            margin: EdgeInsets.all(10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleController,
                  ),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  FlatButton(
                    onPressed: (){

                    },
                    child: Text('Add Transaction',style: TextStyle(color: Colors.purple),),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: _transaction.map(
              (transaction){
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        padding: EdgeInsets.all(10),
                        child: Text('₹${transaction.amount}',
                          style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        decoration: BoxDecoration(border: Border.all(color: Colors.purple,width: 2,)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transaction.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text(DateFormat('dd MMM, yyyy hh:mm:ss aaa').format(transaction.date),style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ],
                  ),
                );

              }
            ).toList(),
          ),

        ],
      ),
    );
  }
}
