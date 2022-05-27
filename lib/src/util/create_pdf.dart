import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';

  _savePdf(Document pdf, String fileName) async {
    final dir = await getExternalStorageDirectory();
    final String name = '${dir!.path}/$fileName.pdf';
    final file = File(name);
    file.writeAsBytes(await pdf.save());
    return file.path;
  }

  _createPDF(List dias,Document pdf) {
    for (var data in dias) {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context contex) {
            return pw.Text('Ejemplo 1');
      }));
    }
}

  createSavePdf (List imgList, List<String> arguments) async {
    var pdf = pw.Document();
    _createPDF(imgList,pdf);
    final fileName = _handleFileName(arguments);
    final String path = _savePdf(pdf,fileName);
    return [path,fileName];
  }

  String _handleFileName(List<String> arguments) {
  String fileName = '';
  for (var item in arguments) {
    fileName += '${item}_';
  }
  return fileName.substring(0, fileName.length - 1);
}