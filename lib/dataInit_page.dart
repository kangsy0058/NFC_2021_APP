import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_app21/common/initPSN.dart';
import 'package:nfc_app21/common/initWSN.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/main.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class DataInitPage  extends StatefulWidget {
  @override
  _DataInitPage createState() => _DataInitPage();
}
Color mainColor = Color(0xffff7f55); // 22 찐
Color pointColor = Color(0xffff4c11); // 가장 찐
Color borderColor = Color(0xffffbfaa);// 3 찐
Color backColor = Color(0xffFFFCFA);// 배경
class _DataInitPage extends State<DataInitPage> {
  bool _reading = false;
  StreamSubscription<NDEFMessage>? _stream;

  final textCon = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  var visable = [false, false, false, false];
  String barcodeScanRes = "";





  @override
  Widget build(BuildContext context) {
    final UserController user = Get.find();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: backColor,
          elevation: 0,
          title: Text(
            "온기",
            style: TextStyle(
                color: pointColor,
                fontWeight: FontWeight.w900,
                fontFamily: 'Cafe24'),
          ),
          iconTheme: IconThemeData(color: Colors.grey)),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [backColor, borderColor]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 30),
                    child: RotatedBox(
                        quarterTurns: 0,
                        child: Text(
                          '온\n기\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 38,
                            fontWeight: FontWeight.w200,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 10.0),
                    child: Container(
                      //color: Colors.green,
                      height: 200,
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60,
                          ),
                          Center(
                            child: Text(
                              '디바이스와 개인안심번호 등록',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
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
                      readOnly: true,
                      controller: textCon[0],
                      onTap: () {
                        Get.dialog(
                            initPSN(MediaQuery
                                .of(context)
                                .size
                                .width, MediaQuery
                                .of(context)
                                .size
                                .height,textCon[0])
                        );
                        setState(() {
                          visable[0] = true;
                        });
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.lightBlueAccent,
                        labelText: 'STEP1. 디바이스 등록',
                        labelStyle: TextStyle(
                          color: Colors.black,
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
                        controller: textCon[1],
                        readOnly: true,
                        onTap: () {
                          Get.dialog(
                              initWSN(MediaQuery
                                  .of(context)
                                  .size
                                  .width, MediaQuery
                                  .of(context)
                                  .size
                                  .height,textCon[1])

                          );
                          setState(() {
                            visable[1] = true;
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: 'STEP2. 개인 안심번호 등록',
                          labelStyle: TextStyle(
                            color: Colors.black,
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
                        top: 50, left: 50, right: 50),
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextField(
                        onTap: () {
                          setState(() {
                            visable[2] = true;
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: 'STEP3. 이름',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visable[2],
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
                        // readOnly: true,
                        onTap: () {
                          setState(() {
                            visable[3] = true;
                          });
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: 'STEP4. 이메일',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: visable[3],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 40, right: 50, left: 50),
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
                              '시작',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
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
