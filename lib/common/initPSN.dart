import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_app21/dataInit_page.dart';

Dialog initPSN(h, w,TextEditingController textCon) {
  String barcodeScanRes = "";

  return Dialog(
    child:
    Container(
      height: h * 0.95,
      width: w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, h*0.1, 0, 0),
            child: Center(
              child: Text("STEP1. 디바이스 등록",
                style: TextStyle(
                    color: mainColor,
                    fontSize: w*0.03,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
         Container(
            width: w*0.4,
             alignment: Alignment.topCenter,
              child: Lottie.asset("assets/lottie/nfc.json")
          ),
           Center(
              heightFactor: h*0.001 ,
              widthFactor: w*0.02,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0, h*0.03, 0, 0),
                    child: Text("1. 스마트폰의 NFC가 켜져있는지 확인해주세요."),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0, h*0.05, 0, h*0.01),
                    child: Text("2. 디바이스를 스마트폰 뒷면에 태그해주세요."),
                  ),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(0, h*0.04, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("⚠ NFC태그에 실패하는 경우",style: TextStyle(color: Colors.grey),),

                        ElevatedButton(
                          onPressed: () async {
                            print("gkgkk");
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
                                borderRadius: BorderRadius.circular(20)
                            ),
                            primary: Color(0xffc8c8c8),
                            onPrimary: Colors.white,
                            alignment: Alignment.center,
                          ),
                          child: Padding(
                            padding:  EdgeInsets.fromLTRB(h*0.005, 0, h*0.005,0),
                            child: Text(
                              " QR로 등록 ",
                              style: TextStyle(fontSize: w * 0.02),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    ),
  );
}
