import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pelu_stock/src/models/item_product.dart';

import '../../bloc/table_bloc.dart';

class MyTable extends StatefulWidget {
  final TableBloc tableBloc ;
  final AsyncSnapshot<List<ItemProduct>> snapshot ;
  final Function createRoute ;
  const MyTable({Key? key , required this.tableBloc , required this.snapshot, required this.createRoute}) : super(key: key);

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
      final tempWidget = _buildListTile(tableBloc,element,width);
      rowWidgets.add(tempWidget);
    }
    return rowWidgets;
  }
  
  _buildListTile(TableBloc tableBloc , ItemProduct itemProduct, double width) {
    return Slidable(
      key: UniqueKey(), 
      endActionPane: ActionPane(
        motion: const ScrollMotion(), 
        children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                var itemList = tableBloc.lastValue;
                itemList.removeWhere((e) => e == itemProduct);
                tableBloc.tableSink(itemList);
              });
            },        
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
            flex: 1,     
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Borrar',
          ),
          SlidableAction(
            onPressed: (context) {
              final element = tableBloc.lastValue.firstWhere((e) => e == itemProduct);
              var itemList = tableBloc.lastValue;
              itemList.removeWhere((e) => e == itemProduct);
              tableBloc.tableSink(itemList);
              widget.createRoute(element.codigoBarras);
            },
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(5)),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.change_circle,
            label: 'Cambiar',
          ),]),
          
      child: ListTile(
        title: Container(
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(border: Border.all(color: Colors.white,), borderRadius: BorderRadius.circular(5),color: const Color.fromARGB(255, 42, 40, 40)),
          child: Row(
            children: [
              SizedBox(width: width , child: Center(child: Text(itemProduct.nombre))), 
              SizedBox(width: width , child: Center(child: Text(itemProduct.tono ?? ''))), 
              SizedBox(width: width , child: Center(child: Text(itemProduct.cantidad.toString()))),
              SizedBox(width: width , child: Center(child: Text(itemProduct.rendimiento ?? '')))
            ]),
        )));
  }
}

_colTitleStyle(){
  return const TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold);
}
