import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'index.dart'; 
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _loginError;
  final TextEditingController _usernameController = TextEditingController(text: 'milkshake');
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    final Uri loginUri = Uri.parse('http://localhost:3000/api/login');

    int statusCode = 0;
    String body = '';
    try {
      final response = await http.post(
        loginUri,
        body: {
          'username': username,
          'password': password,
        },
      );
      statusCode = response.statusCode;
      body = response.body;
    } catch (e) {
      print('Error: ${e.toString()}');
    }

    if (statusCode == 200) {
      final jsonResponse = json.decode(body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(jsonResponse, context),
        ),
      );
    } else {
      setState(() {
        _loginError = 'Login failed with status code: ${statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breeze'),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_loginError != null) 
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                child: Text(
                  _loginError!,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Image.asset(
              'assets/paws.jpg',
              width: 280, 
              height: 124,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
             onPressed: () => _login(context), 
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
