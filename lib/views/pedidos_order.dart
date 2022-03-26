import 'package:flutter/material.dart';
import 'package:restaurant/views/orderdetails.dart';

class PedidosOrder extends StatefulWidget {
  final int numTable;
  const PedidosOrder({
    Key? key,
    required this.numTable
  }) : super(key: key);

  @override
  State<PedidosOrder> createState() => _PedidosOrderState();
}

class _PedidosOrderState extends State<PedidosOrder> {
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
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetails(),
                ),
              );
            },
            child: Text(
              "Mesa #" + widget.numTable.toString(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.black54,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(),
      ),
    );
  }
}
