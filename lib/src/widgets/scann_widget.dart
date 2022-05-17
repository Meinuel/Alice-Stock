import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannContainer extends StatefulWidget {
  const ScannContainer({Key? key}) : super(key: key);

  @override
  State<ScannContainer> createState() => _ScannContainerState();
}

class _ScannContainerState extends State<ScannContainer> {

  final TextEditingController _barcodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _createTextField(),
        const SizedBox(height: 10),
        _createScannerBtn()
      ],
    );
  }

  _createTextField() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
        controller: _barcodeTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          hintText: 'Codigo de barras'),
      ),
    );
  }

  _createScannerBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(shape: const StadiumBorder(),fixedSize: Size( MediaQuery.of(context).size.width / 1.5 , 50 )),
      onPressed: launchScanner , child: const Text('Escanear'));
  }

  launchScanner() {
    FlutterBarcodeScanner.scanBarcode(
        'red', 
        'blue', 
        true, 
        ScanMode.BARCODE)
          .then((value) => _barcodeTextController.text = value)
          .onError((error, stackTrace) => _barcodeTextController.text = 'error' );
  }
}