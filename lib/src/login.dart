import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nfc_app21/src/FB_home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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


  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  //IOS 로그인
  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
      rawNonce: rawNonce,
    );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
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
    print(body);//인가코드 부분 이거를 가지고 토큰받기 호출!

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token',{
      'grant_type' : 'authorization_code',
      'client_id':"34014e7ffd6391bbfa87d855c6073cac",
      'redirect_uri':"https://picturesque-fluorescent-border.glitch.me/callbacks/kakao/sign_in",
      'code':body['code'],
    });

    var response = await http.post(tokenUrl);
    Map<String,dynamic> accessTokenResult = jsonDecode(response.body);
    print("token pass check ");
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 10, 40),
              child: Image.asset("imgs/logo.png",fit: BoxFit.fitHeight,),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            //   child: SignInButton(Buttons.Google, onPressed: signInWithGoogle),
            // ),
            Padding(
              padding: const  EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: SignInButton(Buttons.AppleDark, onPressed: signInWithApple),
            ),
            Padding(
              padding: const  EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: InkWell(
                onTap: signInWithKakao,
                child: Container(
                  height: 36,
                    child: Image.asset("imgs/kakao_login.png",fit: BoxFit.fitHeight,)),
              )
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            //   child: SignInButton(Buttons.Google, onPressed: ()async {
            //     var  test = isUser("kakao:1795389240");
            //     print(await test);
            //   }),
            // ),
          ],
        ),
      ),
    );
  }
}
