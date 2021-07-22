// @dart=2.9

import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
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
  initializeDateFormatting().then((_) => runApp(Myapp()));
}



class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 투명색
    ));

    return MaterialApp(
      title: "firetest",
      home: fbApp(),
    );
  }
}


Container buildAccountOption(
    BuildContext context, String title, String str, IconData icn) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.58,
      height: MediaQuery.of(context).size.height * 0.05,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text(title + " 수정"),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(0xff8aadf8),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.fromLTRB(10, 7, 7, 7),
                        margin: EdgeInsets.fromLTRB(10, 10, 7, 10),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                decoration: new InputDecoration.collapsed(
                                    hintText: str),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: IconButton(
                                icon: Icon(icn),
                                //onPressed: () => 사진 가져오깅~,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xff8aadf8),
                              //padding: const EdgeInsets.symmetric(horizontal: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          //onPressed: ,
                          child: Text(
                            "수정 완료",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              str,
              textAlign: TextAlign.left,
            ),
            Icon(icn),
          ],
        ), //번호
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          alignment: Alignment.centerLeft,
        ),
      ));
}


class App extends StatefulWidget {
  static final title = '온기';

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  int selectedIndex = 0;
  final List<Widget> _children = [HomePage(), LogPage(), SettingPage()];

  var _currentIndex = 0;

  List listItem = ['ALL', '긴급', '?머더라'];

  String valueChoose = 'ALL';

  FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();

    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //세로 고정

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
          iconTheme: IconThemeData(color: Colors.grey)),
      endDrawer: Drawer(
        // width: MediaQuery.of(context).size.width*0.7,
        // height: MediaQuery.of(context).size.height * 0.8,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(40),
        //       bottomLeft: Radius.circular(5),
        //     ),
        // ),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    Text(
                      "SET",
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Text("개인 안심번호"),
                    buildAccountOption(context, "개인안심번호", "누70카63",
                        CupertinoIcons.photo_on_rectangle),
                    Text("디바이스 ID"),
                    buildAccountOption(context, "디바이스 ", "WSN1234",
                        CupertinoIcons.pencil_ellipsis_rectangle),
                    Text("알림"),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.58,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,
                                    width: 0.4),
                                borderRadius: BorderRadius.circular(20)),
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: Icon(CupertinoIcons.chevron_down),
                              iconSize: 20,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: listItem.map((valueItem) {
                                return DropdownMenuItem(
                                    value: valueItem, child: Text(valueItem));
                              }).toList(),
                            ),
                          )),
                    ),
                  ],
                ),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff8aadf8),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (_) =>
                          new CupertinoAlertDialog(
                            content: Text("정말 로그아웃 하시겠습니까?"),
                            actions: [
                              CupertinoDialogAction(
                                  child: Text(
                                    "취소",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  onPressed: () => Navigator.of(context).pop()),
                              CupertinoDialogAction(
                                  child: Text(
                                    "확인",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  onPressed: () {
                                    print("로그아웃");
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          ));
                    },
                    //FirebaseAuth.instance.signOut, //현재 로그인한 사용자 로그아웃
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
          )),

      body: _children[_currentIndex],

    );
  }
}
