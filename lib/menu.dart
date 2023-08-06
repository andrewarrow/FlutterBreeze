import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'session.dart'; 
import 'util.dart'; 
import 'dart:convert';
import 'dart:io';

class MenuPage extends StatelessWidget {

  final Map<String, dynamic>? user;
  BuildContext otherContext;
  MenuPage(this.user, this.otherContext);

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildTextField(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200, 
            height: 50, 
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(otherContext, (route) => route.isFirst);
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
            ),
          ),
        ],
      ),
    ],
    );
  }

  Widget buildTextField() {
    String? labelValue = user?['name'];

    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'User: ' + (labelValue ?? ''),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(otherContext);
          },
        ),
        title: Image.asset( 'assets/paws.jpg', width: 280, height: 100),
      ),
      body: buildBody(context),
    );
  }
}
