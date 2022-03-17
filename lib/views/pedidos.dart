import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/views/order.dart';
import 'package:restaurant/widgets/pedidoslist.dart';
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
  Color viewCompleted = Colors.grey.shade400;
  Color viewPending = fusionRed;
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
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 20),
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
              height: 30,
            ),
            Column(
              children: [
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade400,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            viewCompleted = reptileGreen;
                            viewPending = Colors.grey.shade400;
                          });
                        },
                        child: Text('Completadas', 
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: viewCompleted,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            viewCompleted = Colors.grey.shade400;
                            viewPending = fusionRed;
                          });
                        },
                        child: Text('Pendientes', 
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: viewPending,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            //PlatilloView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderView(table: widget.table),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: reptileGreen,
        ),
        bottomNavigationBar: NavMenuBar(idx: 2),
      ),
    );
  }
}