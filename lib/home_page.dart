import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Column board(String text,String day,String all,Color colors ){
    return Column(
      children: [
        Text(text),
        Text(day,style: TextStyle(color: colors,fontWeight: FontWeight.bold)),
        Text(all)
      ],);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("개인 안심번호", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      Text("1234가나", style: TextStyle(fontSize: 20)),
                    ],
                  ),

                  TextButton(onPressed: ()async{//api호출하고 res까지만 받은 상태 1.date값 datenow로 변경,2.xml data parsing

                    final queryParameters = {
                      //하하 % URI 인코딩이 뭐가 문제가 있다 %를 25로 문제!!
                      'serviceKey': Uri.decodeFull("M8J0A7jAfaLHLHj9D0X1lnYa4XJtbC4fuymKw4y81OniBFdyb1IeE%2BZXE4A7WE0RfhlVO%2Bd2tuxIZ4qH5fmBQQ%3D%3D") ,
                      'pageNo': '1',
                      'numOfRows': '2',
                      'startCreateDt': '20210703',
                      'endCreateDt' : '20210704'
                    };
                    var url = Uri.http("openapi.data.go.kr", "/openapi/service/rest/Covid19/getCovid19InfStateJson",queryParameters);
                    var response = await http.get(url);
                    if (response.statusCode == 200) {
                      // print( DateTime.now());
                      // print(url);
                      print(response.body);
                      // var jsonResponse =
                      // convert.jsonDecode(response.body) as Map<String, dynamic>;
                      // var itemCount = jsonResponse['totalItems'];
                      // print('Number of books about http: $itemCount.');
                    } else {
                      print('Request failed with status: ${response.statusCode}.');
                    }



                  }, child: Text("데이터 test")),
                  Column(
                    children: [
                      Text("디바이스 ID", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      Text("WSN1234", style: TextStyle(fontSize: 20))
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5,30,5,10),
                margin:  EdgeInsets.fromLTRB(20,20,20,10),
                child: Column(
                  children: [
                    Text("코로나바이러스 감염증 - 19", style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,fontFamily: "Cafe24")),
                    Text("06.30 00:00 기준",style: TextStyle(fontSize: 13)),
                    Container(

                      margin: EdgeInsets.all(1),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          board("확진환자", "794", "156,941", Colors.redAccent),
                          board("격리해제", "794", "156,941", Colors.blueAccent),
                          board("검사 중", "2,748", "156,941", Colors.black),
                          board("사망자", "1", "2,018", Colors.black),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(
                    width: 1,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5,30,5,10),
                margin:  EdgeInsets.fromLTRB(20,20,20,10),
                child: Column(
                  children: [
                    Text("내용들", style: TextStyle(fontSize: 20 )),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          board("확진환자", "794", "156,941", Colors.redAccent),
                          board("격리해제", "794", "156,941", Colors.blueAccent),
                          board("검사 중", "2,748", "156,941", Colors.black),
                          board("사망자", "1", "2,018", Colors.black),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
              ),
            ]
        )
    );
  }
}
