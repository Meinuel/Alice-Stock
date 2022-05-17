import 'dart:html';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:pelu_stock/src/widgets/dropdown_widget.dart';
import 'package:pelu_stock/src/widgets/scann_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alice Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PayloadPage(title: 'Maestro Insumos'),
    );
  }
}

class PayloadPage extends StatefulWidget {
  const PayloadPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PayloadPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PayloadPage> {

  List<String> marcas = ['Marca 1' , 'Marca 2' , 'Marca 3' , 'Marca 4'];
  List<String> lineas = ['Linea 1' , 'Linea 2' , 'Linea 3' , 'Linea 4'];
  var radioValue = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ScannContainer(),
            DropDownMenu(items: marcas),
            Radio(
              value: 1, 
              groupValue: radioValue, 
              onChanged: (value) {
                setState(() {
              
                });
            }
            )
          ],
        ),
      ),
    );
  }
}
