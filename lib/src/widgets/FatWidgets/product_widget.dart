import 'package:flutter/material.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/dropdown_widget.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/texfield_widget.dart';

class ProductType extends StatefulWidget {
  final Function setLinea;
  final Function setSelectedType;
  final Object selectedItem;
  final TextEditingController productNameController;
  final TextEditingController tonoController;
  const ProductType({Key? key , required this.setLinea  , required this.setSelectedType , required this.selectedItem , required this.productNameController , required this.tonoController}) : super(key: key);

  @override
  State<ProductType> createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {
  List<String> lineas = ['Linea 1' , 'Linea 2' , 'Linea 3' , 'Linea 4'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _createRadio('Producto'),
            const Text('Producto',style: TextStyle(color: Colors.greenAccent,fontSize: 18,fontWeight: FontWeight.bold),)
          ],
        ),
        MyTextField(
          width:  MediaQuery.of(context).size.width / 1.2,
          controller: widget.productNameController, 
          context: context , 
          hintText: 'Nombre' , 
          isEnabled: widget.selectedItem == 'Producto' ? true : false),
        const SizedBox(height: 15),
        Row(
          children: [
            _createRadio('Tintura'),
            const Text('Tintura',style: TextStyle(color: Colors.greenAccent,fontSize: 18,fontWeight: FontWeight.bold)),
          ],
        ),
        DropDownMenu(items: lineas,hintText: 'Linea',setItem: widget.setLinea),
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.only(left: 40),
          alignment: Alignment.bottomLeft,
          child: MyTextField(
            width:  MediaQuery.of(context).size.width / 3,
            controller: widget.tonoController, 
            context: context, 
            hintText: 'Tono', 
            isEnabled:  widget.selectedItem == 'Tintura' ? true : false),
        )

      ],
    );
  }
  
  _createRadio(String title) {
    return Container(
      margin: const  EdgeInsets.only(left: 15),
      child: Radio(
        value: title, 
        groupValue: widget.selectedItem, 
        onChanged: (value) => widget.setSelectedType(value),
        activeColor: Colors.red,
        fillColor: MaterialStateColor.resolveWith((states) => Colors.white)));
  }
}