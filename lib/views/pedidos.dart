import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/Employee.dart';
import 'package:restaurant/models/Ingredient.dart';
import 'package:restaurant/models/Pedido.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/pedidos_order.dart';
import 'package:restaurant/widgets/utility/navbar.dart';

int mesa = 0;

class Pedidos extends StatefulWidget {
  final int numTable;
  final Employee employee;
  const Pedidos({
    Key? key,
    required this.numTable,
    required this.employee,
  }) : super(key: key);

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  List<Platillo> platillos = [];
  List<Category> categorias = [];
  List<Pedido> pedidos = [];
  List<Ingredient> ingredientes = [];

  void _loadPlatillos() async {
    platillos.clear();
    await FirebaseFirestore.instance
        .collection('Platillos')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        platillos.add(Platillo.fromJson(document.data()));
      });
    });
  }

  void _loadIngredients() async {
    ingredientes.clear();
    await FirebaseFirestore.instance
        .collection('Ingredient')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        ingredientes.add(Ingredient.fromJson(document.data()));
      });
    });
  }

  void _loadCategories() async {
    categorias.clear();
    await FirebaseFirestore.instance
        .collection('Category')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        categorias.add(Category.fromJson(document.data()));
      });
    });
  }

  void _loadPedidos() async {
    pedidos.clear();
    await FirebaseFirestore.instance
        .collection('Pedidos')
        .where('numMesa', isEqualTo: widget.numTable)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        pedidos.add(Pedido.fromJson(document.data()));
      });
    });
  }

  @override
  void initState() {
    _loadPlatillos();
    _loadCategories();
    _loadIngredients();
    _loadPedidos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mesa = widget.numTable;
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade50,
          backwardsCompatibility: false,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.grey.shade400,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              bottom: TabBar(
                unselectedLabelColor: Colors.grey.shade400,
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                labelColor: orangeHibiscus,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: orangeHibiscus, width: 3),
                    insets: EdgeInsets.symmetric(horizontal: 20)),
                tabs: const [
                  Tab(text: 'PENDIENTES'),
                  Tab(text: 'COMPLETADOS'),
                ],
              ),
              title: Text(
                "Mesa #" + widget.numTable.toString(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.black54,
                ),
              ),
              centerTitle: true,
            ),
          ),
          body: TabBarView(
            children: [
              PedidosPendientes(),
              PedidosCompletados(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PedidosOrder(
                      numTable: widget.numTable,
                      listaPlatillos: platillos,
                      listaCategorias: categorias,
                      listaIngredientes: ingredientes,
                      employee: widget.employee,
                    ),
                  ));
            },
            child: Icon(Icons.add),
            backgroundColor: reptileGreen,
          ),
          bottomNavigationBar: NavMenuBar(idx: 2),
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////
class PedidosCompletados extends StatefulWidget {

  PedidosCompletados({
    Key? key,
  }) : super(key: key);

  @override
  State<PedidosCompletados> createState() => _PedidosCompletadosState();
}

class _PedidosCompletadosState extends State<PedidosCompletados> {
  List<Platillo> platillos = [];
  List<Pedido> pedidos = [];
  int numMesa = mesa;

  _loadPedidos() async {
    pedidos.clear();
    await FirebaseFirestore.instance
        .collection('Pedidos')
        .where('numMesa', isEqualTo: numMesa)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        Pedido pedido = Pedido.fromJson(document.data());
        if(!pedido.estado!)
        {
          pedidos.add(Pedido.fromJson(document.data()));
        }
      });
    });    
    setState(() {});
  }

  _loadPlatillos() async {
    platillos.clear();
    await FirebaseFirestore.instance
        .collection('Platillos')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        platillos.add(Platillo.fromJson(document.data()));
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPedidos();
    _loadPlatillos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            color: Colors.white, child: Center(child: Text('No hay pedidos completados.'))),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////////
class PedidosPendientes extends StatefulWidget {
  PedidosPendientes({
    Key? key,
  }) : super(key: key);

  @override
  State<PedidosPendientes> createState() => _PedidosPendientesState();
}

class _PedidosPendientesState extends State<PedidosPendientes> {
  List<Platillo> platillos = [];
  List<Pedido> pedidos = [];
  int numMesa = mesa;

  _loadPedidos() async {
    pedidos.clear();
    await FirebaseFirestore.instance
        .collection('Pedidos')
        .where('numMesa', isEqualTo: numMesa)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        Pedido pedido = Pedido.fromJson(document.data());
        if(pedido.estado!)
        {
          pedidos.add(Pedido.fromJson(document.data()));
        }
      });
    });    
    setState(() {
      
    });
  }

  _loadPlatillos() async {
    platillos.clear();
    await FirebaseFirestore.instance
        .collection('Platillos')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        platillos.add(Platillo.fromJson(document.data()));
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPedidos();
    _loadPlatillos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: pedidos.isEmpty ?
          Center(child: Text('No hay pedidos pendientes.')):
          ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Column(
                      children: [
                        Image.network(
                          findPlatillo(pedidos[index].platillo).imageUrl.toString(),
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                findPlatillo(pedidos[index].platillo).name.toString(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: blackLight,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                              child: Text(
                                '\$' +
                                    findPlatillo(pedidos[index].platillo)
                                        .price!
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: blackLight,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                findPlatillo(pedidos[index].platillo).description
                                    .toString(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: EdgeInsets.only(top: 10),
                              child: Text( 'Hace ' +
                                _calcularDiferencia(pedidos[index].fecha).toString(),
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      // ),
    );
  }

  Platillo findPlatillo(int? idx){
    late Platillo plato;
    for(int i = 0; i < platillos.length; i++)
    {
      if(platillos[i].idPlatillo == idx)
      {
        plato = platillos[i];
      }
    }
    return plato;
  }

  _calcularDiferencia(DateTime? fecha) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(fecha!);
    int hours = difference.inHours;
    int minutes = difference.inMinutes;

    if (hours > 0) {
      return hours.toString() + ' horas';
    } else if (minutes > 0) {
      return minutes.toString() + ' minutos';
    } else {
      return 'unos segundos';
    }
  }
}
