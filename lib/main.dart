import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(
              width: double.infinity,
              child: Text('Chart !'),
            ),
            color: Colors.blue,
            elevation: 5.0,

          ),
          Card(
            child: Text('List of transactions'),
          ),

        ],
      ),
    );
  }
}
