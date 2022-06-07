import 'package:flutter/material.dart';
import 'package:pelu_stock/src/widgets/FatWidgets/dropdown_widget.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/texfield_widget.dart';
import '../../models/marcas.dart';
import '../../models/tinturas.dart';

class ProductType extends StatefulWidget {
  final List<Tinturas> lineasTinturas; 
  final Function setLinea;
  final Function setSelectedType;
  final Object productType;
  final TextEditingController productNameController;
  final TextEditingController tonoController;
  final Tinturas? selectedTintura;
  final Marcas? selectedMarca;
  const ProductType({Key? key , required this.setLinea  , required this.setSelectedType , required this.productType , required this.productNameController , required this.tonoController , required this.lineasTinturas , this.selectedTintura , this.selectedMarca}) : super(key: key);

  @override
  State<ProductType> createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _createRadio('Producto'),
            const Text('Producto',style: TextStyle(color: Colors.greenAccent,fontSize: 18,fontWeight: FontWeight.bold))
          ],
        ),
        MyTextField(
          width:  MediaQuery.of(context).size.width / 1.2,
          controller: widget.productNameController, 
          context: context , 
          hintText: 'Nombre' , 
          isEnabled: widget.productType == 'Producto' ? true : false),
        const SizedBox(height: 15),
        Row(
          children: [
            _createRadio('Tintura'),
            const Text('Tintura',style: TextStyle(color: Colors.greenAccent,fontSize: 18,fontWeight: FontWeight.bold)),
          ],
        ),
        DropDownMenu(marca: widget.selectedMarca ,tinturas: widget.lineasTinturas,hintText: 'Linea',setItem: widget.setLinea , esTintura: true , tintura: widget.selectedTintura , productType: widget.productType.toString(),comboType: 'Tintura',),
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.only(left: 40),
          alignment: Alignment.bottomLeft,
          child: MyTextField(
            inputType: TextInputType.number,
            width:  MediaQuery.of(context).size.width / 3,
            controller: widget.tonoController, 
            context: context, 
            hintText: 'Tono', 
            isEnabled:  widget.productType == 'Tintura' ? true : false),
        )

      ],
    );
  }
  
  _createRadio(String title) {
    return Container(
      margin: const  EdgeInsets.only(left: 15),
      child: Radio(
        value: title, 
        groupValue: widget.productType, 
        onChanged: (value) => widget.setSelectedType(value),
        activeColor: Colors.red,
        fillColor: MaterialStateColor.resolveWith((states) => Colors.white)));
  }
}