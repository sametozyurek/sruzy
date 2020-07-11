import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class Profil extends StatefulWidget {
  final String id;
  Profil({Key key, @required this.id}) : super(key: key);

  static String tag = 'profil';
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  List data;
  var _isLoading = false;
  String adi = "adi",
      soyadi = "soyadi",
      pResmi = "p_resmi",
      takipci = "takipci",
      takip = "takip",
      kAdi = "kullanici_adi";
  /* Girise baglaniyor ve datalari cekiyor */
  Future<String> getLogin(String id) async {
    var response = await http.get(
        Uri.encodeFull(
            'http://sametozyurek.com.tr/databases/kullanici.php?id=' + id),
        headers: {"Accept": "application/json"});

    setState(() {
      _isLoading = true;
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['sonuc'];
      if (data != null) {
        adi = data[0]['adi'];
        soyadi = data[0]['soyadi'];
        pResmi = data[0]['p_resmi'];
        takipci = data[0]['takipci'];
        takip = data[0]['takip'];
        kAdi = data[0]['kullanici_adi'];
      }
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLogin(widget.id);
    });
  }

  // burasi veritabanindan gelen profil resmini iceriyor
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.5,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/logo.png'),
        fit: BoxFit.cover,
      )),
    );
  }

  //profile resmi
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 185.0,
        height: 185.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: "Nunito",
      color: Colors.black,
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    );

    return Text(
      adi + " " + soyadi,
      style: _nameTextStyle,
    );
  }

  Widget _buildNickName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: "Nunito",
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );

    return Text(
      kAdi,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatusFollowers(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        takipci,
        style: TextStyle(
          fontFamily: "Nunito",
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }

  Widget _buildStatusFollowing(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        takip,
        style: TextStyle(
          fontFamily: "Nunito",
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }

  final profilDuzenle = Padding(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      padding: EdgeInsets.all(12.0),
      color: Colors.white70,
      child: Text(
        'Profili Duzenle',
        style: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      onPressed: () {},
    ),
  );

  final mesajGonderButon = Padding(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: RaisedButton.icon(
      label: Text(""),
      icon: Icon(Icons.chat), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      //padding: EdgeInsets.all(12.0),
      color: Colors.white70,
      /*child: Text(
        "Mesaj Gonder",
        style: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),*/
      onPressed: () {},
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: !_isLoading
          ? new CircularProgressIndicator()
          : new Stack(
              children: <Widget>[
                _buildCoverImage(screenSize),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.2),
                      _buildProfileImage(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: <Widget>[
                                _buildFullName(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 20.0,
                                      ),
                                    ),
                                    Text(
                                      "Takipci",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                    ),
                                    Text(
                                      "Takip",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: <Widget>[
                                _buildNickName(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 38.0),
                                    ),
                                    _buildStatusFollowers(context),
                                    Padding(
                                      padding: EdgeInsets.only(left: 48.0),
                                    ),
                                    _buildStatusFollowing(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: mesajGonderButon,
                          ),
                          Expanded(
                            flex: 5,
                            child: profilDuzenle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
