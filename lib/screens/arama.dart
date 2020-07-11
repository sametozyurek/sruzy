import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:sruzy/screens/arama_sonuc.dart';
import 'package:sruzy/screens/giris.dart';

class AramaSayfasi extends StatefulWidget {
  @override
  _AramaSayfasiState createState() => _AramaSayfasiState();
}

class _AramaSayfasiState extends State<AramaSayfasi> {
  static final SearchBarController aramaController = new SearchBarController();

  List kullanicilar;
  String adi = "adi",
      id = "id",
      soyadi = "soyadi",
      pResmi = "p_resmi",
      takipci = "takipci",
      takip = "takip",
      kAdi = "kullanici_adi";

  Future<List<Kullanici>> aramaSonuc(String aramaSonuc) async {
    await Future.delayed(Duration(seconds: 1));
    var response = await http.get(
        Uri.encodeFull(
            'http://sametozyurek.com.tr/databases/arama.php?adi=' + aramaSonuc),
        headers: {"Accept": "application/json"});
    try {
      var convertDataToJson = json.decode(response.body);
      kullanicilar = convertDataToJson['sonuc'];

      return List.generate(kullanicilar.length, (int index) {
        setState(() {
          if (kullanicilar != null) {
            id = kullanicilar[index]['id'];
            adi = kullanicilar[index]['adi'];
            soyadi = kullanicilar[index]['soyadi'];
            pResmi = kullanicilar[index]['p_resmi'];
            takipci = kullanicilar[index]['takipci'];
            takip = kullanicilar[index]['takip'];
            kAdi = kullanicilar[index]['kullanici_adi'];
            appID.cevap = kullanicilar[index]['id'];
          }
        });

        return Kullanici("$adi $soyadi", "$kAdi");
      });
    } on FormatException catch (_) {
      print("Boyle bir sonuc yok.");
    }

    print(appID.cevap);
  }

  Future _sendFollow() async {
    await Future.delayed(Duration(milliseconds: 10));
    var url = 'http://sametozyurek.com.tr/databases/takipSorgulama.php';

    var response = await http.post(url, body: {
      'user_id': appData.cevap,
      'takip_id': appID.cevap,
    });
    
    if (response.body=="0") {
      appFollow.cevap = false;
    }
    else{
      appFollow.cevap = true;
    }

    print(appData.cevap);
    print(appID.cevap);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SearchBar<Kullanici>(
            onSearch: aramaSonuc,
            onError: (error) {
              return Center(
                child: Text(
                  "Boyle bir kullanici yok",
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            },
            cancellationText: Text("Iptal"),
            onItemFound: (Kullanici kullanici, int index) {
              return ListTile(
                title: Text(kullanici.adiSoyadi),
                subtitle: Text(kullanici.kullaniciAdi),
                onTap: () {
                  _sendFollow();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AramaProfil(
                                id: appID.cevap,
                              )));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class Kullanici {
  final String adiSoyadi;
  final String kullaniciAdi;

  Kullanici(this.adiSoyadi, this.kullaniciAdi);
}

class AppID {
  static final AppID _appID = new AppID._internal();

  String cevap;

  factory AppID() {
    return _appID;
  }

  AppID._internal();
}

final appID = AppID();

class AppFollow {
  static final AppFollow _appFollow = new AppFollow._internal();

  bool cevap;

  factory AppFollow() {
    return _appFollow;
  }

  AppFollow._internal();
}

final appFollow = AppFollow();