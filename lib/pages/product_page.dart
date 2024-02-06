import 'package:cobaoedu/model/product_model.dart';
import 'package:cobaoedu/providers/productos_provider.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();
  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    ///esto es para lo de editar los registros pero tenemos problema spor no ser nulos asiq ue seria CORREGIR ESO
    /*final ProductoModel? prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null){
      producto = prodData;
    }*/
    return Scaffold(
      appBar: AppBar(
        title: Text('producto'),
        actions:
          <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.photo_size_select_actual),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)  ,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _guardar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'producto'
      ),
      validator: (value){
        if(value!.length < 3){
          return 'ingrese el nombre del producto';
        }else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Precio'
      ),
      onSaved: (value) => producto.valor = double.parse(value!),
      validator: (value){
        if(utils.isNumeric(value!)){
          return null;
        }else {
          return 'solo numeros';
        }
      },
    );
  }
  Widget _crearDisponible(){
    return  SwitchListTile(
        value: producto.disponible,
        title: Text("Disponible"),
        activeColor: Colors.deepPurple,
        onChanged: (value)=> setState(() {
          producto.disponible = value;
        }),
        );
  }
  Widget _guardar(){
  return ElevatedButton.icon(
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            )
        ),
    ),
    label: Text('guardar'),
    icon: Icon(Icons.save),
    onPressed: _submit,
  );
  }

  void _submit(){
  if(!formKey.currentState!.validate()) return;
  formKey.currentState!.save();
  productoProvider.crearProducto(producto);
  }
}
