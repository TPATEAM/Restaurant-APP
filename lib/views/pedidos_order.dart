import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/views/orderdetails.dart';

class PedidosOrder extends StatefulWidget {
  final int numTable;
  List<Platillo>? listaPlatillos;
  PedidosOrder(
      {Key? key, required this.numTable, this.listaPlatillos})
      : super(key: key);

  @override
  State<PedidosOrder> createState() => _PedidosOrderState();
}

class _PedidosOrderState extends State<PedidosOrder> {

  final query = TextEditingController();
  List<Platillo> listaPlatillosSearch = [];
  @override
  Widget build(BuildContext context) {
    listaPlatillosSearch = widget.listaPlatillos!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                        ),
                        textInputAction: TextInputAction.done,
                        controller: query,
                        onChanged: (value) {
                          print(listaPlatillosSearch.length);
                        },
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nombre del Platillo',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          labelText: 'Buscar Platillo',
                          labelStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
