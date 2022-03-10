import 'package:flutter/material.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/pedidos.dart';

class Tables extends StatelessWidget{
  final int table;
  const Tables({Key? key,
    required this.table}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => PedidosView(table: table)
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset('assets/images/table_free.png',
            width: 96,
            color: reptileGreen,
          ),
          Center(
            child: Text(table.toString(), style:
              TextStyle(
                fontFamily: 'Inter',
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}