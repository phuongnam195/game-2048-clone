import 'package:flutter/material.dart';

import '../data.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    Widget displayText(String text) {
      return Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Manrope',
            fontSize: 20,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.none),
      );
    }

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: GRADIENT_THEME[currentTheme],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 230),
          child: Card(
              color: Colors.black.withOpacity(0.18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  displayText('Các chức năng chưa hoàn thành:'),
                  SizedBox(height: 10),
                  displayText(
                      '• Hoạt ảnh chuyển động khi vuốt\n• Lưu trữ dữ liệu vào file\n• Chưa đủ màu cho ô'),
                  SizedBox(height: 20),
                  displayText('Cloned by Phuong Nam'),
                  displayText('Version: 1.0'),
                ],
              )),
        ));
  }
}
