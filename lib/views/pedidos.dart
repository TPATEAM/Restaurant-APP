import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/widgets/utility/navbar.dart';

class PedidosView extends StatefulWidget {
  final int table;

  const PedidosView(
    {
      Key? key,
      required this.table
    })
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ViewPedidos();
  }
}

class ViewPedidos extends State<PedidosView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade50,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 20),
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
              height: 20,
            ),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              color: fusionRed,
            ),
          ],
        ),
        bottomNavigationBar: NavBar(idx: 2),
      ),
    );
  }
}