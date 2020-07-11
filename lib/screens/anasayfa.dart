import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  static String tag = 'ana-sayfa';
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
    );
  }
}