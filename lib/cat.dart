import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'session.dart'; 
import 'util.dart'; 
import 'dart:convert';
import 'dart:io';

class CatPage extends StatelessWidget {

  String name = '';
  String url = '';
  final Map<String, dynamic>? cat;
  final Map<String, dynamic>? user;
  BuildContext otherContext;
  CatPage(this.url, this.cat, this.user, this.otherContext) {
    name = cat?["name"].toString() ?? '';
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildTextField(),
        ),
        AspectRatio(
          aspectRatio: 16 / 9, 
          child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
         ),
       ),
    ],
    );
  }

  Widget buildTextField() {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
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
