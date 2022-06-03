import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;
  final String hintText;
  final bool isEnabled;
  final double width;
  final TextInputType? inputType;

  const MyTextField({Key? key , required this.controller , required this.context , required this.hintText  , required this.isEnabled , required this.width , this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(color: Color.fromARGB(255, 45, 43, 43),borderRadius: BorderRadius.all(Radius.circular(10.0))),
    height: 40,
    width: width,
    child: TextField(
      keyboardType: inputType ?? TextInputType.name,
      enabled: isEnabled,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        hintText: hintText)
    ),
  );
  }
}