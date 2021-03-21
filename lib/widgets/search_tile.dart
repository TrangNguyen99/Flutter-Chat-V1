import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final String name;
  final String email;
  final message;

  SearchTile({this.name, this.email, this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.face),
        title: Text(name),
        subtitle: Text(email),
        trailing: IconButton(icon: Icon(Icons.message), onPressed: message),
      ),
    );
  }
}
