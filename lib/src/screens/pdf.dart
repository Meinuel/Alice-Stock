import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  final File file;
  const PDFViewer({Key? key , required this.file}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.share),onPressed: () => _share()),
      body: SfPdfViewer.file(widget.file),
    );
  }
  _share() {
    Share.shareFiles([widget.file.path], subject: widget.file.path.split('/').last);
  }
}