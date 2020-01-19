import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            //textColor: Colors.white,
            color: Theme.of(context).primaryColor,
          )
        : FlatButton(
            onPressed: handler,
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text(
              text,
            ),
          );
  }
}
