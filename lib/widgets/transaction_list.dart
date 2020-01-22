import 'package:flutter/material.dart';


import '../models/transaction.dart';
import '../widgets/transaction_item.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;

  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    
    return _userTransactions.isEmpty
        ? Column(
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
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(oneTransaction: _userTransactions[index], deleteTx: deleteTx);
            },
            itemCount: _userTransactions.length,
          );
  }
}

