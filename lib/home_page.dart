import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nfc_app21/log_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Column board(String text, String day, String all, Color colors) {
    return Column(
      children: [
        Text(text),
        Text(day, style: TextStyle(color: colors, fontWeight: FontWeight.bold)),
        Text(all)
      ],
    );
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
          Container(
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
                      "1,212",
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
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Row(
                  children: [
                    Text("검사 중 ",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text("2,748",
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
                    Text("740",
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

  @override
  Widget build(BuildContext context) {
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
                        color: Color(0xff8aadf8),
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
                  Text(" 06.30 00:00 기준",
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
                        color: Color(0xff8aadf8),
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
                          Text("누70카63",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Color(0xffc9d6fe),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    // TextButton(
                    //     onPressed: () async {
                    //       //api호출하고 res까지만 받은 상태 1.date값 datenow로 변경,2.xml data parsing
                    //
                    //       final queryParameters = {
                    //         //하하 % URI 인코딩이 뭐가 문제가 있다 %를 25로 문제!!
                    //         'serviceKey': Uri.decodeFull(
                    //             "M8J0A7jAfaLHLHj9D0X1lnYa4XJtbC4fuymKw4y81OniBFdyb1IeE%2BZXE4A7WE0RfhlVO%2Bd2tuxIZ4qH5fmBQQ%3D%3D"),
                    //         'pageNo': '1',
                    //         'numOfRows': '2',
                    //         'startCreateDt': '20210703',
                    //         'endCreateDt': '20210704'
                    //       };
                    //       var url = Uri.http(
                    //           "openapi.data.go.kr",
                    //           "/openapi/service/rest/Covid19/getCovid19InfStateJson",
                    //           queryParameters);
                    //       var response = await http.get(url);
                    //       if (response.statusCode == 200) {
                    //         // print( DateTime.now());
                    //         // print(url);
                    //         print(response.body);
                    //         // var jsonResponse =
                    //         // convert.jsonDecode(response.body) as Map<String, dynamic>;
                    //         // var itemCount = jsonResponse['totalItems'];
                    //         // print('Number of books about http: $itemCount.');
                    //       } else {
                    //         print(
                    //             'Request failed with status: ${response.statusCode}.');
                    //       }
                    //     },
                    //     child: Text("데이터 test")),
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
                          Text("WSN1234",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Color(0xffc9d6fe),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )
                  ],
                ),
              ])),
          Row(children: [
            Container(
              padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
              margin: EdgeInsets.fromLTRB(25, 0, 0, 10),
              child: Text("오늘의 온기",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6382f4),

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
                color: Color(0xfffafbff),
                border: Border.all(
                  width: 1.2,
                  color: Color(0xffc9d6fe),
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
                              child: Icon(CupertinoIcons.thermometer,color: Color(0xff6382f4),),
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
                              child: Icon(CupertinoIcons.location,color: Color(0xff6382f4)),
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
                              child: Icon(CupertinoIcons.time,color: Color(0xff6382f4)),
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
                    onPressed: () {
                      print(FirebaseAuth.instance.currentUser);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Color(0xff8aadf8),
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
