import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Util {
  static Future<void> writeToFile(String content) async {
    Directory directory = await getApplicationDocumentsDirectory();
    debugPrint('${directory.path}/output.txt');
    File file = File('${directory.path}/output.txt');

    await file.writeAsString(content);
  }
}

