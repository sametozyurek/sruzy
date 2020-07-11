import 'package:flutter/material.dart';
import 'package:sruzy/screens/anasayfa.dart';
import 'package:sruzy/screens/giris.dart';
import 'package:sruzy/screens/kayit.dart';

void main() => runApp(MyApp());

final yonlendirmeler = <String, WidgetBuilder>{
  Giris.tag: (context)=>Giris(),
  KayitOl.tag: (context)=>KayitOl(),
  AnaSayfa.tag: (cotext)=>AnaSayfa(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: Giris(),
      routes: yonlendirmeler, );
  }
}
