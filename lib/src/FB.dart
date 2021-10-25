import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nfc_app21/data/corna.dart';
import 'package:nfc_app21/src/FB_home.dart';

class fbApp extends StatelessWidget {//firebase 초기화 하는 역할



  @override
  Widget build(BuildContext context) {

    return FutureBuilder(//future 빑더 future값에 따라 결과
        future: Firebase.initializeApp(),// firebase를 사용 하기 위해 init 하는 과정
        builder: (context, snapshot) {//snapshot에 init 진행 담긴다
          if(snapshot.hasError){//에러가 생긴 경으
            return Center(child: Text("load err"),);
          }
          if (snapshot.connectionState== ConnectionState.done){//정상적인 경우 fb home을 돌려준다
            return fb_home();
          }
          return CircularProgressIndicator();//로딩중
        },);
  }
}
