import 'package:flutter/material.dart';



import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch:Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'Quicksand',fontSize: 18,fontWeight: FontWeight.bold),
        ), 
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontFamily: 'Roboto',fontSize: 20,fontWeight: FontWeight.bold),
          ),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  



  final List<Transaction> _userTransactions = [];

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



  //to send last 7 days transaction
  List<Transaction> get getRecentTransaction{
    //.where takes element from list and check below condition
    return _userTransactions.where(
      (tx){
        //if tx date after the specfied date in isAfter then this object is return to getRecentTransction
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          )
        );
      }
    ).toList();
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
            Chart(getRecentTransaction),
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
