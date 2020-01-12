import 'package:flutter/material.dart';

class AboutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
