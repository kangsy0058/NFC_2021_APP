import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfc_app21/main.dart';
import 'package:nfc_app21/src/login.dart';

class fb_home extends StatefulWidget {
  @override
  _fb_homeState createState() => _fb_homeState();
}

class _fb_homeState extends State<fb_home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),// stream 이라 stramBuilder를 통해 받기
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return LoginWidget();
          }else{
            return App();

            // Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text("${snapshot.data.email}환영합니다 "),
            //       TextButton(onPressed:()async {
            //         try{
            //           print(await FirebaseAuth.instance.currentUser!.getIdToken());
            //         }catch(err){
            //           print(err);
            //         }
            //       }, child: Text("token 확인")),
            //
            //       TextButton(onPressed:FirebaseAuth.instance.signOut, child: Text("logOut"))
            //     ],
            //   ),
            // );
          }
        }),
    );
  }
}
