import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:xml2json/xml2json.dart';


class CBoard {
  var  decide, clear, exam;
  // var date;
  String date = "00.00 00:00";

  var  _coronaJson;
  String _serviceKey = "M8J0A7jAfaLHLHj9D0X1lnYa4XJtbC4fuymKw4y81OniBFdyb1IeE%2BZXE4A7WE0RfhlVO%2Bd2tuxIZ4qH5fmBQQ%3D%3D";
  // String _today = DateFormat("yyyyMMdd").format(DateTime.now());
  // String _yesterday = DateFormat("yyyyMMdd").format(DateTime(
  //   DateTime
  //       .now()
  //       .subtract(Duration(days: 1))
  //       .year,
  //   DateTime
  //       .now()
  //       .subtract(Duration(days: 1))
  //       .month,
  //   DateTime
  //       .now()
  //       .subtract(Duration(days: 1))
  //       .day,
  // ));

  String _today = DateFormat("yyyyMMdd").format(DateTime(
    DateTime
        .now()
        .subtract(Duration(days: 1))
        .year,
    DateTime
        .now()
        .subtract(Duration(days: 1))
        .month,
    DateTime
        .now()
        .subtract(Duration(days: 1))
        .day,
  ));
  String _yesterday = DateFormat("yyyyMMdd").format(DateTime(
    DateTime
        .now()
        .subtract(Duration(days: 2))
        .year,
    DateTime
        .now()
        .subtract(Duration(days: 2))
        .month,
    DateTime
        .now()
        .subtract(Duration(days: 2))
        .day,
  ));
  String _baseUrl = "openapi.data.go.kr";
  String _getData = "/openapi/service/rest/Covid19/getCovid19InfStateJson";


  Future<int> getDecide() async{
    decide = int.parse(_coronaJson[0]["decideCnt"]) -
        int.parse(_coronaJson[1]["decideCnt"]); //확진자
    return await decide;
  }

  cornaInit() async {
    // print("cornaInit");
    //api호출하고 res까지만 받은 상태 1.date값 datenow로 변경,2.xml data parsing
    final queryParameters = {
      //하하 % URI 인코딩이 뭐가 문제가 있다 %를 25로 문제!!
      'serviceKey': Uri.decodeFull(
          _serviceKey),
      'pageNo': '1',
      'numOfRows': '2',
      'startCreateDt': _yesterday,
      'endCreateDt': _today
    };
    var url = Uri.http(
        _baseUrl,
        _getData,
        queryParameters);
    var response = await http.get(url); //api 요청
    if (response.statusCode == 200) { //정상일 경우
      final xml = response.body; //boy값만 xml
      final xml2json = Xml2Json()
        ..parse(xml);
      final json = xml2json.toParker(); //xml을 json형식으로
      // print(response.body);

      _coronaJson = convert.jsonDecode(
          json)["response"]["body"]["items"]["item"]; //필요한 값만
      // print(_coronaJson[0]);
      decide = int.parse(_coronaJson[0]["decideCnt"]) -
          int.parse(_coronaJson[1]["decideCnt"]); //확진자
      date = _coronaJson[0]["stateDt"] + " " + _coronaJson[0]["stateTime"];
      date = date.substring(4);
      cBoard.date = date.substring(0, 2) + "." + date.substring(2); //기준시간

      clear = int.parse(_coronaJson[0]["clearCnt"]) -
          int.parse(_coronaJson[1]["clearCnt"]); //격리해제
      exam = int.parse(_coronaJson[0]["examCnt"]) -
          int.parse(_coronaJson[1]["examCnt"]); //검사자
    } else {
      print(
          'Request failed with status: ${response.statusCode}.');
    }
  }


}


CBoard cBoard = CBoard();