import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pelu_stock/src/styles/button_style.dart';
import 'package:pelu_stock/src/util/create_pdf.dart';
import 'package:share_plus/share_plus.dart';
import '../api/request.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  DateTimeRange? _dateTimeRange ;
  bool isGenerated = false;
  String fileName = '';
  String path = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: 200),
          ElevatedButton(
            style: buttonStyle(MediaQuery.of(context).size.width / 1.2),
            onPressed: () => _dateTimeRange != null ? isGenerated ? _share() : _generatePdf() : null, 
            child: Text( isGenerated ? 'Compartir' : 'Generar reporte'))
        ],
      )
    );
  }

  _pickDateRange() async {
    final initialDateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(hours: 24)));
    final newDateRange = await showDateRangePicker(
      locale: const Locale("es", "ES"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      context: context, 
      firstDate: DateTime(2022, 1, 1), 
      lastDate: DateTime(2030, 1, 1),
      initialDateRange: initialDateRange);
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
    if ( _dateTimeRange == null){
      return 'Hasta';
    } else {
      return DateFormat('MM/dd/yyyy').format(_dateTimeRange!.end);
    }
  }
  
  _share() {
    Share.shareFiles([path], subject: fileName);
  }
  
  _generatePdf() async {
    final response = await reporteConsumo(_dateTimeRange!.start, _dateTimeRange!.end);
    final List<String> pathAndFile = createSavePdf([],[]);
    setState(() {
      fileName = pathAndFile[1];
      path = pathAndFile[0];
    });
  }
}