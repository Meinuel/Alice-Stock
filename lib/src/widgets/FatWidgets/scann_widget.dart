import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pelu_stock/src/styles/button_style.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/texfield_widget.dart';


class ScannContainer extends StatelessWidget {
  final TextEditingController controller;
  final Function? navigatePayload ;
  const ScannContainer({Key? key , required this.controller , this.navigatePayload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
          width:  MediaQuery.of(context).size.width / 1.2,
          controller: controller, 
          context: context , 
          hintText: 'Codigo de barras',
          isEnabled: true),
        const SizedBox(height: 20),
        _createScannerBtn(context,controller,navigatePayload)
      ],
    );
  }
}
  _createScannerBtn(BuildContext context , TextEditingController controller , Function? navigatePayload) {
    return ElevatedButton(
      style: buttonStyle(MediaQuery.of(context).size.width / 1.5),
      onPressed: () => launchScanner(controller,navigatePayload) , child: const Text('Escanear'));
  }

  launchScanner(TextEditingController controller , Function? navigatePayload) {
    FlutterBarcodeScanner.scanBarcode(
        'red', 
        'blue', 
        true, 
        ScanMode.BARCODE)
          .then((value)  {
            if(navigatePayload != null){
              if(value != '-1'){
                navigatePayload(value);
              }else{
                return null;
              }
            }else{
              controller.text = value;
            }
          })
          .onError((error, stackTrace) {controller.text = 'error' ;});
  }