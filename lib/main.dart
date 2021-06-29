// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if(_error) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () {
                  print("눌림");
                }, child: Text("오류")
                ),
              ],

            ),
          ),
        ),
      );
    }
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(onPressed: () {
                  print("눌림");
                }, child: Text("로딩")
                ),
              ],

            ),
          ),
        ),
      );
    }

    //정상 init하면 이부분 나온다
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: (){
                print("test");
              }, child: Text("test")),
              ElevatedButton(onPressed: ()async  {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
              ElevatedButton(onPressed: ()async{
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: "test@naver.com",
                      password: "1q2w3e"
                  );
                  print("하하하");

                  print(await userCredential.user.getIdToken());

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
        ),
      ),
    );
  }
}




// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter De',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       initialBinding: BindingsBuilder(
//             () {
//           Get.put(NotificationController());
//         },
//       ),
//       home: Scaffold(
//         appBar: AppBar(),
//         body: Obx(() {
//           if (NotificationController.to.message.isNotEmpty)
//             return MessageBox(); // 원하는 페이지 or 이벤트 처리
//           return Container();
//         }),
//       ),
//     );
//   }
// }