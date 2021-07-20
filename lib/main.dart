import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/about_screen.dart';
import './screens/score_screen.dart';
import './screens/gameplay_screen.dart';
import './screens/main_screen.dart';

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
    return MaterialApp(
      title: '2048',
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      // initialRoute: '/gameplay',
      routes: {
        '/': (ctx) => MainScreen(),
        GameplayScreen.routeName: (ctx) => GameplayScreen(),
        ScoreScreen.routeName: (ctx) => ScoreScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreen(),
    );
  }
}
