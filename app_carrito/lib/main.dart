import 'package:app_carrito/models/productos_model.dart';
import 'package:app_carrito/pages/otra_pagina.dart';
import 'package:app_carrito/pages/pedido_lista.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false, //desactivo el modo marcado
     
      theme: ThemeData(
        
        primarySwatch: Colors.lightGreen, //aca puedo cambiar el color de la app(menu de arriba)
        
        
      ),
      home: MyHomePage(title: 'App carritos de compras'), //aca puedo cambiar el nombre del titulo princip.
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = List<ProductosModel>();   //todos los modelos gurdado en un listado

  List<ProductosModel> _listaCarro = List<ProductosModel>();

   @override //inistate para cargar los productos como la imagen y el nombre
  void initState() {
    super.initState();
    _productosDb();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold( //Implementa la estructura de disposición visual básica del diseño de materiales.(regresa el body)
      appBar: AppBar(
        //aca trabajo en la barra de tiulo para agregar un icono del carrito que cuente la cantidad de productos q seleccionemos
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,//le agrego el icono del carrito
                    size: 38,//tamaño
                  ),
                  if (_listaCarro.length > 0)//si es mayor a 0 agrega cant de num seleccionados
                    Padding( 
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () { // cuando presionemos nos lleva a la pantalla de pedidos
                if (_listaCarro.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_listaCarro),
                    ),
                  );
              },
            ),
          )
        ],
      ), //barra de titulo














      drawer:Container( //menu izq de opciones
        width: 170.0, //ancho
        child: Drawer( //devuelve el Drawer
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.white, //color del menu desplegable
            child: new ListView(
              padding:EdgeInsets.only(top:50.0),
              children: <Widget>[
                Container(
                  height: 120,
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(''),
                    accountEmail: new Text(''),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/f1.PNG'),// imagen del gorrito del chef
                      ),
                    ),
                  ),
                ),
                //ICONO HOME:
                 new Divider(), //Desde aca empiezo a hacer y conectar los iconos  a la otra pagina
                new ListTile(
                  title: new Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.home, //el icono de la casa
                    size: 30.0,//tamaño
                    color: Colors.black,//color
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>OtraPagina(),// lo conecto a la otra pagina. dart
                  )),
                ),
                 //ICONO DE CUMPONES
                new Divider(),//compio, pego y cambio nombres e iconos
                new ListTile(
                  title: new Text(
                    'Cupones',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.card_giftcard,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Tiendas',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.place,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                //ICONO DE PRODUCTOS
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Produtos',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new Icon(
                    Icons.fastfood,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                //ON CODE
                new Divider(),
                new ListTile(
                  title: new Text(
                    'QR Code',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: new FaIcon(
                    FontAwesomeIcons.qrcode,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => OtraPagina(),
                  )),
                ),
                new Divider(),
                
              ]
            ),
          ),
        ),
      ),
      body: _cuadroProductos(), //Creacion de grilla en donde van a cargar los productos
    );
  }

GridView _cuadroProductos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0), //todos los lados de 4.0
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),// dos columnas
      itemCount: _productosModel.length,//cuenta los productos de la "bd"
      itemBuilder: (context, index) { //le paso al contex  al index 
        final String imagen = _productosModel[index].image;
        var item = _productosModel[index];
        return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center, //para la aliniacion 
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded( //llamado a las imagenes dedsde el item q tiene cada uno de los archivos
                      child: new Image.asset("assets/images/$imagen",
                          fit: BoxFit.contain),
                    ),
                    Text(// aca se agregan los nombres
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(// para agregar el icono del carrito
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,// pila para agregar dl predcio y el icono
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          item.price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, //pintar el carrito
                              fontSize: 23.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!_listaCarro.contains(item))
                                  ? Icon(// ? si x defecto carrito verde sino rojo
                                      Icons.shopping_cart,
                                      color: Colors.green,
                                      size: 38,
                                    )
                                  : Icon( //sino
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!_listaCarro.contains(item))// lista vacia icono =verde
                                    _listaCarro.add(item);
                                  else
                                    _listaCarro.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ));
      },
    );
  }








  void _productosDb() {  //Emular una BD llamado productoBD,donde pondre el listado de los diferentes productos
    var list = <ProductosModel>[
      ProductosModel(
        name: 'Hamburguesa de soja',
        image: 'f2.jpg',
        price: 150,
        
      ),
       ProductosModel(
        name: 'Pizza',
        image: 'f3.png',
        price: 200,
      ), ProductosModel(
        name: 'CupcaKe',
        image: 'f4.jpg',
        price: 50,
      ), ProductosModel(
        name: 'Leche de almendras',
        image: 'f5.jpeg',
        price: 180,
      ), ProductosModel(
        name: 'Tacos',
        image: 'f6.jpg',
        price: 75,
      ), ProductosModel(
        name: 'Ensalada de Frutas',
        image: 'f7.jpg',
        price: 120,
      ), ProductosModel(
        name: 'Galletitas',
        image: 'f8.jpg',
        price: 150,
      ), ProductosModel(
        name: 'Yogurt de CoCo',
        image: 'f9.png',
        price: 75,
      ),
      ];

setState(() { //setState() programa una actualización al objeto estado de un componente.
      _productosModel = list;
    });
  }
}