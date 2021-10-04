import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:get/get.dart';
import 'package:nfc_app21/dataInit_page.dart';

Dialog initPSN(h, w,TextEditingController textCon) {
  String barcodeScanRes = "";

  return Dialog(
    child:
    Container(
      height: h * 1.1,
      width: w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, h*0.1, 0, 0),
            child: Center(
              child: Text("STEP1. 디바이스 등록",style: TextStyle(color: mainColor, fontSize: w*0.03, fontWeight: FontWeight.w500 ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, h*0.04, 0, 0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      FlutterNfcReader.read().then((value){
                        textCon.text = value.id;
                        Get.back();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      alignment: Alignment.center,
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(w*0.011),
                      child: Text("NFC로 등록", style: TextStyle(fontSize: w * 0.02),),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    barcodeScanRes =
                    await FlutterBarcodeScanner.scanBarcode(
                        "#8aadf8", "취소", false, ScanMode.DEFAULT);
                    print("WSN출력 부분 @@@@@@@@"+barcodeScanRes);
                    if(barcodeScanRes!=""){
                      textCon.text = barcodeScanRes;

                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.black12,
                    onPrimary: Colors.white,
                    alignment: Alignment.center,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w*0.011),
                    child: Text(
                      " QR로 등록 ", style: TextStyle(fontSize: w * 0.02),),
                  ),
                ),
              ],
            ),
          ),
          Center(
            heightFactor: h*0.01,
            child: Text("NFC로 등록 안내",
              style: TextStyle(
                  fontSize: w * 0.02,
                  fontWeight: FontWeight.w800
              ),
            ),
          ),
          Center(
              heightFactor: h*0.001 ,
              widthFactor: w*0.02,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0, h*0.1, 0, h*0.01),
                    child: Text("1. 스마트폰의 NFC이 켜져있는지 확인해주세요."),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0, h*0.1, 0, h*0.01),
                    child: Text("2. 디바이스를 스마트폰 뒷면에 태그해주세요."),
                  ),
                ],
              )
          )
        ],
      ),
    ),
  );
}
