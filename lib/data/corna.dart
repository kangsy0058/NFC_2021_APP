import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:xml2json/xml2json.dart';

dynamic  decide="0", clear="0", exam="0",tot="0";
String date = "00.00 00:00";

var  _coronaJson;

String _serviceKey = "M8J0A7jAfaLHLHj9D0X1lnYa4XJtbC4fuymKw4y81OniBFdyb1IeE%2BZXE4A7WE0RfhlVO%2Bd2tuxIZ4qH5fmBQQ%3D%3D";

String _today = DateFormat("yyyyMMdd").format(DateTime(
  DateTime
      .now()
      .year,
  DateTime
      .now()
      .month,
  DateTime
      .now()
      .day,
));
String _yesterday = DateFormat("yyyyMMdd").format(DateTime(
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
String _baseUrl = "openapi.data.go.kr";
String _getData = "/openapi/service/rest/Covid19/getCovid19InfStateJson";

String numberWithComma(int param){
  return new NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
}
cornaInit() async {
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
    tot = int.parse(_coronaJson[0]["decideCnt"]);
    decide = int.parse(_coronaJson[0]["decideCnt"]) -
        int.parse(_coronaJson.last["decideCnt"]); //확진자
    date = _coronaJson[0]["stateDt"] + " " + _coronaJson[0]["stateTime"];
    date = date.substring(4);
    date = date.substring(0, 2) + "." + date.substring(2); //기준시간
    clear = int.parse(_coronaJson[0]["clearCnt"]) -
        int.parse(_coronaJson.last["clearCnt"]); //격리해제
    exam = int.parse(_coronaJson[0]["examCnt"]) -
        int.parse(_coronaJson.last["examCnt"]); //검사자

    decide = numberWithComma(decide);
    clear = numberWithComma(clear);
    exam = numberWithComma(exam);
    tot = numberWithComma(tot);

  } else {
    print(
        'Request failed with status: ${response.statusCode}.');
  }
}
