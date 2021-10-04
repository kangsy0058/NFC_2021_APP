import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_app21/data/corna.dart';
import 'package:nfc_app21/basics_example.dart';
import 'package:nfc_app21/log_page.dart';
import 'package:nfc_app21/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CBoard cronaData = CBoard();

  @override
  void initState() {
    super.initState();

    cronaData.cornaInit();

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
                            cronaData.decide.toString(),
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
                              "162,753",
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
                    Text(cronaData.exam.toString(),
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
                    Text(cronaData.exam.toString(),
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

    return "dkdkd";
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
                  Text(cBoard.date,
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
                          Text("${user.PSN}",
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
                          Text("디바이스 ID",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text("${user.WSN}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))
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

                  //print(cBoard.date);
                  print(cronaData.date);
                }, child: Text("    ")),
                // TextButton(
                //     onPressed: () async {
                //       var today = DateFormat("yyyyMMdd").format(DateTime.now());
                //       var yesterday = DateFormat("yyyyMMdd").format(DateTime(
                //         DateTime.now().subtract(Duration(days: 1)).year,
                //         DateTime.now().subtract(Duration(days: 1)).month,
                //         DateTime.now().subtract(Duration(days: 1)).day,
                //       ));
                //
                //
                //       //api호출하고 res까지만 받은 상태 1.date값 datenow로 변경,2.xml data parsing
                //       final queryParameters = {
                //         //하하 % URI 인코딩이 뭐가 문제가 있다 %를 25로 문제!!
                //         'serviceKey': Uri.decodeFull(
                //             "M8J0A7jAfaLHLHj9D0X1lnYa4XJtbC4fuymKw4y81OniBFdyb1IeE%2BZXE4A7WE0RfhlVO%2Bd2tuxIZ4qH5fmBQQ%3D%3D"),
                //         'pageNo': '1',
                //         'numOfRows': '2',
                //         'startCreateDt':yesterday ,
                //         'endCreateDt': today
                //       };
                //       var url = Uri.http(
                //           "openapi.data.go.kr",
                //           "/openapi/service/rest/Covid19/getCovid19InfStateJson",
                //           queryParameters);
                //
                //       var response = await http.get(url);//api 요청
                //       if (response.statusCode == 200) {//정상일 경우
                //         final xml = response.body;//boy값만 xml
                //         final xml2json = Xml2Json()..parse(xml);
                //         final json = xml2json.toParker();//xml을 json형식으로
                //
                //         final coronaJson = convert.jsonDecode(json)["response"]["body"]["items"]["item"];//필요한 값만
                //         // print(coronaJson);
                //
                //         var decide,clear,exam,date;
                //         print(coronaJson[0]);
                //         // print(coronaJson[0]["decideCnt"]);
                //         // print(coronaJson[1]["decideCnt"]);
                //
                //         date = coronaJson[0]["stateDt"]+" "+coronaJson[0]["stateTime"];
                //         date = date.substring(4);
                //         date = date.substring(0,2)+"."+date.substring(2);//기준시간
                //         decide = int.parse(coronaJson[0]["decideCnt"]) - int.parse(coronaJson[1]["decideCnt"]);//확진자
                //         clear = int.parse(coronaJson[0]["clearCnt"]) - int.parse(coronaJson[1]["clearCnt"]);//격리해제
                //         exam = int.parse(coronaJson[0]["examCnt"]) - int.parse(coronaJson[1]["examCnt"]);//검사자
                //
                //       } else {
                //         print(
                //             'Request failed with status: ${response.statusCode}.');
                //       }
                //     },
                //     child: Text("데이터 test")),

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
                      Text("2021년 07월 8일",
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
                              child: Text("36.2" + " ℃",
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
                              child: Text("제 2공학관",
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
                              child: Text("오후" + " " + "4:57",
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
