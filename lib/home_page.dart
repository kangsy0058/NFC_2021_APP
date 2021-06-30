import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      Text("개인 안심번호", style: TextStyle(fontSize: 20),),
                      Text("1234가나", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  Column(
                    children: [
                      Text("디바이스 ID", style: TextStyle(fontSize: 20)),
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
                    Text("코로나바이러스 감영증 - 19", style: TextStyle(fontSize: 20 )),
                    Text("06.30 00:00 기준",style: TextStyle(fontSize: 13)),
                    Container(

                      margin: EdgeInsets.all(1),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("확진환자"),
                              Text("794",style: TextStyle(color: Colors.redAccent),),
                              Text("156,941")
                          ],),
                          Column(
                            children: [
                              Text("격리해제"),
                              Text("794",style: TextStyle(color: Colors.blueAccent),),
                              Text("156,941")
                            ],),
                          Column(
                            children: [
                              Text("검사 중"),
                              Text("2,748",style: TextStyle(color: Colors.black),),
                              Text("156,941")
                            ],),
                          Column(
                            children: [
                              Text("사망자"),
                              Text("1",style: TextStyle(color: Colors.black),),
                              Text("2,018")
                            ],),
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
                          Column(
                            children: [
                              Text("확진환자"),
                              Text("794",style: TextStyle(color: Colors.redAccent),),
                              Text("156,941")
                            ],),
                          Column(
                            children: [
                              Text("격리해제"),
                              Text("794",style: TextStyle(color: Colors.blueAccent),),
                              Text("156,941")
                            ],),
                          Column(
                            children: [
                              Text("검사 중"),
                              Text("2,748",style: TextStyle(color: Colors.black),),
                              Text("156,941")
                            ],),
                          Column(
                            children: [
                              Text("사망자"),
                              Text("1",style: TextStyle(color: Colors.black),),
                              Text("2,018")
                            ],),
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
