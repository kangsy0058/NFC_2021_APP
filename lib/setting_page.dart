import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFution1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFution2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFution3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.indigo,
                  ),
                  Text(
                    "asdasd",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 20,
                thickness: 1,
              ), // 구분선
            ]),
            buildAccountOption(context, "개인안심번호", "누70카63"),
            buildAccountOption(context, "디바이스 ", "디바이스 번호"),
            buildNotificationOption("일반 알림", valNotify1, onChangeFution1),
            buildNotificationOption("일반 알림", valNotify2, onChangeFution2),
            buildNotificationOption("일반 알림", valNotify3, onChangeFution3),
            buildEtcOption("F&A"),
            Center(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.045,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: FirebaseAuth.instance.signOut, //현재 로그인한 사용자 로그아웃
                    child: Text(
                      "SIGN OUT",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.0,
                          color: Colors.black),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  //개인 번호
  Container buildAccountOption(BuildContext context, String title, String str) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        //h간격 조절
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(title + " 변경"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(str),
                            Icon(Icons.arrow_downward),
                            TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: str,
                                ))
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("변경완료"))
                        ],
                      );
                    });
              }, //동작
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    //모서리를 둥글게
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white70,
                  onPrimary: Colors.black,
                  //글자색

                  minimumSize: Size(200, 50),
                  //width, height
                  alignment: Alignment.center,
                  textStyle: const TextStyle(fontSize: 18)),
              child: Text(str), //번호
            ),
          ],
        ),
      ),
    );
  }

  //스위치
  Container buildNotificationOption(String title, bool value,
      Function onChangeMethod) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.05,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

//옵션
  Container buildEtcOption(String title) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.07,
        child: ListTile(
          leading: Icon(
            Icons.question_answer,
            color: Colors.black,
          ),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        )
    );
  }
}
