// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/setting_page.dart';
import 'package:nfc_app21/src/FB.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<void> main() async {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "firetest",
      home: fbApp(),
    );
  }
}

//firebase 이전
// Future<void> main() async {
//   // await Firebase.initializeApp();
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }

class App extends StatefulWidget {
  static final title = '온기';

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final List<Widget> _children = [HomePage(), LogPage(), SettingPage()];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          App.title,
          style: TextStyle(
              color: Color(0xff6382f4),
              fontWeight: FontWeight.w900,
              fontFamily: 'Cafe24'),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.icecream),
          //   title: Text("haha"),
          //   selectedColor: Colors.pink,
          // ),

          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Log"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.settings),
            title: Text("setting"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
