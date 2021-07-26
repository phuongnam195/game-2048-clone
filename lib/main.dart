import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/about_screen.dart';
import './screens/score_screen.dart';
import 'screens/play_screen.dart';
import './screens/main_screen.dart';
import 'data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then((val) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    repo.readData().then((List<String> lines) {
      for (int i = 0; i < lines.length; i++) {
        boards[i].setDataFromBuffer(lines[i]);
      }
    });

    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      routes: {
        '/': (ctx) => MainScreen(),
        PlayScreen.routeName: (ctx) => PlayScreen(),
        ScoreScreen.routeName: (ctx) => ScoreScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen(),
      },
    );
  }
}
