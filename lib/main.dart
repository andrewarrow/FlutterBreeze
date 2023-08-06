import 'package:flutter/material.dart';
import 'index.dart'; 
import 'session.dart'; 
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BreezeApp());
}

class BreezeApp extends StatelessWidget {
  const BreezeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
