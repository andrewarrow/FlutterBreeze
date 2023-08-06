import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'session.dart'; 
import 'menu.dart'; 
import 'cat.dart'; 
import 'util.dart'; 
import 'dart:convert';
import 'dart:io';

class HomePage extends StatelessWidget {

  final Map<String, dynamic>? user;
  BuildContext otherContext;

  HomePage(this.user, this.otherContext) {
  }

  Future<List<dynamic>> _fetchData() async {
    String id = user?["id"].toString() ?? '';

    final Uri dashboardUri = Uri.parse('http://localhost:3000/api/cats');

    final Map<String, String> headers = {
     'Authorization': 'Bearer '+id,
    };

    int statusCode = 200;
    String body = '[{"id": 1, "name": "milkshake"}]';
  try {
    final response = await http.get(
      dashboardUri,
      headers: headers,
    );
  } catch (e) {
      print('Error: ${e.toString()}');
  }

    if (statusCode == 200) {
      await Util.writeToFile(body);

      final List<dynamic> jsonData = jsonDecode(body);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildTextField(),
        ),
        Expanded(
          child: buildFutureBuilder(context),
        ),
      ],
    );
  }

  Widget buildTextField() {
    String prefix = 'Cats for ';
    String? labelValue = user?['name'];

    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        prefix + (labelValue ?? ''),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      ],
    );
  }

  Widget buildFutureBuilder(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic>? dataList = snapshot.data;
          return buildListView(dataList, context);
        }
      },
    );
  }

  Widget buildListView(List<dynamic>? dataList, BuildContext context) {
    return buildCatListView(dataList, context);
  }

  Widget buildCatListView(List<dynamic>? dataList, BuildContext context) {
    return ListView.builder(
      itemCount: dataList?.length ?? 0,
      itemBuilder: (context, index) {

      String url = "https://i.imgur.com/LMP44Tt.jpeg";
      String? name = dataList?[index]["name"].toString();
      return GestureDetector(
        onTap: () {
          Map<String, dynamic>? cat = dataList?[index];
          if (cat != null) {
            Navigator.push(context,
              MaterialPageRoute(
               builder: (context) => CatPage(url, cat, user, otherContext),
             ),
           );
          }
        },
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: 40,
            height: 40, 
            fit: BoxFit.cover,
          ),
          title: Text(name ?? ''),
        )
       );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPage(this.user, otherContext),
                  ),
                );
          },
        ),
        title: Image.asset('assets/paws.jpg', width: 280, height: 100),
      ),
      body: buildBody(context),
    );
  }
}
