// @dart=2.9

import 'dart:ffi';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nfc_app21/home_page.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/setting_page.dart';
import 'package:nfc_app21/src/FB.dart';
import 'package:nfc_app21/src/FB_home.dart';
import 'package:nfc_app21/src/login.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  initializeDateFormatting().then((_) => runApp(Myapp()));
}

class Myapp extends StatelessWidget {
  final UserController user = Get.put(UserController());
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 투명색
    ));
    return GetMaterialApp(
      title: "firetest",
      home: fbApp(),
      // home: Test(),

    );
  }
}

class UserController extends GetxController{
  var WSN = "입력X".obs;
  var PSN= "입력X".obs;
  var isUser = false.obs;

  // var cnt = 0.obs;
  getWSN(){
    return "TWSN1234".obs;
  }
  getPSN(){
    return "TPSN1234".obs;
  }
  inputWSN() {
    return this.WSN;
  }
  inputPSN(var PSN) {
    this.WSN = getPSN();
    return this.PSN;
  }


  check(){
    isUser= true.obs;
    return isUser;

  }
  checkOut(){
    isUser= false.obs;
    return isUser;

  }

  // increment(){
  //   return cnt++;
  // }
}

class Test extends StatelessWidget {


  @override
  Widget build(context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final UserController user = Get.put(UserController());
    return Scaffold(
      // count가 변경 될 때마다 Obx(()=> 를 사용하여 Text()에 업데이트합니다.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${user.WSN}"))),

        body: Column(
          children: [
            Center(child: ElevatedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
          ],
        ),
        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.add), onPressed: (){
          user.inputWSN();
        }));
  }
}
class Other extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final UserController c = Get.find();
  @override
  Widget build(context){
    // 업데이트된 count 변수에 연결
    return Scaffold(body: Center(child: Text("${c.WSN}")));
  }
}



Container buildAccountOption(
    BuildContext context, String title, var str, IconData icn) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.58,
      height: MediaQuery.of(context).size.height * 0.05,
      child: OutlinedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text(title + " 수정"),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color(0xff8aadf8),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.fromLTRB(10, 7, 7, 7),
                        margin: EdgeInsets.fromLTRB(10, 10, 7, 10),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                decoration: new InputDecoration.collapsed(
                                    hintText: "$str"),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: IconButton(
                                icon: Icon(icn),
                                //onPressed: () => 사진 가져오깅~,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: OutlinedButton(

                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xff8aadf8),
                              //padding: const EdgeInsets.symmetric(horizontal: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          //onPressed: ,
                          child: Text(
                            "수정 완료",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$str",
              textAlign: TextAlign.left,
            ),
            Icon(icn),
          ],
        ), //번호
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          alignment: Alignment.centerLeft,
        ),
      ));
}


class App extends StatefulWidget {
  static final title = '온기';

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  PickedFile _image;

  int selectedIndex = 0;
  final List<Widget> _children = [HomePage(), LogPage(), SettingPage()];

  var _currentIndex = 0;

  List listItem = ['ALL', '긴급'];

  String valueChoose = 'ALL';

  FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();

    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  final UserController user = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); //세로 고정

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            App.title,
            style: TextStyle(
                color: Color(0xffff7f55),
                fontWeight: FontWeight.w900,
                fontFamily: 'Cafe24'),
          ),
          iconTheme: IconThemeData(color: Colors.grey)),
      endDrawer: Drawer(
        // width: MediaQuery.of(context).size.width*0.7,
        // height: MediaQuery.of(context).size.height * 0.8,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(40),
        //       bottomLeft: Radius.circular(5),
        //     ),
        // ),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 20,
                  runSpacing: 15,
                  children: [
                    Text(
                      "SET",
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    Text("개인 안심번호"),
                    buildAccountOption(context, "개인안심번호",user.WSN,
                        CupertinoIcons.photo_on_rectangle),
                    Text("디바이스 ID"),
                    buildAccountOption(context, "디바이스 ",user.PSN,
                        CupertinoIcons.pencil_ellipsis_rectangle),
                    Text("알림"),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.58,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,
                                    width: 0.4),
                                borderRadius: BorderRadius.circular(20)),
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              icon: Icon(CupertinoIcons.chevron_down),
                              iconSize: 20,
                              isExpanded: true,
                              underline: SizedBox(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: listItem.map((valueItem) {
                                return DropdownMenuItem(
                                    value: valueItem, child: Text(valueItem));
                              }).toList(),
                            ),
                          )),
                    ),
                  ],
                ),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffff7f55),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (_) =>
                            Dialog(
                              child: Container(
                                width: 100,
                                height: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("로그아웃 하시겠습니까?", style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: ()  {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              primary:  Colors.grey,
                                              onPrimary: Colors.white,
                                              minimumSize: Size(120, 50),
                                              //width, height
                                              alignment: Alignment.center,
                                              textStyle: const TextStyle(fontSize: 18)),
                                          child: Text("취소"), //번호
                                        ),
                                        ElevatedButton(
                                          onPressed: ()  {
                                            FirebaseAuth.instance.signOut();
                                            user.checkOut();
                                            Get.offAll(()=> fb_home());
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              primary:  Color(0xffff4c11),
                                              onPrimary: Colors.white,
                                              minimumSize: Size(120, 50),
                                              //width, height
                                              alignment: Alignment.center,
                                              textStyle: const TextStyle(fontSize: 18)),

                                          child: Text("확인"), //번호
                                        ),
                                        
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                      );
                    },
                    //FirebaseAuth.instance.signOut, //현재 로그인한 사용자 로그아웃
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),

      body: _children[_currentIndex],

    );
  }
  // Widget showIamge(){
  //   if(_image)
  // }
  Future getImage(ImageSource imageSource) async{
    PickedFile image = await ImagePicker.platform.pickImage(source: imageSource);
    setState((){
      _image = image;
    });
  }
}

