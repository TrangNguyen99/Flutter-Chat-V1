import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isByMe;

  MessageTile({this.message, this.isByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: Text(message),
      ),
    );
  }
}
