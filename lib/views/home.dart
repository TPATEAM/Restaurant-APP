import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/values.dart';
import 'package:restaurant/widgets/utility/navbar.dart';
import 'package:restaurant/widgets/tables.dart';

class HomeScreen extends StatelessWidget {

  String name = 'Nombre Apellido';
  String role = 'Mesero';

  HomeScreen({Key? key}) : super(key: key);

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
            /* =============== [ HEADER ] ===============*/
            Container(
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
                      onPressed: () {
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name, style: 
                        TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: blackLight,
                        ),
                      ),
                      Text(role, style: 
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
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            ),
            /* =============== [ BODY ] ===============*/
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      color: Colors.grey.shade400,
                      child: Center(
                        child: Text('Entrada', style: 
                          TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: blackLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Tables(table: 1),
                    Tables(table: 2),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Tables(table: 3),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Tables(table: 4),
                    Tables(table: 5),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Tables(table: 6),
                    Tables(table: 7),
                    Tables(table: 8),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: NavBar(idx: 0),
      ),
    );
  }
}