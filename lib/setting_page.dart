import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingPage extends StatefulWidget {

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool valNotify1=true;
  bool valNotify2=false;
  bool valNotify3=false;

  onChangeFution1(bool newValue1){
    setState((){
      valNotify1=newValue1;
    });
  }
  onChangeFution2(bool newValue2){
    setState((){
      valNotify2=newValue2;
    });
  }
  onChangeFution3(bool newValue3){
    setState((){
      valNotify3=newValue3;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.indigo,
                ),
                SizedBox(width: 10,),
                Text("asdasd",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
              ],
            ),
            Divider(height: 20, thickness: 1,), // 구분선
            SizedBox(height: 10),
            buildAccountOption(context, "개인안심번호", "누70카63"),
            buildAccountOption(context, "디바이스 ", "디바이스 번호"),
            SizedBox(height: 20),
            buildNotificationOption("일반 알림", valNotify1, onChangeFution1),
            buildNotificationOption("일반 알림", valNotify2, onChangeFution2),
            buildNotificationOption("일반 알림", valNotify3, onChangeFution3),
            SizedBox(height: 50),
            buildEtcOption(context, "Q&A"),
            buildEtcOption1("F&A"),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onPressed: FirebaseAuth.instance.signOut,//현재 로그인한 사용자 로그아웃
                child: Text("SIGN OUT", style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black
                ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value,Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue){
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title, String str){
    return GestureDetector(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),//h간격 조절
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,

            ),),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title: Text(title+" 변경"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(str),
                        Icon(Icons.arrow_downward),
                        TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: str,
                            )
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text("변경완료")
                      )
                    ],
                  );
                });
              },//동작
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(	//모서리를 둥글게
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.white70,
                  onPrimary: Colors.black,	//글자색
                  minimumSize: Size(200, 50),	//width, height
                  alignment: Alignment.center,
                  textStyle: const TextStyle(fontSize: 18)
              ),
              child: Text(str),//번호
            ),
          ],
        ),
      ),
    );
  }


  GestureDetector buildEtcOption(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title+" 변경"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("str"),
                Icon(Icons.arrow_downward),
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "str",
                    )
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("변경완료")
              )
            ],
          );
        });
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.question_answer),
            Text(title, style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            ),
            Icon(Icons.arrow_forward_ios),
          ]
      ),
    );
  }
  ListView buildEtcOption1(String title){

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

      children: <Widget> [
        ListTile(
          leading: Icon(Icons.question_answer,color: Colors.black,),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        )
      ],
    );
  }
}
