import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pelu_stock/src/api/hola.dart';
import 'package:pelu_stock/src/api/request.dart';
import 'package:pelu_stock/src/bloc/table_bloc.dart';
import 'package:pelu_stock/src/models/item_product.dart';
import 'package:pelu_stock/src/screens/payload.dart';
import 'package:pelu_stock/src/styles/button_style.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/date_widget.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/scann_widget.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/table_widget.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/title_widget.dart';

import '../widgets/FatWidgets/dialog_widget.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {

  String date = _handleDate();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _barcodeTextController = TextEditingController();
  final StreamController<List<ItemProduct>> _tableController = StreamController();
  final TableBloc _tableBloc = TableBloc();
  bool isLoading = false;
  @override
  void initState() {
    _tableBloc.tableSink([]);
    _dateController.text = date;
    super.initState();
  }

  @override
  void dispose() {
    _tableController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 15),
          const MyTitle(title: 'Consumos del dia'),
          const SizedBox(height: 30),
          MyDate(dateController: _dateController),
          const SizedBox(height: 45),
          ScannContainer(controller: _barcodeTextController , navigatePayload: createRoute),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                child: StreamBuilder<List<ItemProduct>>(
                  stream: _tableBloc.tableStream,
                  builder: (context, snapshot) => MyTable(tableBloc: _tableBloc , snapshot: snapshot)
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState((){
                isLoading = true;
              });
              handleForm();
              setState(() {
                isLoading = false;
              });},
            style: buttonStyle(MediaQuery.of(context).size.width / 1.5),
            child: isLoading ? const SizedBox(width: 15,height: 15,child: CircularProgressIndicator(color: Colors.white )) : const Text('Terminar')),
            const SizedBox(height: 20,)
        ],
      );
  }
  
  static String _handleDate() {
    final DateTime dateTime = DateTime.now();
    final String date = '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}';
    return date;
  }

  createRoute(String barcode) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => PayLoad(barcode: barcode , tableBloc: _tableBloc)));
    setState(() {
    
    });
  }

  handleForm() async {
    if(_dateController.text.isNotEmpty && _tableBloc.lastValue.isNotEmpty){
      print(_dateController.text);
      setState(() {
        isLoading = true;
      });
      consumosDiariosCreate(_tableBloc.lastValue, _dateController.text)
        .then((value) => _createDialog(value == 'Ok' ? 'Consumo registrado' : 'error api'));
    }else{
      _createDialog('Falta informacion');
    }
  }
  _createDialog( String message ) {
    return showDialog(context: context, builder: (context){
      return MyDialog(message: message);
    });
  }
}