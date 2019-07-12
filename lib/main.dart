import 'package:flutter/material.dart';
import 'package:caja_tic/ui/screens/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

const color_primario = const Color(0xFF00b0ed);
const color_primary_dark = const Color(0xFF007297);
const color_accent = const Color(0xFFFFA726);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //color al status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: color_primary_dark),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.dark,
        primaryColor: color_primario,
        primaryColorDark: color_primary_dark,
        accentColor: color_accent
      ),
      home: Home(),
    );
  }
}
