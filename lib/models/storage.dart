import 'package:universal_html/html.dart';

class Repository {
  final Storage _localStorage = window.localStorage;

  Future<List<String>> readData() async {
    try {
      String? content = _localStorage['2048_boards'];
      if (content == null) return [];
      List<String> lines = content.split('\n');
      return lines;
    } catch (e) {
      return [];
    }
  }

  Future writeData(List<String> lines) async {
    String content = lines.join('\n');
    _localStorage['2048_boards'] = content;
  }
}
