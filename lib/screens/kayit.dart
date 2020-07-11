import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KayitOl extends StatefulWidget {
  static String tag = 'kayit-sayfasi';
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  TextEditingController adController = new TextEditingController();
  TextEditingController soyadController = new TextEditingController();
  TextEditingController kadiController = new TextEditingController();
  TextEditingController sifreController = new TextEditingController();
  TextEditingController epostaController = new TextEditingController();

  String cevap;

  bool _adValidate = false;
  bool _soyadValidate = false;
  bool _kadiValidate = false;
  bool _sifreValidate = false;
  bool _epostaValidate = false;
  bool _kayitepostaValidate = false;
  bool _kayitKAdiValidate = false;

  Future _kayit() async {
    await Future.delayed(Duration(milliseconds: 10));
    String ad = adController.text;
    String soyad = soyadController.text;
    String kadi = kadiController.text;
    String sifre = sifreController.text;
    String eposta = epostaController.text;

    var url = 'http://sametozyurek.com.tr/databases/kayit.php';

    var response = await http.post(url, body: {
      'ad': ad,
      'soyad': soyad,
      'kadi': kadi,
      'sifre': sifre,
      'eposta': eposta,
    });
    //cevap = response.body;
    //print(cevap);
  }

  Future _cevap() async{
    await Future.delayed(Duration(milliseconds: 10));
    String ad = adController.text;
    String soyad = soyadController.text;
    String kadi = kadiController.text;
    String sifre = sifreController.text;
    String eposta = epostaController.text;

    var url = 'http://sametozyurek.com.tr/databases/cevap.php';

    var response = await http.post(url, body: {
      'ad': ad,
      'soyad': soyad,
      'kadi': kadi,
      'sifre': sifre,
      'eposta': eposta,
    });
    cevap = response.body;
    print(cevap);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final ad = TextFormField(
      onChanged: (text) async{
        _cevap();
      },
      controller: adController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "İsim",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _adValidate ? 'Burası boş bırakılamaz!' : null,
      ),
      keyboardType: TextInputType.text,
    );

    final soyad = TextFormField(
      onChanged: (text) async{
        _cevap();
      },
      controller: soyadController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Soyisim",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _soyadValidate ? 'Burası boş bırakılamaz!' : null,
      ),
    );

    final kadi = TextFormField(
      onChanged: (text) async{
        _cevap();
      },
      controller: kadiController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Kullanıcı Adı",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _kadiValidate ? 'Burası boş bırakılamaz!' : null,
        errorText:
            _kayitKAdiValidate ? 'Böyle bir kullanıcı adı bulunmakta!' : null,
      ),
    );

    final sifre = TextFormField(
      onChanged: (text) async{
        _cevap();
      },
      controller: sifreController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Şifre",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _sifreValidate ? 'Burası boş bırakılamaz!' : null,
      ),
    );

    final eposta = TextFormField(
      onChanged: (text) async{
        _cevap();
      },
      controller: epostaController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "E-Posta",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _epostaValidate ? 'Burası boş bırakılamaz!' : null,
        errorText: _kayitepostaValidate ? 'Böyle bir e-posta bulunmakta!' : null,
      ),
    );

    final kayitOlButon = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        padding: EdgeInsets.all(10.0),
        color: Colors.lightBlue,
        child: Text(
          "Kayıt Ol",
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
        onPressed: () {
          setState(() {
            _kayit();
            if (adController.text.isEmpty) {
              _adValidate = true;
            } else {
              _adValidate = false;
            }
            if (soyadController.text.isEmpty) {
              _soyadValidate = true;
            } else {
              _soyadValidate = false;
            }
            if (epostaController.text.isEmpty) {
              _epostaValidate = true;
            } else {
              _epostaValidate = false;
              if (cevap == "0") {
                _kayitepostaValidate = true;
              } else {
                _kayitepostaValidate = false;
              }
            }
            if (kadiController.text.isEmpty) {
              _kadiValidate = true;
            } else {
              _kadiValidate = false;
              if (cevap == "1") {
                _kayitKAdiValidate = true;
              } else {
                _kayitKAdiValidate = false;
              }
            }
            if (sifreController.text.isEmpty) {
              _sifreValidate = true;
            } else {
              _sifreValidate = false;
            }
          });
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 36.0, right: 36.0),
          children: <Widget>[
            logo,
            SizedBox(height: 24.0),
            ad,
            SizedBox(height: 8.0),
            soyad,
            SizedBox(height: 8.0),
            eposta,
            SizedBox(height: 8.0),
            sifre,
            SizedBox(height: 8.0),
            kadi,
            SizedBox(height: 8.0),
            kayitOlButon,
          ],
        ),
      ),
    );
  }
}
