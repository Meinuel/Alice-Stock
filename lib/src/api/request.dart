import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pelu_stock/src/models/marcas.dart';
import 'package:pelu_stock/src/models/tinturas.dart';
import 'dart:convert' as convert;
import 'package:xml/xml.dart';

import '../models/item_product.dart';

marcasGetAll() async {
  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:MarcasGetAll soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));
  var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/MarcasGetAll',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  final jsonData = parseRsp(res);
  List<Marcas> marcas = [];

  for (var element in jsonData) {
    var json = jsonDecode(element);
    final Marcas marca = Marcas(json['Id'], json['Nombre']); 
    marcas.add(marca);
  }

  final todo = await tinturasGetAll(marcas);
  return todo;
}

tinturasGetAll(List<Marcas> marcas) async {
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));
  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:LineasTinturasGetAll soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';
    var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/LineasTinturasGetAll',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  final jsonDataTinturas = parseRsp(res);
  List<Tinturas> tinturas = [];

  for (var element in jsonDataTinturas) {
    var json = jsonDecode(element);
    final Tinturas tintura = Tinturas(json['Id'], json['Nombre']); 
    tinturas.add(tintura);
  }
  return [marcas,tinturas];
}

insumosSave(barra , marcaId , esTintura , lineaId , tono , nombre , id) async {
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));

  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:InsumosSave xmlns="https://salonalice.com.ar/webservices/wsStock.php">
                <codigoBarras>$barra</codigoBarras>
                <marcaId>$marcaId</marcaId>
                <esTintura>$esTintura</esTintura>
                <lineaId>$lineaId</lineaId>
                <tono>$tono</tono>
                <nombre>$nombre</nombre>
                <id>$id</id>
            </ser:InsumosSave>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';

  var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/InsumosSave',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  //final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  return response == '' ? 'ok' : 'error';
}

reporteConsumo(desde , hasta) async {
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));

  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:ReporteConsumosPeriodo xmlns="https://salonalice.com.ar/webservices/wsStock.php">
                <fechaDesde>$desde</fechaDesde>
                <fechaHasta>$hasta</fechaHasta>
                <consolidado>0</consolidado>
            </ser:ReporteConsumosPeriodo>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';

  var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/ReporteConsumosPeriodo',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  print(res);
  return res;
}

Future<ItemProduct?> insumosGet(String barcode) async {
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));

  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:InsumosGet xmlns="https://salonalice.com.ar/webservices/wsStock.php">
                <codigoBarras>$barcode</codigoBarras>
            </ser:InsumosGet>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';

  var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/InsumosGet',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  print(res);
  if(res != '[[]]'){
    final jsonDataInsumo = parseRsp(res);
    final json = jsonDecode(jsonDataInsumo[0]);
    print(json);
    final ItemProduct product = ItemProduct(json['EsTintura'] == '0' ? 'producto' : 'tintura', json['NombreItem'], 0, '0', json['Tono'], json['CodigoDeBarras']);
    return product;
  }else{
    return null;
  }
}

Future consumosDiariosCreate(List<ItemProduct> productos , String fecha) async {
  var url = Uri.parse('https://salonalice.com.ar/webservices/wsStock.php');
  String basicAuth ='Basic ' + base64Encode(utf8.encode('pepe:123456'));
  String temp = '';

  for (var element in productos) {
    temp = temp + '{fecha:$fecha,codigoBarras:${element.codigoBarras},cantidad:${element.cantidad},rendimiento:${element.rendimiento}},';
  }
  String json = temp.substring(0 , temp.length - 1 );
  print(json);
  var bodyRequest = '''<?xml version="1.0" encoding="utf-8"?>
    <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="https://salonalice.com.ar/webservices/wsStock.php">
        <soapenv:Header/>
        <soapenv:Body>
            <ser:ConsumosDiariosCreate xmlns="https://salonalice.com.ar/webservices/wsStock.php">
                <json>$json</json>
            </ser:ConsumosDiariosCreate>
        </soapenv:Body>
    </soapenv:Envelope>
    ''';

  var rsp = await http.post(
    url,
    headers: {
      'Host':'salonalice.com.ar',
      'Content-Type' : 'text/xml; charset=utf-8',
      'SOAPAction'  : 'https://salonalice.com.ar/webservices/wsStock.php/ConsumosDiariosCreate',
      'Authorization': basicAuth
    },
    body: bodyRequest
  );

  var response = rsp.body.replaceAll('&quot', '').replaceAll(';', '');
  final res = XmlDocument.parse(response).findAllElements('return').first.innerText;
  print(res);
  print(response);
  return res == '' ? 'Ok' : 'error';
}

parseRsp(raw){
        List<String> lstObjects = [];
      if(raw == ''){
        return ['{"codigo":"1"}'];
      }else{
        bool isObj = false;
        String object = '';
        
        for (var unit in raw.codeUnits){
          String character = String.fromCharCode(unit);
          if(character == '{'){
            isObj = true;
            object = character + '"';
          }else if(character == ':'){
            object = object + '"' + character + '"';
          }else if(character == ','){
            object = object + '"' + character + '"';
          }else{
            if(character == '}'){
              isObj = false;
              object = object + '"' + character;
              lstObjects.add(object);
              object = '';
            }else{
              if(isObj == true){
                object = object + character;
              }
            }
          }
        } 
        return lstObjects;
  }
}