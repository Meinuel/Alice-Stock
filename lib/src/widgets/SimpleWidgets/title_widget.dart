import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String? title;
  const MyTitle({Key? key , this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Text(title ?? '↓§↓↨↑→',style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
    );
  }
}