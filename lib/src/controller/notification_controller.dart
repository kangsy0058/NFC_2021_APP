import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class PushManager {
  static final PushManager _manager = PushManager._internal();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  factory PushManager() {
    return _manager;
  }
  PushManager._internal() {
    // 초기화 코드
  }

  void _requestIOSPermission() {
    _firebaseMessaging.requestPermission(alert: true,sound: true,badge: true,

    );
  }

  void registerToken() {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }

    _firebaseMessaging.getToken().then((token) {
      print(token);
      // 장고 서버에 token알려주기
    });
  }

  void listenFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });


  }
}


// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
//
// class NotificationController extends GetxController {
//   static NotificationController get to => Get.find();
//   FirebaseMessaging _messaging = FirebaseMessaging();
//   RxMap<String, dynamic> message = Map<String, dynamic>().obs;
//
//   @override
//   void onInit() {
//     _initNotification();
//     _getToken();
//     super.onInit();
//   }
//   Future<void> _getToken() async {
//     try {
//       String token = await _messaging.getToken();
//       print("토큰부분____________________");
//       print(token);
//     } catch (e) {}
//   }
//
//   void _initNotification() {
//     _messaging.requestNotificationPermissions(const IosNotificationSettings(
//         sound: true, badge: true, alert: true, provisional: true));
//
//     _messaging.configure(
//       onMessage: _onMessage,
//       onLaunch: _onLaunch,
//       onResume: _onResume,
//     );
//   }
//
//   Future<String> _onResume(Map<String, dynamic> message) async {
//     print("_onResume : $message");
//     return "sdf";
//   }
//
//   Future<String> _onLaunch(Map<String, dynamic> message)async {
//     print("_onLaunch : $message");
//     _actionOnNotification(message);
//     return "sdf";
//   }
//
//   void _actionOnNotification(Map<String, dynamic> messageMap) {
//     message(messageMap);
//   }
//
//   Future<String> _onMessage(Map<String, dynamic> message) async {
//     print("_onMessage : $message");
//     return "sdf";
//   }
// }

