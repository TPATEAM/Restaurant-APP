import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/models/Employee.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/widgets/TablesView.dart';
import 'package:restaurant/widgets/utility/navbar.dart';

class HomeScreen extends StatelessWidget {
  Employee? empleado;

  HomeScreen({
    Key? key,
    this.empleado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
            /* =============== [ HEADER ] ===============*/
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                          offset: Offset(
                            10.0,
                            10.0,
                          ),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.qr_code),
                      iconSize: 24,
                      onPressed: () {},
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(empleado!.name.toString() + " " + empleado!.lastName.toString(), style: 
                        TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: blackLight,
                        ),
                      ),
                      Text(empleado!.role == 1 ? 'Administrador'
                      : 'Mesero', style: 
                        TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: fusionRed,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              margin: EdgeInsets.only(left: 60, right: 60),
              color: Colors.grey.shade300,
            ),
            /* =============== [ BODY ] ===============*/
            
            SingleChildScrollView(
              padding: EdgeInsets.only(top:20),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 45,
                              color: Colors.grey.shade400,
                            ),
                            Text('Entrada',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TablesView(numTable: 1, employee: empleado!),
                        TablesView(numTable: 2, employee: empleado!),
                        TablesView(numTable: 3, employee: empleado!),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TablesView(numTable: 4, employee: empleado!),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TablesView(numTable: 5, employee: empleado!),
                        TablesView(numTable: 6, employee: empleado!),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TablesView(numTable: 7, employee: empleado!),
                        TablesView(numTable: 8, employee: empleado!),
                        TablesView(numTable: 9, employee: empleado!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavMenuBar(idx: 0),
      ),
    );
  }
}