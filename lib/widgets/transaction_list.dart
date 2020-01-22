import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      //padding to make space between text and border
                      child: FittedBox(
                        //to overcome problem of text is going after circle
                        child: Text(
                          '₹${_userTransactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMd().format(_userTransactions[index].date),
                    style: TextStyle(color: Colors.grey),
                    //do not apply const to this text widget because its value will change according to time by that I means that its value is dynamic
                  ),
                  trailing: MediaQuery.of(context).size.width>500?
                  FlatButton.icon(
                    icon: const Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    label: const Text('Delete'),
                    onPressed: () => deleteTx(_userTransactions[index].id),
                  )
                  :   
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(_userTransactions[index].id),
                  ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
