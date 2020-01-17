import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';



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
          
          UserTransactions(),
        ],
      ),
    );
  }
}
