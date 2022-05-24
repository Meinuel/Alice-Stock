import 'package:flutter/material.dart';

import '../styles/button_style.dart';
import '../widgets/FatWidgets/dialog_widget.dart';
import '../widgets/FatWidgets/dropdown_widget.dart';
import '../widgets/FatWidgets/product_widget.dart';
import '../widgets/FatWidgets/scann_widget.dart';
import '../widgets/SimpleWidgets/title_widget.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {

  List<String> marcas = ['Marca 1' , 'Marca 2' , 'Marca 3' , 'Marca 4'];
  final TextEditingController _barcodeTextController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _tonoController = TextEditingController();
  String marca = '';
  String linea = '';
  late Object productType = 'Producto';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyTitle(title: widget.title),
            ScannContainer(controller: _barcodeTextController),
            DropDownMenu(items: marcas , hintText: 'Marca' ,setItem: setMarca ),
            ProductType(setLinea: setLinea,setSelectedType: setProductType , selectedItem: productType ,productNameController: _productNameController, tonoController: _tonoController),
            const SizedBox(),
            ElevatedButton(
              onPressed: () => _handleForm(), 
              child: isLoading ? const SizedBox(width: 15,height: 15,child: CircularProgressIndicator(color: Colors.white )) :  const Text('ok'),
                style: buttonStyle(MediaQuery.of(context).size.width / 1.5)
            )
          ],
        ),
      );
  }
  setProductType(Object? newType){
    setState(() {
      productType = newType!;
    });
  }

  setMarca(String newMarca){
    setState(() {
      marca = newMarca;
    });
  }

  setLinea(String newLinea){
    setState(() {
      linea = newLinea;
    });
  }
  
  _handleForm() {
    bool hasError = false;
    if( _barcodeTextController.text != '' && marca != '' ){
      if( productType == 'Producto' ){
        _productNameController.text != '' ? DoNothingAction() : hasError = true;
      }else{
        linea != '' && _tonoController.text != '' ? DoNothingAction() : hasError = true;
      }
    } else {
      hasError = true;
    }
    if( !hasError ){
      setState(() {
        isLoading = true;
      });
      _updateApi().then((value) => _createDialog(value == 'Ok' ? 'Producto registrado' : 'error api'));
    }else{
      _createDialog('Error en form');
    }
  }
  

  _createDialog( String message ) {
    return showDialog(context: context, builder: (context){
      return MyDialog(message: message);
    });
  }
  
  Future _updateApi() async {
    String response = '';
    await Future.delayed(const Duration(seconds: 5), () {
      response = 'Ok';
      setState(() {
        isLoading = false;
      });
    },);
    return response;
  } 
}