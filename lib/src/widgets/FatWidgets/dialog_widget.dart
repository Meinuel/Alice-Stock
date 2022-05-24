import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final String message;
  const MyDialog({Key? key , required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(alignment: Alignment.center,height: 100,child: Text(message))
    );
  }
}