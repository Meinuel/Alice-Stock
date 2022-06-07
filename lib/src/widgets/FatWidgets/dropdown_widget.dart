import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../models/marcas.dart';
import '../../models/tinturas.dart';

class DropDownMenu extends StatefulWidget {
  final List<Marcas>? marcas;
  final List<Tinturas>? tinturas;
  final String hintText;
  final Function setItem;
  final bool esTintura;
  final Marcas? marca;
  final Tinturas? tintura;
  final String productType;
  final String comboType;
  const DropDownMenu({Key? key , this.marcas, this.tinturas ,required this.hintText , required this.setItem , required this.esTintura , this.marca , this.tintura , required this.productType , required this.comboType}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  //dynamic selectedItem ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      child: DropdownButton2<dynamic>(
        dropdownPadding: const EdgeInsets.all(0),
        enableFeedback: true,
        dropdownOverButton: true,
        dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        underline: Container(),
        value: widget.esTintura ? widget.tintura : widget.marca ,
        customButton: _createCustomBtn(widget.marca, widget.tintura , widget.hintText , context , widget.esTintura),
        items:widget.marcas != null ? widget.marcas!.map((Marcas value) {
          return DropdownMenuItem<Marcas>(
            value: value,
            child: Text(value.nombre,style: const TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
          );
        }).toList() : 
        widget.tinturas!.map((Tinturas value) {
          return DropdownMenuItem<Tinturas>(
            enabled: widget.marca != null ? value.marcaId == widget.marca!.id ? true : false : false,
            value: value,
            child:Text(value.nombre,style: TextStyle(decoration: widget.marca != null ?  value.marcaId == widget.marca!.id ? TextDecoration.none : TextDecoration.lineThrough: TextDecoration.lineThrough, color: Colors.black)),
          ); 
        }).toList(),
        onChanged: (widget.comboType == 'Marca') ||( widget.comboType == 'Tintura' && widget.productType == 'Tintura') ? (value) {
          widget.setItem(value);
        } : null
      )
        );
  }
  _createCustomBtn(Marcas? selectedMarca, Tinturas? selectedTintura , String hintText , BuildContext context , esTintura ) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ 
          Text( esTintura ? selectedTintura == null ?  hintText : _handleTinturaValue(selectedTintura , selectedMarca) : selectedMarca == null ? hintText : selectedMarca.nombre,style: const TextStyle(color: Colors.black , fontWeight:  FontWeight.bold)) , 
          const Icon(Icons.arrow_drop_down)
          ]
        ),
      height: 40,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
        color: (widget.comboType == 'Marca') ||( widget.comboType == 'Tintura' && widget.productType == 'Tintura') ? Colors.white : Colors.grey , 
        borderRadius: const BorderRadius.all(Radius.circular(10.0))));
  }
  
  _handleTinturaValue(Tinturas selectedTintura , Marcas? selectedMarca) {
    return selectedTintura.marcaId == selectedMarca!.id ? selectedTintura.nombre : 'Lineas';
  }
}
