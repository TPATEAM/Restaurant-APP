import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/models/Ingredient.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';

class OrderDetails extends StatefulWidget {
  Platillo platillo;
  OrderDetails({
    Key? key,
    required this.platillo
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

enum tipoPedido { 
  restaurant, 
  delivery
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Ingredient> ingredientes = [];
  tipoPedido? _typeOrder = tipoPedido.restaurant;

  void _loadIngredientes() async {
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

  @override
  void initState() {
    _loadIngredientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
            'Platillo',
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 115,
                        child: Image.network(
                          widget.platillo.imageUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                              widget.platillo.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: blackLight,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              widget.platillo.description.toString(),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: blackLight,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                      top: 5),
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<tipoPedido>(
                            value: tipoPedido.restaurant,
                            groupValue: _typeOrder,
                            onChanged: (tipoPedido? value) {
                              setState(() {
                                _typeOrder = value;
                              });
                            },
                          ),
                          Text(
                            'Restaurante',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: blackLight,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Radio<tipoPedido>(
                            value: tipoPedido.delivery,
                            groupValue: _typeOrder,
                            onChanged: (tipoPedido? value) {
                              setState(() {
                                _typeOrder = value;
                              });
                            },
                          ),
                          Text(
                            'Para Llevar',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: blackLight,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            color: fusionRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
