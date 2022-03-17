import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/services.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/widgets/pedidoslist.dart';
import 'package:restaurant/widgets/utility/navbar.dart';

class OrderView extends StatefulWidget
{
  int table;
  OrderView({Key? key, required this.table}) : super(key: key);

  @override
  State<StatefulWidget> createState()  {
    return Order();
  }
}
class Order extends State<OrderView> 
{
  final platilloName = TextEditingController();
  List<Platillo> platillos = [];
  List<Platillo> temp = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade50,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          ),
        ),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, left: 20),
                child: Center(
                  child: Text(
                    "Orden Mesa #" + widget.table.toString(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: TextField(style: 
                  TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                  controller: platilloName,
                  onChanged: (value)
                  {
                    setState(() {
                      findPlatillo(value);
                    });
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Nombre Platillo',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  labelText: 'Platillo', labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: readJsonData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    platillos = snapshot.data;
                    temp = platillos;
                    return PlatilloView(platillos: platillos);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavMenuBar(idx: 2),
      ),
    );
  }

  Future<List<Platillo>>readJsonData() async
  {
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/platillos.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Platillo.fromJson(e)).toList();
  }

  void findPlatillo(String value) {
    List<Platillo> temp = platillos;
    for(var platillo in platillos)
    {
      if(platillo.name!.toLowerCase().toString().contains(value.toLowerCase()))
      {
        platillos.remove(platillo);
      }
    }
  }
}