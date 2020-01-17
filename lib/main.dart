import 'package:flutter/material.dart';



import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';


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

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  



  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't001', title: 'Food bill', amount: 500.46, date: DateTime.now()),
    Transaction(
        id: 't002', title: 'New Bag', amount: 700.46, date: DateTime.now()),
  ];

  void _addNewTransaction(String title,double amount){
    final newTx=Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    }); 
    Navigator.of(context).pop();
    // to exit from modal sheet after submit data 
  }

  void _startNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx){
        return NewTransaction(_addNewTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed:()=> _startNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()=> _startNewTransaction(context),
      ),
    );
  }
}
