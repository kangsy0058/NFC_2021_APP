import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_app21/basics_example.dart';

class LogPage extends StatefulWidget {
  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  Container task(
    String title,
    String text,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: Colors.white,
            size: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cafe24",
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Cafe24",
                      color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Color mainC =  Color(0xffff4c11);
    Color subC = Color(0xffff7f55);


    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey),
              elevation: 0,
              title: Text(
                "상세 기록",
                style: TextStyle(
                    color: mainC,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cafe24'),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Events'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableBasicsExample()),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: subC),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      task("제목1", "This is test text hahaha "),
                      task("제목2", "This is test text222 hahaha "),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
