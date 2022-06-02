import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

 Future<File> _savePdf(Document pdf, String fileName) async {
    final dir = await getExternalStorageDirectory();
    final String name = '${dir!.path}/$fileName.pdf';
    final file = File(name);
    file.writeAsBytes(await pdf.save());
    return file;
  }

  _createPDF(Map<String,List> map,Document pdf) {
    for (var fecha in map.keys) {
      pdf.addPage(pw.Page(
        build: (pw.Context contex) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text('Fecha : $fecha' , style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 20)),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: _createPage(map[fecha]!))
              ]);
      }));
    }
  }
    
    _createPage(List listProducts) {
      List columns = listProducts.map((product) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Divider(borderStyle: pw.BorderStyle.dotted, color: PdfColor.fromHex('#37DB07'), indent: 20 , endIndent: 20),
              pw.Text('${product['InsumoNombre']}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 18)),
              pw.SizedBox(height: 15),
              pw.Text('Marca : ${product['MarcaNombre']}'),
              pw.Text('Tono : ${product['Tono']}'),
              pw.Text('Cantidad : ${product['Cantidad']}'),
          ]);
      }).toList();
      return columns;
    }

  createSavePdf (List consumos) async {
    var pdf = pw.Document();
    Map<String,List> map = _handleConsumos(consumos);
    _createPDF(map,pdf);
    final fileName = _handleFileName(map.keys.first , map.keys.last);
    File file = await _savePdf(pdf, fileName);
    return file;
  }
  
  _handleConsumos(List consumos) {
    Map<String,List> map = {};
    for (var element in consumos) {
      final json = jsonDecode(element);
      map.keys.contains(json['Fecha']) ? map[json['Fecha']]!.add(json) : map.addAll({json['Fecha'] : [json]});
    }
    return map;
  }

  String _handleFileName(String desde , String hasta) {
    String ms = DateTime.now().microsecond.toString(); 
    String fileName = 'reporte$ms' + '_$desde' + '_$hasta';
    return fileName;
}