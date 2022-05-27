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
    height: 50,
    width: width,
    child: TextField(
      keyboardType: inputType ?? TextInputType.name,
      enabled: isEnabled,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hintText)
    ),
  );
  }
}