import 'package:flutter/material.dart';
import 'package:sruzy/screens/profil.dart';

import 'giris.dart';
import 'anasayfa.dart';
import 'arama.dart';
import 'bildirim.dart';
import 'ekle.dart' as ekle;

class BottomMenu extends StatefulWidget {
  final String id;
  BottomMenu({Key key, @required this.id}) : super(key: key);
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {

    //menu
  int _currenTab = 0;

  final List<Widget> screens = [
    AnaSayfa(),
    AramaSayfasi(),
    BildirimSayfasi(),
    Profil(id: appData.cevap),
  ]; // tab icerigi

  // aktif sayfa
  Widget _currentScreen = AnaSayfa();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: bucket,
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ekle.PaylasimSayfasi()),);
        },
      ),

      // FAB pozisyonu
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // bottom app bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40.0,
                    onPressed: (){
                      setState(() {
                        _currentScreen = AnaSayfa();
                        _currenTab  = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.home, color: _currenTab == 0 ? Colors.blue : Colors.grey,),
                        Text('Ana Sayfa', style: TextStyle(color: _currenTab == 0 ? Colors.blue : Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40.0,
                    onPressed: (){
                      setState(() {
                        _currentScreen = AramaSayfasi();
                        _currenTab  = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search, color: _currenTab == 1 ? Colors.blue : Colors.grey,),
                        Text('Kesfet', style: TextStyle(color: _currenTab == 1 ? Colors.blue : Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40.0,
                    onPressed: (){
                      setState(() {
                        _currentScreen = BildirimSayfasi();
                        _currenTab  = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite, color: _currenTab == 2 ? Colors.blue : Colors.grey,),
                        Text('Bildirim', style: TextStyle(color: _currenTab == 2 ? Colors.blue : Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40.0,
                    onPressed: (){
                      setState(() {
                        _currentScreen = Profil(id: appData.cevap,);
                        _currenTab  = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person, color: _currenTab == 3 ? Colors.blue : Colors.grey,),
                        Text('Profil', style: TextStyle(color: _currenTab == 3 ? Colors.blue : Colors.grey,),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}