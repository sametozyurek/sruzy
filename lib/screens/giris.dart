import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sruzy/screens/kayit.dart';


import 'bottom_menu.dart';

class Giris extends StatefulWidget {
  static String tag = 'giris-sayfasi';
  @override
  _GirisState createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  TextEditingController epostaController = new TextEditingController();
  TextEditingController sifreController = new TextEditingController();
  bool _epostaValidate = false;
  bool _sifreValidate = false;
  bool _girisValidate = false;

  Future _giris() async{
    await Future.delayed(Duration(milliseconds: 10));
    String eposta = epostaController.text;
    String sifre = sifreController.text;
    
    var url = 'http://sametozyurek.com.tr/databases/giris.php';

    var response =  await http.post(url, body: {
      'eposta': eposta,
      'sifre': sifre,
    });
    
    appData.cevap = response.body;
    print(appData.cevap);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Text("Sruzy", style: TextStyle(fontSize: 42.0, color: Colors.grey.shade600,),),
      ),
    );

    final eposta = TextFormField(
      onChanged: (text) async{
        _giris();
      },
      controller: epostaController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'E-Posta',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _epostaValidate ? 'Burası boş bırakılamaz!' : null,
        errorText: _girisValidate ? 'E-Posta veya Şifre geçersiz!' : null,
      ),
    );

    final sifre = TextFormField(
      onChanged: (text) async{
        _giris();
      },
      controller: sifreController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Şifre',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        helperText: _sifreValidate ? 'Burası boş bırakılamaz!' : null,
        errorText: _girisValidate ? 'Şifre veya E-Posta geçersiz!' : null,
      ),
    );

    final girisButon = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(10),
        color: Colors.grey,
        child: Text('Giriş',
            style: TextStyle(color: Colors.white, fontSize: 22.0)),
        onPressed: () {
          setState(() {
            _giris();
            if (epostaController.text.isEmpty && sifreController.text.isEmpty) {
              _epostaValidate = true;
              _sifreValidate = true;
            } else if (epostaController.text.isEmpty) {
              _epostaValidate = true;
              _sifreValidate = false;
            } else if (sifreController.text.isEmpty) {
              _sifreValidate = true;
              _epostaValidate = false;
            } else {
              _epostaValidate = false;
              _sifreValidate = false;
                if (appData.cevap == "0") {
                  _girisValidate = true;
              } else {
                  _girisValidate = false;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomMenu(id: appData.cevap,)));
              }
            }
          });
        },
      ),
    );

    final kayitOl = FlatButton(
      child: Text(
        "Kayıt Ol",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(KayitOl.tag);
      },
    );

    final sifreUnuttum = FlatButton(
      child: Text('Şifremi Unuttum?',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.0,
          )),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 26.0),
            eposta,
            SizedBox(height: 8.0),
            sifre,
            SizedBox(height: 24.0),
            girisButon,
            sifreUnuttum,
            kayitOl,
          ],
        ),
      ),
    );
  }
}

class AppData{
  static final AppData _appData = new AppData._internal();

  String cevap;

  factory AppData(){
    return _appData;
  }

  AppData._internal();
}
final appData = AppData();