import 'package:flutter/material.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/widgets/utility/navbar.dart';

class Pedidos extends StatefulWidget {
  final int numTable;
  Pedidos({
    Key? key,
    required this.numTable
  }) : super(key: key);

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            bottom: TabBar(
              unselectedLabelColor: Colors.grey.shade400,
              labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
              labelColor: orangeHibiscus,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: orangeHibiscus,
                  width: 3
                ),
                insets: EdgeInsets.symmetric(horizontal: 20)
              ),
              tabs: const [
                Tab(text: 'COMPLETADOS'),
                Tab(text: 'PENDIENTES'),
              ],
            ),
            title: Text("Mesa #" + widget.numTable.toString(),
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.black54,
              ),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
             FirstScreen(),
             SecondScreen(),
            ],
          ),
          bottomNavigationBar: NavMenuBar(idx: 2),
        ),
      ),
    );
  }
}
 
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
              child: 
              Text('Pedidos Completados', 
                style: TextStyle(fontSize: 21),)
              )
            )
          );
  }
}
 
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
              child: 
              Text('Pedidos Pendientes',
                style: TextStyle(fontSize: 21),)
              )
            )
          );
  }
}