import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../data.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _avaIdx = 0;

  void _launchURL() async => await canLaunch(apkUrl)
      ? await launch(apkUrl)
      : throw 'Could not launch $apkUrl';

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: GRADIENT_THEME[currentTheme],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  _avaIdx = (_avaIdx + 1) % 3;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.height / 6,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('./assets/images/avatar_$_avaIdx.jpg'),
                    fit: BoxFit.fill,
                  ),
                  border: Border.all(color: Colors.white54, width: 2),
                ),
              ),
            ),
            SizedBox(height: 10),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.height / 3),
              child: Card(
                color: Colors.black.withOpacity(0.18),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Cloned by Phuong Nam\nVersion: 1.3.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (kIsWeb)
              TextButton.icon(
                onPressed: _launchURL,
                icon: Icon(
                  Icons.android,
                  color: Color(0xff94c600),
                  size: 28,
                ),
                label: Text(
                  'For Android (.apk)',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
          ],
        ));
  }
}
