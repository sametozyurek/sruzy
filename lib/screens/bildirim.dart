import 'package:flutter/material.dart';

class BildirimSayfasi extends StatefulWidget {
  @override
  _BildirimSayfasiState createState() => _BildirimSayfasiState();
}

class _BildirimSayfasiState extends State<BildirimSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirim Sayfasi"),
      ),
    );
  }
}