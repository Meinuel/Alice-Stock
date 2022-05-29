import 'package:flutter/material.dart';
import 'package:pelu_stock/src/models/item_product.dart';

import '../../bloc/table_bloc.dart';

class MyTable extends StatefulWidget {
  final TableBloc tableBloc ;
  final AsyncSnapshot<List<ItemProduct>> snapshot ;
  const MyTable({Key? key , required this.tableBloc , required this.snapshot}) : super(key: key);

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 4.5;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: _createTiles(widget.tableBloc, width)
        ),
      ),
    );
  }
  _createTiles(TableBloc tableBloc,double width){

    final initialRow = ListTile(title: Row(
      children: [
        SizedBox(width: width , child: Center(child: Text('Nombre' , style: _colTitleStyle()))), 
        SizedBox(width: width , child: Center(child: Text('Tono', style: _colTitleStyle()))), 
        SizedBox(width: width , child: Center(child: Text('Cant', style: _colTitleStyle()))),
        SizedBox(width: width , child: Center(child: Text('Rend', style: _colTitleStyle())))
      ]));
    List<Widget> rowWidgets = [initialRow];

    for (var element in tableBloc.lastValue) {
      final tempWidget = Dismissible(
        onDismissed: (direction) {
          setState(() {
            var itemList = tableBloc.lastValue;
            itemList.removeWhere((e) => e.nombre == element.nombre);
            tableBloc.tableSink(itemList);
          });
        },
        background: Container(child: const Icon(Icons.delete,color: Colors.white) , color: Colors.black),
        key: UniqueKey(), 
        child: ListTile(
          title: Container(
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(border: Border.all(color: Colors.white,), borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                SizedBox(width: width , child: Center(child: Text(element.nombre , style: const TextStyle(color: Colors.white)))), 
                SizedBox(width: width , child: Center(child: Text(element.tono ?? '', style: const TextStyle(color: Colors.white)))), 
                SizedBox(width: width , child: Center(child: Text(element.cantidad.toString(), style: const TextStyle(color: Colors.white)))),
                SizedBox(width: width , child: Center(child: Text(element.rendimiento ?? '', style: const TextStyle(color: Colors.white))))
              ]),
          )));
      rowWidgets.add(tempWidget);
  }
    return rowWidgets;
  }
}

_colTitleStyle(){
  return const TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold);
}

_createBorders(){
  return const Border(bottom: BorderSide(color: Colors.white),left: BorderSide(color: Colors.white), right: BorderSide(color: Colors.white),top: BorderSide(color: Colors.white));
}
