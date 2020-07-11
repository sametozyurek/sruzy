import 'package:flutter/material.dart';

class PaylasimSayfasi extends StatefulWidget {
  @override
  _PaylasimSayfasiState createState() => _PaylasimSayfasiState();
}

class _PaylasimSayfasiState extends State<PaylasimSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paylasim ekleme sayfasi."),
      ),
    );
  }
}