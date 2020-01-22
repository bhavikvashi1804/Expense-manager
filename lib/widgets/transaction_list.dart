import 'package:flutter/material.dart';


import '../models/transaction.dart';
import '../widgets/transaction_item.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;

  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    
    return _userTransactions.isEmpty? 
    Column(
      children: <Widget>[
        Text(
         'No Transactions',
         style: Theme.of(context).textTheme.title,
        ),
        const SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/no_tx.png',
          fit: BoxFit.cover,
        ),
      ],
    )
    : 
    //first simple change ListView builder to ListView
    ListView(
      children: 
        _userTransactions.map(
          (tx)=>TransactionItem(
            key: ValueKey(tx.id),
            //second pass key 
            //UniqueKey generates unique key for each item
            //I am using my own key instead of UniqueKey 
            oneTransaction: tx,
            deleteTx:deleteTx)
        ).toList(),
    );     
  }   
}

