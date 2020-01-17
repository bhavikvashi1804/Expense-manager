import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final List<Transaction> _transaction=[
    Transaction(id: 't001',title: 'Food bill',amount: 500.46,date: DateTime.now()),
    Transaction(id: 't002',title: 'New Bag',amount: 1000.46,date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Column(
            children: _transaction.map(
              (transaction){
                return Card(
                  child: Text(transaction.title),
                );

              }
            ).toList(),
          ),

        ],
      ),
    );
  }
}
