import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginWidget extends StatelessWidget {


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!
        .authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void testSigIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email:  "test@naver.com",
          password: "1q2w3e"
      );
      //  print(await userCredential.user!.getIdToken());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential> signInWithKakao() async {
    final clientState =Uuid().v4();
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize',{
      'response_type' : 'code',
      'client_id':"34014e7ffd6391bbfa87d855c6073cac",
      'redirect_uri':"https://picturesque-fluorescent-border.glitch.me/callbacks/kakao/sign_in",
      'state':clientState,
    });
    final result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: "webauthcallback");
    final body = Uri.parse(result).queryParameters;
    print("이부부ㅜ부부ㅜ붑ㄴ");
    print(body);//인가코드 부분 이거를 가지고 토큰받기 호출!

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token',{
      'grant_type' : 'authorization_code',
      'client_id':"34014e7ffd6391bbfa87d855c6073cac",
      'redirect_uri':"https://picturesque-fluorescent-border.glitch.me/callbacks/kakao/sign_in",
      'code':body['code'],
    });

    var response = await http.post(tokenUrl);
    Map<String,dynamic> accessTokenResult = jsonDecode(response.body);
    print("토큰 넘어오는 부분ㄴㄴㄴㄴㄴㄴ");
    var responseCustomToken = await http.post(Uri.parse("https://picturesque-fluorescent-border.glitch.me/callbacks/kakao/token"),
        body: {"accessToken":accessTokenResult['access_token']});


    return await FirebaseAuth.instance.signInWithCustomToken(responseCustomToken.body);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("imgs/test.png",fit: BoxFit.fitHeight,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SignInButton(Buttons.Google, onPressed: signInWithGoogle),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SignInButton(Buttons.AppleDark, onPressed: signInWithKakao),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SignInButton(Buttons.Email, onPressed: testSigIn),
            ),
          ],
        ),
      ),
    );
  }
}
