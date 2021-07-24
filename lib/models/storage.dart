import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/2048_boards.txt');
  }

  static Future<List<String>> readData() async {
    try {
      final file = await _localFile;
      final content = await file.readAsLines();
      return content;
    } catch (e) {
      return [];
    }
  }

  static Future<File> writeData(List<String> lines) async {
    final file = await _localFile;
    String content = lines.join('\n');
    return file.writeAsString(content);
  }
}
