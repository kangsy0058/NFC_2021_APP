// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/setting_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


Future<void> main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  static final title = '일단 하는중:)';
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    LogPage(),
    SettingPage()
  ];

  var _currentIndex = 0;

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (_error) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () {
                  print("눌림");
                }, child: Text("오류")
                ),
              ],

            ),
          ),
        ),
      );
    }
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () {
                  print("눌림");
                }, child: Text("로딩")
                ),
              ],

            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: App.title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(App.title),
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
      ),
    );
  }
}

