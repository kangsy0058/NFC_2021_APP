import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(

            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("개인 안심번호",style: TextStyle(fontSize: 25),),
                  Text("디바이스 ID",style: TextStyle(fontSize: 25))
                ],
              ),
              Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Text("1234가나",style: TextStyle(fontSize: 25)),
                Text("WSN1234",style: TextStyle(fontSize: 25))
              ]
              ),

              Text("코로나 - 19",style: TextStyle(fontSize: 25)),




            ]
        )
    );
  }
}
