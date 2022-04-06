import 'package:flutter/material.dart';
import 'package:restaurant/models/Ingredient.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/order_confirmation.dart';

class OrderDetails extends StatefulWidget {
  Platillo platillo;
  List<Ingredient> ingredientes;
  OrderDetails({
    Key? key,
    required this.platillo,
    required this.ingredientes,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

enum tipoPedido { restaurant, delivery }

class _OrderDetailsState extends State<OrderDetails> {
  tipoPedido? _typeOrder = tipoPedido.restaurant;
  late List<Ingredient> ingredientes = widget.ingredientes;
  List<Ingredient> ingredientesPlatillo = [];
  final observacionesController = TextEditingController();
  final codigoEspecialController = TextEditingController();

  void _addIngredientesPlatillo() {
    ingredientesPlatillo.clear();
    List<String> ingredientesID = widget.platillo.listaIngredientes!.split('|');
    for (int i = 0; i < ingredientesID.length; i++) {
      for (int j = 0; j < ingredientes.length; j++) {
        if (ingredientes.elementAt(j).idIngredient ==
            int.parse(ingredientesID[i])) {
          ingredientesPlatillo.add(ingredientes[j]);
        }
      }
    }
  }

  @override
  void initState() {
    _addIngredientesPlatillo();
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
            margin: EdgeInsets.only(top: 5),
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
                        width: MediaQuery.of(context).size.width * 0.26,
                        height: 115,
                        child: Image.network(
                          widget.platillo.imageUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.65,
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
                            width: MediaQuery.of(context).size.width * 0.65,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: ingredientesPlatillo.isEmpty
                                ? MediaQuery.of(context).size.height * 0.05
                                : MediaQuery.of(context).size.height * 0.2,
                            child: ingredientesPlatillo.isEmpty
                                ? Center(
                                    child: Text('No hay ingredientes.'),
                                  )
                                : ListView.builder(
                                    itemCount: ingredientesPlatillo.length,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        title: Text(
                                          ingredientesPlatillo
                                              .elementAt(index)
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: blackLight,
                                          ),
                                        ),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: ingredientesPlatillo
                                            .elementAt(index)
                                            .selected,
                                        onChanged: (value) {
                                          setState(() {
                                            ingredientesPlatillo
                                                .elementAt(index)
                                                .selected = value;
                                          });
                                        },
                                        activeColor: highBlue,
                                        checkColor: Colors.white,
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: GestureDetector(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: reptileGreen,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Agregar Ingredientes Extra',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: TextField(
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                              textInputAction: TextInputAction.next,
                              controller: observacionesController,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Observaciones',
                                prefixIcon: Icon(
                                  Icons.notes,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                labelText: 'Observaciones',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            child: TextField(
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                              textInputAction: TextInputAction.done,
                              controller: codigoEspecialController,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Codigo Especial',
                                prefixIcon: Icon(
                                  Icons.receipt,
                                  color: Colors.grey,
                                ),
                                contentPadding: EdgeInsets.all(10),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                labelText: 'Codigo Especial',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 110,
                          ),
                          Container(
                            height: 90,
                            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Confirmar',
                                  textAlign: TextAlign.center),
                              style: ElevatedButton.styleFrom(
                                primary: reptileGreen,
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
