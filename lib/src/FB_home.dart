import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nfc_app21/data/user.dart';
import 'package:nfc_app21/main.dart';
import 'package:nfc_app21/src/login.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:nfc_app21/basics_example.dart';
class fb_home extends StatefulWidget {
  @override
  _fb_homeState createState() => _fb_homeState();
}

class _fb_homeState extends State<fb_home> {

  bool _supportsNFC = false;
  bool _reading = false;
  StreamSubscription<NDEFMessage>? _stream;

  @override
  void initState() {
    NFC.isNDEFSupported
        .then((bool isSupported) {
      setState(() {
        _supportsNFC = isSupported;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    String _scanBarcode = 'Unknown';
    // if (!_supportsNFC) {
    //   return ElevatedButton(
    //     child: const Text("You device does not support NFC"),
    //     onPressed: null,
    //   );
    // }


    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),// stream 이라 stramBuilder를 통해 받기
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return LoginWidget();
          }
          else{
              // return
              //   Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text("${snapshot.data.email} "),
              //         Text("WSN : ${nfcUser.WSN}  PSN : ${nfcUser.PSN}"),
              //         TextButton(onPressed:()async {
              //           try{
              //             print(await FirebaseAuth.instance.currentUser!.getIdToken());
              //           }catch(err){
              //             print(err);
              //           }
              //         }, child: Text("token 확인")),
              //         TextButton(onPressed: ()async{
              //           _scanBarcode = await FlutterBarcodeScanner.scanBarcode("#ff6666", "취소", false, ScanMode.DEFAULT);
              //           nfcUser.WSN = _scanBarcode;
              //           setState(() {
              //
              //           });
              //
              //
              //         }, child: Text("WSN QR")),
              //
              //       ElevatedButton(
              //           child: Text(_reading ? "WSN NFC Stop" : "WSN NFC Start"),
              //           onPressed: () {
              //             if (_reading) {
              //               _stream?.cancel();
              //               setState(() {
              //                 _reading = false;
              //               });
              //             } else {
              //               setState(() {
              //                 _reading = true;
              //                 // Start reading using NFC.readNDEF()
              //                 _stream = NFC.readNDEF(
              //                   once: true,
              //                   throwOnUserCancel: false,
              //                 ).listen((NDEFMessage message) {
              //                   print("read NDEF message: ${message.payload}");
              //                 }, onError: (e) {
              //                   // Check error handling guide below
              //                 });
              //               });
              //             }
              //           }
              //       ),
              //
              //
              //         TextButton(onPressed:FirebaseAuth.instance.signOut, child: Text("logOut")),
              //       ],
              //     ),
              //   );
               return App();


          }
        }),
    );
  }


}
