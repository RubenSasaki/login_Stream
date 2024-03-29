import 'dart:convert';

import 'package:cobaoedu/model/product_model.dart';
import 'package:http/http.dart' as http;
class ProductosProvider {
  final String _url = 'https://cobaosliders-4aa2f-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{
    final  url = '$_url/productos.json';
    final resp = await http.post(url as Uri, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }
/*
  Future<bool> editarProducto(ProductoModel producto) async{
    final  url = '$_url/productos/${producto.id}.json';
    final resp = await http.put(url as Uri, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }
*/

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url as Uri);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = [];
    
    if(decodedData == null) return [];
    
    decodedData.forEach((id, prod) { //id es el numero del documento de la coleeccion de productos y el prod es el producto yo lo que hay lamacenado dentro del documento
    final prodTemp = ProductoModel.fromJson(prod);
    prodTemp.id = id;

    productos.add(prodTemp);
    });

    return productos;
  }

  Future<int> borrarProducto(String id) async{
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url as Uri);

    return 1;
  }
}
