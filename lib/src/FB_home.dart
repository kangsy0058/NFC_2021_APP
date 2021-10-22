import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_app21/dataInit_page.dart';
import 'package:nfc_app21/main.dart';
import 'package:nfc_app21/src/login.dart';
import 'package:http/http.dart' as http;
class fb_home extends StatefulWidget {
  @override
  _fb_homeState createState() => _fb_homeState();
}

class _fb_homeState extends State<fb_home> {

  Future<bool> isUser(String uid)  async{
    String _baseUrl = "210.119.104.206:8080";
    String _getData = "/v1/common/user/userinfo";

    final queryParameters = {
      'UUID': uid,
    };
    var url = Uri.http (
        _baseUrl,
        _getData,
        queryParameters);
    var response = await http.get(url);
    var test = jsonDecode(response.body);
    print(response.body);

    if(test["User_log"]["UUID"]=="") {
      return Future(() => false);
    }else{
      return Future(() => true);

    }

  }





  @override
  void initState() {


  }
  final UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),// stream 이라 stramBuilder를 통해 받기
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return LoginWidget();
          }
          else{


            // if(test){
            //   print("dkdkd");
            //
            // }else{
            //   print("이건 뭐야");
            // }
            //
            //
            //
            //   return DataInitPage();

            return App();

          }
        }
        ),
    );
  }


}
