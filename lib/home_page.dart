import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_app21/data/corna.dart';
import 'package:nfc_app21/basics_example.dart';
import 'package:nfc_app21/data/user.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/main.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



Future<bool> userLog(String WSN,String s_date,String e_date)  async {
  String _baseUrl = "210.119.104.206:8080";
  String _getData = "/v1/common/userlog/visitHistory";
  final queryParameters = {
    'Wearable_SN': WSN,
    'start_date':s_date,
    'end_date':e_date
  };
  var url = Uri.http(
      _baseUrl,
      _getData,
      queryParameters);
  var response = await http.get(url);
  var test = jsonDecode(response.body);

  if (test["User_log"]== null) {
    return Future(() => false);
  } else {
    building = test["User_log"][0]["building_name"];
    temp =  test["User_log"][0]["temp"]+"℃";

    time = test["User_log"][0]["Time"];
    int h =int.parse(time.substring(0,2));
    if(h<12){
      time = "오전 "+h.toString()+":"+time.substring(3,5);
    }else{
      time = "오후 "+h.toString()+":"+time.substring(3,5);

    }

    return Future(() => true);
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    String day = "21"+date.substring(0, 2)+date.substring(3, 5);
    userLog("WSN1111",day,day);

    cornaInit();


    super.initState();
  }


  Container buildConfirmedCases() {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 10, 7, 0),
      margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text("확진 환자"),
            ],
          ),
          FutureBuilder(
            future: _fetch1(),
            builder: (context, snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                return Container(
                  margin: EdgeInsets.fromLTRB(2, 5, 2, 10),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.triangle_fill,
                            color: Colors.red,
                            size: 12,
                          ),
                          Text(
                            decide
                            ,
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 20, 2, 1),
                              child: Icon(
                                Icons.show_chart,
                                color: Color(0xffc9c9c9),
                                size: 12,
                              ),
                            ),
                            Text(
                              tot,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },),


          IntrinsicHeight(
            child: Row(
              children: [
                Row(
                  children: [
                    Text("검사 중 ",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    // Text(cronaData.exam.toString(),
                    Text(exam,
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
                VerticalDivider(
                  width: 10,
                  thickness: 1,
                  color: Colors.black12,
                ),
                Row(
                  children: [
                    Text("격리해제 ",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    // Text(cronaData.exam.toString(),
                    Text(clear,
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
  Future<String> _fetch1() async {
    return "corona";
  }

  final UserController user = Get.find();
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xffff7f55); // 22 찐
    Color pointColor = Color(0xffff4c11); // 가장 찐
    Color borderColor = Color(0xffffbfaa);// 3 찐
    Color backColor = Color(0xffFFFCFA);// 배경

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                    child: Text("COVID-19 국내 현황",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "Cafe24"
                        )),
                    decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(7, 3, 3, 3),
                    child: Icon(
                      Icons.info_outlined,
                      color: Color(0xffc9c9c9),
                      size: 16,
                    ),
                  ),
                  Text(date,
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ]),
                buildConfirmedCases(),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
              margin: EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Column(children: [
                Row(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text("내 정보",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          //fontFamily: "Cafe24"
                        )),
                    decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(7, 10, 7, 10),
                      // margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "개인 안심번호",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(PSN,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: borderColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),


                    Container(
                      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                      //margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("디바이스",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(WSN,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: borderColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  ],
                ),
                TextButton(onPressed: (){


                  setState(() {

                  });

                }, child: Text("    ")),


              ])),
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
              margin: EdgeInsets.fromLTRB(25, 0, 0, 10),
              child: Text("오늘의 온기",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: pointColor,

                    //fontFamily: "Cafe24"
                  )),
              decoration: BoxDecoration(
                  //color: Color(0xffe3efff),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ]),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: backColor,
                border: Border.all(
                  width: 1.2,
                  color: borderColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex:1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Text( "2021년"+date.substring(0, 2)+"월"+date.substring(3, 5)+"일",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            //fontFamily: "Cafe24"
                          )),
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Icon(CupertinoIcons.thermometer,color: pointColor,),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text("체온",
                                  style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w800)
                              )
                            ),
                            Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Text(temp,// ℃
                                  style: TextStyle(
                                      fontSize: 14, )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Icon(CupertinoIcons.location,color: pointColor),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text("건물",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w800)
                              ),
                            ),
                            Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Text(building,//강석규교육관
                                  style: TextStyle(
                                      fontSize: 14,)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Icon(CupertinoIcons.time,color: pointColor),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text("시간",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w800)
                              ),
                            ),
                            Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: Text(time,//
                                  style: TextStyle(
                                      fontSize: 14, )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.to(()=>TableBasicsExample());
                      //await FirebaseMessaging.instance.subscribeToTopic('All');//토픽 추가하는 부분
                      //print(FirebaseAuth.instance.currentUser);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => TableBasicsExample()),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: mainColor,
                        onPrimary: Colors.white,
                        minimumSize: Size(300, 50),
                        //width, height
                        alignment: Alignment.center,
                        textStyle: const TextStyle(fontSize: 18)),
                    child: Text("상세 기록"), //번호
                  ),
                )
              ],
            ),
          ),
        ])));
  }


}
