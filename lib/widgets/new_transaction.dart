import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            FlatButton(
              onPressed: () {},
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
