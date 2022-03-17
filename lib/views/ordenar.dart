import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/models/Platillo.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/widgets/pedidoslist.dart';

class OrdenarView extends StatefulWidget
{
  int table;
  Platillo platillo;
  OrdenarView({
    Key? key,
    required this.table,
    required this.platillo,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState()  {
    return Ordenar();
  }
}
enum tipoPedido { restaurant, delivery }
class Ordenar extends State<OrdenarView> {

  tipoPedido? _typeOrder = tipoPedido.restaurant;
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return fusionRed;
      }
      return leadBlue;
    }
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
        body: ListView(
          children: [ 
            Container(
              margin: EdgeInsets.only(top: 40, left: 20),
              child: Center(
                child: Text(
                  "Mesa #" + widget.table.toString(),
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
              height: 40,
            ),
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 115,
                child: Image.network(widget.platillo.imageUrl.toString(),
                  fit: BoxFit.cover,
                ),
                            ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            widget.platillo.name.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: blackLight,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                     ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 150,
                          height: 100,
                          child: Text(
                            widget.platillo.description.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 1),
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
            ),
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
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 30,
            ),

            Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextField(style: 
                          TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                          autofocus: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Observaciones',
                            prefixIcon: Icon(
                              Icons.comment,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            labelText: 'Observaciones', labelStyle: TextStyle(
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

            SizedBox(
              height: 50,
            ),

            Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextField(style: 
                          TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                          autofocus: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Especial',
                            prefixIcon: Icon(
                              Icons.tag,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            labelText: 'Codigo Especial', labelStyle: TextStyle(
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
            Container(
              margin: EdgeInsets.only(top: 30, left: 60, right: 60),
              decoration: BoxDecoration(
                color: reptileGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Agregar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],             
        ),
      ),
    );
  }
}