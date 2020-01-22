import 'package:flutter/material.dart';

import 'dart:math';
import 'package:intl/intl.dart';


import '../models/transaction.dart';


class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.oneTransaction,
    @required this.deleteTx,
  }) :super(key: key);

  final Transaction oneTransaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {



  Color bgColor;


  @override
  void initState() {
    


    const availableColors=[
    Colors.purple,
    Colors.blue,
    Colors.black,
    Colors.red,
    ];

    bgColor=availableColors[Random().nextInt(4)];


    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //padding to make space between text and border
            child: FittedBox(
              //to overcome problem of text is going after circle
              child: Text(
                '₹${widget.oneTransaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.oneTransaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMd().format(widget.oneTransaction.date),
          style: TextStyle(color: Colors.grey),
          //do not apply const to this text widget because its value will change according to time by that I means that its value is dynamic
        ),
        trailing: MediaQuery.of(context).size.width>500?
        FlatButton.icon(
          icon: const Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: const Text('Delete'),
          onPressed: () => widget.deleteTx(widget.oneTransaction.id),
        )
        :   
        IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx(widget.oneTransaction.id),
        ),
      ),
    );
  }
}
