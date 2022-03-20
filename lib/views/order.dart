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
  List<Data> platillosData = [];
  //===========================================================
  
  //===========================================================
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
                    findPlatillo(value.toString());
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
    platillosData.clear();
    value = value.toLowerCase();
    List<String> keys = value.split(" ");
    List<Platillo> temp = platillos;
    int idx = 0;
    for(var platillo in platillos)
    {
      idx++;
      platillosData.add(Data(platillo: platillo));
      
      platillosData.elementAt(idx).ocurrencias = 0;
      platillosData.elementAt(idx).posiciones!.clear();
    }
    idx = 0;
    for(var platillo in platillos)
    {
      idx++;
      for(int i = 0; i < keys.length; i++)
      {
        if(platillos.elementAt(idx).name!.toLowerCase().indexOf(keys.elementAt(i)) > -1)
        {
          platillosData.elementAt(idx).ocurrencias = (platillosData.elementAt(idx).ocurrencias! + 1);
          platillosData.elementAt(idx).posiciones!.add(platillos.elementAt(idx).name!.toLowerCase().indexOf(keys.elementAt(i)));
        }
      }
      for(int i = 0; i < platillosData.length; i++)
      {
        if(platillosData.elementAt(idx).ocurrencias! > platillosData.elementAt(i).ocurrencias!)
        {
          Data aux = platillosData.elementAt(idx);
          platillosData.insert(idx, platillosData.elementAt(i));
          platillosData.insert(i, aux);
        }
        else if(platillosData.elementAt(idx).ocurrencias == platillosData.elementAt(i).ocurrencias)
        {
          if(platillosData.elementAt(idx).platillo!.name!.compareTo(platillosData.elementAt(i).platillo!.name.toString()) < 0)
          {
            Data aux = platillosData.elementAt(idx);
            platillosData.insert(idx, platillosData.elementAt(i));
            platillosData.insert(i, aux);
          }
        }
        if(platillosData.elementAt(idx).ocurrencias! > 0 && platillosData.elementAt(i).ocurrencias! > 0)
        {
          if(platillosData.elementAt(idx).posiciones!.elementAt(0) < platillosData.elementAt(i).posiciones!.elementAt(0))
          {
            Data aux = platillosData.elementAt(idx);
            platillosData.insert(idx, platillosData.elementAt(i));
            platillosData.insert(i, aux);
          }
        }
      }
    }
    bool enc = false;
    for(int i = 0; i < platillosData.length; i++)
    {
      if(platillosData.elementAt(i).ocurrencias! > 0)
      {
        enc = true;
        setState(() {
        platillos.add(platillosData.elementAt(i).platillo!);});
      }
    }
  }
}

  class Data
  {
    Platillo? platillo;
    int? ocurrencias;
    List<int>? posiciones;

    Data({
      required this.platillo,
      this.ocurrencias = 0,
    });
  }