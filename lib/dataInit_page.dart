import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/main.dart';

class DataInitPage  extends StatefulWidget {
  @override
  _DataInitPage createState() => _DataInitPage();
}

class _DataInitPage extends State<DataInitPage> {
  var visable = [false, false];

  @override
  Widget build(BuildContext context) {
    final UserController user = Get.find();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff8aadf8),
          elevation: 0,
          title: Text(
            "온기",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontFamily: 'Cafe24'),
          ),
          iconTheme: IconThemeData(color: Colors.grey)),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff8aadf8), Colors.indigo]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          '시작하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
                    child: Container(
                      //color: Colors.green,
                      height: 200,
                      width: 170,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                          ),
                          Center(
                            child: Text(
                              '디바이스 ID와 개인안심번호를 입력하세요.',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: Container(
                    height: 60,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: TextField(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            child: Container(
                              height: 450,
                              child: Column(
                                children: [
                                  // Text('${user.WSN}'),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text("입력방식을 선택하세요.", style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      OutlinedButton(
                                          onPressed: () {}, child: Text("NFC")),
                                      OutlinedButton(
                                          onPressed: () {}, child: Text("QR")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 300,
                                    width:  300,
                                    child: Lottie.asset("assets/lottie/progress.json"),

                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        setState(() {
                          visable[0]=true;
                        });
                      },
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: '디바이스ID',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visable[0],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              child: Container(
                                height: 450,
                                child: Column(
                                  children: [
                                    // Text('${user.WSN}'),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text("개인안심번호 스샷 and text입력받기", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                    ),
                                   
                                    
                                  ],
                                ),
                              ),
                            ),
                          );
                          setState(() {
                            visable[1]=true;
                          });
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: '개인 안심번호',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visable[1],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 10.0,
                            // has the effect of softening the shadow
                            spreadRadius: 1.0,
                            // has the effect of extending the shadow
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          print(user.isUser);
                          Get.offAll(App());
                          user.check();
                          print(user.isUser);
                          setState(() {

                          });

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),


    );
  }
}
