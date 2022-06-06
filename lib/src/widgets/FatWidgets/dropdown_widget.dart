import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../models/marcas.dart';
import '../../models/tinturas.dart';

class DropDownMenu extends StatefulWidget {
  final List<Marcas>? marcas;
  final List<Tinturas>? tinturas;
  final String hintText;
  final Function setItem;
  final bool? esTintura;
  const DropDownMenu({Key? key , this.marcas, this.tinturas ,required this.hintText , required this.setItem , this.esTintura}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  dynamic selectedItem ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      child: DropdownButton2<dynamic>(
        dropdownOverButton: true,
        dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        underline: Container(),
        value: selectedItem,
        customButton: _createCustomBtn(),
        items:widget.marcas != null ? widget.marcas!.map((Marcas value) {
          return DropdownMenuItem<Marcas>(
            value: value,
            child: Text(value.nombre,style: const TextStyle(color: Colors.black)),
          );
        }).toList() : 
        widget.tinturas!.map((Tinturas value) {
          return DropdownMenuItem<Tinturas>(
            value: value,
            child: Text(value.nombre,style: const TextStyle(color: Colors.black)),
          ); 
        }).toList(),
        onChanged: widget.esTintura != false ? (value) {
          widget.setItem(value);
          setState(() {
            selectedItem = value;
          });
        } : null
      )
        );
  }
  
  _createCustomBtn() {
    return Container(
      
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
          Text(selectedItem == null ?  widget.hintText : selectedItem!.nombre,style: TextStyle(color: Colors.black , fontWeight: widget.esTintura != false ? FontWeight.bold : FontWeight.normal)) , 
          const Icon(Icons.arrow_drop_down)
          ]
        ),
      height: 40,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        color: widget.esTintura != false ? Colors.white : Colors.grey , 
        borderRadius: const BorderRadius.all(Radius.circular(10.0))));
  }
}
