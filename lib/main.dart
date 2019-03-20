import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 final color_primario = const Color(0xFF00b0ed);
 final color_primary_dart = const Color(0xFF007297);
 final color_accent = const Color(0xFFFFA726);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: color_primario,
        primaryColorDark: color_primary_dart,
        accentColor: color_accent
      ),
      home: Home(),
    );
  }
}
