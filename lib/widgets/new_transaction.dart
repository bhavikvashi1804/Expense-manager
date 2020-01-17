import 'dart:ffi';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData(){

    final enteredTitle=titleController.text;
    final enteredAmount=double.parse(amountController.text);
    
    if(enteredTitle.isEmpty || enteredAmount <=0){
      return;
      //to exit from here
    }
    widget.addTx(enteredTitle,enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.all(10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_)=>submitData(),
            ),
            TextField(
              controller: amountController,
              onSubmitted: (_)=>submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
