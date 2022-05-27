import 'package:flutter/material.dart';
import 'package:pelu_stock/src/models/item_product.dart';

import '../../bloc/table_bloc.dart';

class MyTable extends StatelessWidget {
  final TableBloc tableBloc ;
  final AsyncSnapshot<List<ItemProduct>> snapshot ;
  MyTable({Key? key , required this.tableBloc , required this.snapshot}) : super(key: key);

  final initialRow = 
    TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Insumos',style: _colTitleStyle()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Tono'   ,style: _colTitleStyle()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Cant'   ,style: _colTitleStyle()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Rend'   ,style: _colTitleStyle()),
        )
    ]);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white),
      children: _createTable(initialRow , snapshot , tableBloc));
  }
}

_colTitleStyle(){
  return const TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold);
}

_createTable(TableRow initialRow , AsyncSnapshot<List<ItemProduct>> snapshot , TableBloc tableBloc){
  List<TableRow> rows = [initialRow];
    for (var item in tableBloc.lastValue) {
      final tempRow = 
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.nombre ,style: const TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.tono ?? '',style: const TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.cantidad.toString(),style: const TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.rendimiento ?? '',style: const TextStyle(color: Colors.white)),
            ),
          ]);
      rows.add(tempRow);
    }
  return rows;
}