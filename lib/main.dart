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
            button: TextStyle( color: Colors.white),
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

  void _addNewTransaction(String title,double amount,DateTime chosenDate){
    final newTx=Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
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


  void _deleteTransaction(String id){
    setState(() {
      
      _userTransactions.removeWhere(
        (tx)=> tx.id==id
        
      );

    });

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
    final appBar1=AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed:()=> _startNewTransaction(context),
          )
        ],
    );
    return Scaffold(
      appBar:appBar1, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (
                MediaQuery.of(context).size.height //get the total height
                -appBar1.preferredSize.height //remove appBar height
                -MediaQuery.of(context).padding.top)*0.4, //remove status bar height
                
              child: Chart(getRecentTransaction)
            ),
            Container(
              height: (
                MediaQuery.of(context).size.height
                -appBar1.preferredSize.height
                -MediaQuery.of(context).padding.top)*0.6,
              //here we also subtract the height of appBar
              child: TransactionList(_userTransactions,_deleteTransaction)
            ),
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
