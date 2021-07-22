// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/setting_page.dart';
import 'package:nfc_app21/src/FB.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
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

Container buildAccountOption(BuildContext context, String title, String str,IconData icn) {
  return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.58,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.05,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(title + " 변경"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(str),
                      Icon(Icons.arrow_downward),
                      TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: str,
                          ))
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("변경완료"))
                  ],
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(str, textAlign: TextAlign.left,),
            Icon(icn),
          ],
        ), //번호
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          alignment:  Alignment.centerLeft,
        ),
      )


  );
}

class App extends StatefulWidget {
  static final title = '온기';

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final List<Widget> _children = [HomePage(), LogPage(), SettingPage()];

  var _currentIndex = 0;

  FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);//세로 고정
    return Scaffold(
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
      endDrawer: Container(
        width: MediaQuery.of(context).size.width*0.7,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(5),
            ),
        ),
        child:Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  Text("SET",style: TextStyle(fontSize: 20),),
                  Divider(
                    thickness: 3,
                  ),
                  Text("개인 안심번호"),
                  buildAccountOption(context, "개인안심번호", "누70카63",CupertinoIcons.pencil_ellipsis_rectangle),
                  Text("디바이스 ID"),
                  buildAccountOption(context, "디바이스 ", "WSN1234",CupertinoIcons.pencil_ellipsis_rectangle),
                  Text("알림"),
                  buildAccountOption(context, "알림", "OFF",CupertinoIcons.chevron_down),

                ],
              ),

              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff8aadf8),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: FirebaseAuth.instance.signOut, //현재 로그인한 사용자 로그아웃
                  child: Text(
                    "로그아웃",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.0,
                        color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        )
      ),

      body: _children[_currentIndex],
    );
  }
}
