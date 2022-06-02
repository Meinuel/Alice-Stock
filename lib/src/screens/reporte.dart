import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pelu_stock/src/screens/pdf.dart';
import 'package:pelu_stock/src/styles/button_style.dart';
import 'package:pelu_stock/src/util/create_pdf.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/dialog_widget.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/title_widget.dart';
import 'package:share_plus/share_plus.dart';
import '../api/request.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  DateTimeRange? _dateTimeRange ;
  String fileName = '';
  String path = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyTitle(title: 'Reporte'),
          Column(
            children: [
              const Text('Periodo : '),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () => _pickDateRange(), child: Text(_getFrom())),
                  const Icon(Icons.arrow_forward),
                  ElevatedButton(onPressed: () => _pickDateRange(), child: Text(_getUntil()))
                ],
              ),
            ],
          ),
          SizedBox(height: 200 , child: isLoading ? const Center(child: CircularProgressIndicator()) : Container()),
          _dateTimeRange != null ? ElevatedButton(
            style: buttonStyle(MediaQuery.of(context).size.width / 1.2),
            onPressed: () => _generatePdf(), 
            child: const Text('Generar reporte')) : Container()
        ],
      )
    );
  } 

  _pickDateRange() async {
    final newDateRange = await showDateRangePicker(
      locale: const Locale("es", "ES"),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context,child){
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.dark(primary:Colors.blue),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary
            ), 
         ),
         child: child!,);
      },
      context: context, 
      firstDate: DateTime(2022, 1, 1), 
      lastDate: DateTime.now(),
      );
      if ( newDateRange == null) return;
      setState(() => _dateTimeRange = newDateRange);
  }

  _getFrom(){
    if ( _dateTimeRange == null){
      return 'Desde';
    } else {
      return DateFormat('MM/dd/yyyy').format(_dateTimeRange!.start);
    }
  }

  _getUntil(){
    if ( _dateTimeRange == null ){
      return 'Hasta';
    } else {
      return DateFormat('MM/dd/yyyy').format(_dateTimeRange!.end);
    }
  }
  
  _share() {
    Share.shareFiles([path], subject: fileName);
  }
  
  _generatePdf() async {
    setState(() {
      isLoading = true;
    });
    final String desde = DateFormat('yyyyMMdd').format(_dateTimeRange!.start);
    final String hasta = DateFormat('yyyyMMdd').format(_dateTimeRange!.end);
    final List response = await reporteConsumo(desde, hasta);
    if(response.isEmpty){
      return createDialog('No hay consumos registrados para estas fechas', context,null);
    }
    final File file = await createSavePdf(response);
    setState(() {
      isLoading = false;
      fileName = path.split('/').last;
      path = file.path;
    });
    Navigator.push(context , MaterialPageRoute(builder: (context) => PDFViewer(file: file)));
  }
}