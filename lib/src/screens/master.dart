import 'package:flutter/material.dart';
import 'package:pelu_stock/src/api/request.dart';
import 'package:pelu_stock/src/models/tinturas.dart';
import 'package:pelu_stock/src/screens/error.dart';
import '../models/marcas.dart';
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

  Future productos = getMarcasTinturas();
  final TextEditingController _barcodeTextController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _tonoController = TextEditingController();
  Marcas? marca ;
  Tinturas? linea ;
  late Object productType = 'Producto';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: productos,
      builder: (context,snapshot) =>
        snapshot.connectionState == ConnectionState.waiting ? _createLoader() : 
          snapshot.data == 'Error' ? _handleError() : _createMaster(snapshot)
    );
  }
  setProductType(Object? newType){
    setState(() {
      productType = newType!;
    });
  }

  setMarca(Marcas newMarca){
    setState(() {
      marca = newMarca;
    });
  }

  setLinea(Tinturas newLinea){
    setState(() {
      linea = newLinea;
    });
  }
  
  _handleForm() {
    bool hasError = false;
    if( _barcodeTextController.text != '' && marca != null ){
      if( productType == 'Producto' ){
        _productNameController.text != '' ? DoNothingAction() : hasError = true;
      }else{
        linea != null && _tonoController.text != '' && (linea!.marcaId == marca!.id) ? DoNothingAction() : hasError = true;
      }
    } else {
      hasError = true;
    }
    if( !hasError ){
      setState(() {
        isLoading = true;
      });
      insumosSave(_barcodeTextController.text , marca!.id , productType == 'Producto' ? 0 : 1 , productType == 'Producto' ? "" : linea!.id , productType == 'Producto' ? "" : _tonoController.text , _productNameController.text , '0')
        .then((value) {
          setState((){
            isLoading = false;
          });
          _createDialog(value == 'ok' ? 'Producto registrado' : 'Error , reintente');});
    }else{
      _createDialog('Faltan datos');
    }
  }

  _createDialog( String message ) {
    return showDialog(context: context, builder: (context){
      return MyDialog(message: message);
    }).then((value) {
      if(message == 'Producto registrado'){
        setState(() {
          _barcodeTextController.clear();
          _productNameController.clear();
          _tonoController.clear();
          marca = Marcas('','');
          linea = Tinturas('','','','');
        });
      }
    });
  }
  
  _createLoader() {
    return const Center(child: CircularProgressIndicator());
  }
  
  _createMaster(AsyncSnapshot snapshot) {
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyTitle(title: widget.title),
        ScannContainer(controller: _barcodeTextController),
        DropDownMenu(marcas: snapshot.data[0], hintText: 'Marca' ,setItem: setMarca , marca: marca , esTintura: false,productType: productType.toString(),comboType: 'Marca'),
        ProductType(selectedMarca: marca ,setLinea: setLinea,setSelectedType: setProductType , productType: productType ,productNameController: _productNameController, tonoController: _tonoController , lineasTinturas: snapshot.data[1] ,selectedTintura: linea ),
        const SizedBox(),
        ElevatedButton(
          onPressed: () => _handleForm(), 
          child: isLoading ? const SizedBox(width: 15,height: 15,child: CircularProgressIndicator(color: Colors.white )) :  const Text('Ok'),
            style: buttonStyle(MediaQuery.of(context).size.width / 1.5)
        )
      ],
    ),
  );
  }
  
  _handleError() {
    return ErrorPage(reload: reaload);
  } 
  reaload(){
    setState(() {
      productos = marcasGetAll();
    });
  }
}
