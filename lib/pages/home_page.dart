import 'package:cobaoedu/bloc/provider.dart';
import 'package:cobaoedu/model/product_model.dart';
import 'package:cobaoedu/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
  final bloc = Provider.of(context);



    return Scaffold(
      appBar: AppBar(
          title: Text('Home')
      ),
      body: _CrearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }
  Widget _CrearListado(){
    return FutureBuilder(
        future: productosProvider.cargarProductos(),
        builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
          if(snapshot.hasData){
            final productos = snapshot.data;
            return ListView.builder(
              itemCount: productos?.length,
              itemBuilder: (context, i)=> _crearItem(context, productos![i]),
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _crearItem(BuildContext context,ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        //TODO: borrar producto
        productosProvider.borrarProducto(producto.id!);
      },
      child: ListTile(
        title: Text('${producto.titulo} - ${producto.valor }'),
        subtitle: Text('${producto.id}'),
        onTap: () => Navigator.pushNamed(context, 'producto'),
      ),
    );
  }
  _crearBoton(BuildContext context){
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: ()=> Navigator.pushNamed(context, 'producto'),
    );
  }
}