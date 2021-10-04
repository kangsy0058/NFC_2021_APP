

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
            print(textCon.text);
            textCon.text = textCon.text;
            Get.back();

          }, child: Text("완료")),


        ],
      ),
    ),
  );
}
