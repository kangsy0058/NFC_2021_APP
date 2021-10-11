

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_app21/dataInit_page.dart';

Dialog initWSN(h, w,TextEditingController textCon){
  ImagePicker picker = ImagePicker();
  XFile? image;
  String img64;
  Color fn = Colors.grey;

  return Dialog(
    child: Container(
      height: h * 0.8,
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [


          Padding(
            padding: EdgeInsets.fromLTRB(0, h * 0.02, 0, h*0.02),
            child: Center(
              child: Text("STEP2. 개인 안심번호 등록",
                style: TextStyle(
                    color: mainColor,
                    fontSize: w * 0.027,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text("개인 안심번호는 NAVER의 QR체크인에서 확인",),),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,h * 0.025, 0, h * 0.01),
                  child: Text("QR체크인 화면을 스크린샷 찍어 업로드 하기"),),
            ],
          ),
          // image == null ? Text("d") : Image.file(File(image.path)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    image =
                    await picker.pickImage(source: ImageSource.gallery,);
                    print("이미지 경로임 :\n" + image!.path);
                    final bytes = File(image!.path).readAsBytesSync();
                    img64 = base64Encode(bytes); //이미지 바이트화
                    print("여기부터\n" + img64 + "여기까지\n");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: borderColor,
                      onPrimary: Colors.white,
                      minimumSize: Size(w * 0.03, h * 0.12),
                      alignment: Alignment.center,
                      textStyle: const TextStyle(fontSize: 18)),
                  child: Text("스크린샷 추가",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),), //번호
                ),
              ),
              Container(
                width: w*0.18,
                height: h*0.12,
                child: TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  controller: textCon,
                  cursorColor: mainColor,
                  onSubmitted: (test){
                  },
                  decoration: InputDecoration(
                    labelText: '개인안심번호 입력',
                    labelStyle: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: mainColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: mainColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                print(textCon.text);
                textCon.text = textCon.text;
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: mainColor,
                  onPrimary: Colors.white,
                  minimumSize: Size(w * 0.36, h * 0.12),
                  alignment: Alignment.center,
                  textStyle: const TextStyle(fontSize: 18)),
              child: Text("완료"), //번호
            ),
          ),


        ],
      ),
    ),
  );
}
