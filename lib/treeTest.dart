import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestHello{
  Center resHello3(FirebaseAuth auth){
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(onPressed: () {
            print("test");
            print(auth.currentUser);

          }, child: Text("test")),
          ElevatedButton(onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                  email: "barry.allen@example.com",
                  password: "SuperSecretPassword!"
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          }, child: Text("인증")
          ),
          ElevatedButton(onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: "test@naver.com",
                  password: "1q2w3e"
              );
              print("하하하");
              print(await userCredential.user!.getIdToken());
              print("로그인 성공!");


            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, child: Text("로그인"))
        ],
      ),
    );
  }
}
TestHello testHello = TestHello();