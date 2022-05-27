import 'package:flutter/material.dart';
import 'package:pelu_stock/src/api/hola.dart';
import 'package:pelu_stock/src/api/request.dart';
import 'package:pelu_stock/src/bloc/table_bloc.dart';
import 'package:pelu_stock/src/models/item_product.dart';
import 'package:pelu_stock/src/styles/button_style.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/texfield_widget.dart';
import 'package:pelu_stock/src/widgets/SimpleWidgets/title_widget.dart';

class PayLoad extends StatefulWidget {
  final String barcode;
  final TableBloc tableBloc;
  const PayLoad({Key? key , required this.barcode , required this.tableBloc}) : super(key: key);

  @override
  State<PayLoad> createState() => _PayLoadState();
}

class _PayLoadState extends State<PayLoad> {

  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController rendimientoController = TextEditingController();
  late Future<ItemProduct?> product = insumosGet(widget.barcode);
  ItemProduct itemProduct = const ItemProduct('', '', 0, '', null , '');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemProduct?>(
      future: product,
      builder: (context,AsyncSnapshot<ItemProduct?> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data != null ? _createPayload(snapshot) : _handleError();
      }
    );
  }
  
  _createPayload(AsyncSnapshot<ItemProduct?> snapshot) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyTitle(title: 'Insumo'),
          const Spacer(flex: 1),
          Text(snapshot.data!.nombre ,style: const TextStyle(color: Colors.white)),
          const Spacer(flex: 1),
          MyTextField(width:  MediaQuery.of(context).size.width / 1.2,controller: cantidadController , context: context, hintText: 'Cantidad', isEnabled: true , inputType: TextInputType.number),
          const Spacer(flex: 1),
          MyTextField(width:  MediaQuery.of(context).size.width / 1.2,controller: rendimientoController, context: context, hintText: 'Rendimiento', isEnabled: true , inputType: TextInputType.number),
          const Spacer(flex: 6),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                ItemProduct itemProduct = ItemProduct(snapshot.data!.type, snapshot.data!.nombre, int.parse(cantidadController.text), rendimientoController.text,null, widget.barcode);
                final List<ItemProduct> listItemProduct = widget.tableBloc.lastValue;
                listItemProduct.add(itemProduct);
                widget.tableBloc.tableSink(listItemProduct);
                Navigator.pop(context);
              }, 
              style: buttonStyle(MediaQuery.of(context).size.width / 1.5),
              child: const Text('Ok'))),
          const Spacer(flex: 2)
        ],
      ),
    );
  }
  
  _handleError() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No se reconocio el codigo de barras'),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Volver'))
        ],),
      ),
    );
  }
}