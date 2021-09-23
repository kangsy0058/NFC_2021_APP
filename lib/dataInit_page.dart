import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/main.dart';

class DataInitPage  extends StatefulWidget {
  @override
  _DataInitPage createState() => _DataInitPage();
}

class _DataInitPage extends State<DataInitPage> {
  final textCon = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController()];

  var visable = [false, false, false, false];
  String barcodeScanRes = "";


  Dialog initWSN(h, w,TextEditingController textCon) {

    ImagePicker picker = ImagePicker();
    XFile? image;
    String img64;

    return Dialog(
      child: Container(
        height: h * 1.1,
        width: w,
        child: Column(
          children: [
            // image == null ? Text("d") : Image.file(File(image.path)),

            OutlinedButton(onPressed: () async {
              image = await picker.pickImage(source: ImageSource.gallery,);
              print("이미지 경로임 :\n" + image!.path);
              final bytes = File(image!.path).readAsBytesSync();

              img64 = base64Encode(bytes);//이미지 바이트화
              print("여기부터\n" + img64 + "여기까지\n");
            }, child: Text("스샷 선택")),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: textCon,
                decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  labelText: '개인안심번호',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),

              ),
            ),
            OutlinedButton(onPressed: () {
              super.setState(() {
                print(textCon.text);
                textCon.text = textCon.text;


              });
              Get.back();


            }, child: Text("완료")),


          ],
        ),
      ),
    );
  }


  Dialog initPSN(h, w,TextEditingController textCon) {
    return Dialog(
      child: Container(
        height: h * 1.1,
        width: w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, h*0.1, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        textCon.text = "testNFC";
                        super.setState(() {

                        });
                        Get.back();

                      }, child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("NFC", style: TextStyle(fontSize: w * 0.03),),
                  )),
                  OutlinedButton(
                    onPressed: () async {
                      barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          "#8aadf8", "취소", false, ScanMode.DEFAULT);
                      print("WSN출력 부분 @@@@@@@@"+barcodeScanRes);
                      if(barcodeScanRes!=""){
                        textCon.text = barcodeScanRes;
                        super.setState(() {

                        });
                        Get.back();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        " QR ", style: TextStyle(fontSize: w * 0.03),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.7,
              width: w,
              child: Lottie.asset("assets/lottie/progress.json"),

            )
          ],
        ),
      ),
    );
  }

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
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: '이름',
                          labelStyle: TextStyle(
                            color: Colors.white70,
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
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.lightBlueAccent,
                          labelText: '이메일',
                          labelStyle: TextStyle(
                            color: Colors.white70,
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
                                color: Colors.lightBlueAccent,
                                fontSize: 20,
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
