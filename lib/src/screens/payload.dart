import 'package:flutter/material.dart';
import 'package:pelu_stock/src/api/hola.dart';
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
  late Future product;
  ItemProduct itemProduct = const ItemProduct('producto', 'Mascara LDKT', 2, '3', null);
  @override
  void initState() {
    product = updateApi();
    //updateApi().then((value) => null);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: product,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyTitle(title: 'Insumo'),
              const Spacer(flex: 1),
              Text(itemProduct.nombre ,style: const TextStyle(color: Colors.white)),
              const Spacer(flex: 1),
              MyTextField(width:  MediaQuery.of(context).size.width / 1.2,controller: cantidadController , context: context, hintText: 'Cantidad', isEnabled: true , inputType: TextInputType.number),
              const Spacer(flex: 1),
              MyTextField(width:  MediaQuery.of(context).size.width / 1.2,controller: rendimientoController, context: context, hintText: 'Rendimiento', isEnabled: true , inputType: TextInputType.number),
              const Spacer(flex: 6),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    ItemProduct itemProduct = ItemProduct('producto', 'Mascara LDKT', int.parse(cantidadController.text), rendimientoController.text,null);
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
    );
  }
}