import 'package:pelu_stock/src/models/item_product.dart';
import 'package:rxdart/rxdart.dart';

class TableBloc{
  final _tableController = BehaviorSubject<List<ItemProduct>>();
  Function(List<ItemProduct>) get tableSink => _tableController.sink.add;
  Stream<List<ItemProduct>> get tableStream => _tableController.stream;

  List<ItemProduct> get lastValue => _tableController.value;
}