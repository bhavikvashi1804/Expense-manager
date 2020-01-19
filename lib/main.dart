import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';


void main() {
  runApp(new MyApp()); 
}


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
  bool _showChart=false;

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


    final mediaQuery=MediaQuery.of(context);
    //store mediaQuery object
    
    final isLandscape=mediaQuery.orientation==Orientation.landscape;
    
   
    //preferredSizeWidget to resolve problem of prefered size widget
    final PreferredSizeWidget appBar1=Platform.isIOS?
    CupertinoNavigationBar(
      middle: Text('Expense Manager'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: ()=> _startNewTransaction(context),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    )
    :AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed:()=> _startNewTransaction(context),
          )
        ],
    );


    final txListWidget= Container(
              height: (
                mediaQuery.size.height
                -appBar1.preferredSize.height
                -mediaQuery.padding.top)*0.7,
              //here we also subtract the height of appBar
              child: TransactionList(_userTransactions,_deleteTransaction)
    );

    final pageBody=SafeArea(
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              //is landscape then display switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart',style:Theme.of(context).textTheme.title),
                  Switch.adaptive(
                    //for iOS switch color
                    activeColor: Theme.of(context).accentColor,

                    //adaptive is used to render according iOS or android
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              //if not landscape then display chart
              Container(
                height: (mediaQuery.size.height -
                        appBar1.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(getRecentTransaction),
              ),
            if (!isLandscape) txListWidget,
              //if not landsacpe then display list of tx
            if (isLandscape) _showChart
                //is landscape then according to swtich change behaviour 
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar1.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(getRecentTransaction),
                  )
                : txListWidget
          ],
        ),
      ),
    );

    return Platform.isIOS?
      CupertinoPageScaffold(
        child: pageBody,
        navigationBar: appBar1 ,
      )
      :Scaffold(
      appBar:appBar1, 
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS?Container(): 
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()=> _startNewTransaction(context),
      ),
    );
  }
}


// still there is problem with keyboard