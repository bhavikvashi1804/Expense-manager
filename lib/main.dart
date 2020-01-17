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
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        padding: EdgeInsets.all(10),
                        child: Text('\$ ${transaction.amount}',
                          style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        decoration: BoxDecoration(border: Border.all(color: Colors.purple,width: 2,)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transaction.title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text(transaction.date.toString(),style: TextStyle(color: Colors.grey),),
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
