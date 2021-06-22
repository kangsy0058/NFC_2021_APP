// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:nfc_app21/src/controller/notification_controller.dart';
import 'package:nfc_app21/src/page/message_page.dart';
import 'package:nfc_app21/treeTest.dart';



Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('test1',style: TextStyle(fontSize: 30),),
              Text(testHello.resHello2("과연?????"),style: TextStyle(fontWeight: FontWeight.bold),),
              Text(testHello.resHello3("뭘까"),style: TextStyle(color: Colors.red),),
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