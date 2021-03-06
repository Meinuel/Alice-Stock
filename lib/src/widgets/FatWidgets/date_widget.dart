import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDate extends StatelessWidget {

  final TextEditingController dateController;
  const MyDate({Key? key , required this.dateController}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Fecha'),
        Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 45, 43, 43),borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: 50,
          width: 200,
          child: DateTimeField(
            style: const TextStyle(fontWeight: FontWeight.bold),
            initialValue: DateTime.now(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 50,top: 15)
            ),
            format: DateFormat("MM/dd/yyyy"),
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                locale: const Locale("es", "ES"),
                context: context,
                firstDate: _handleDateSelection(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime.now())
                  .then((value){
                    if(value != null){
                      dateController.text = DateFormat('dd/MM/yyyy').format(value);
                      return value;
                    }
                    return null;
                  });
            },
      ),
        ),
        
      ],
    );
  }
}

_handleDateSelection() {
  final DateTime today = DateTime.now();
  switch (today.weekday) {
    case 1:
      return today.subtract(const Duration(days: 2));
    case 2:
      return today.subtract(const Duration(days: 3));
    default :
      return today.subtract(const Duration(days: 1));
  }
}