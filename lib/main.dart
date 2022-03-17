import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/views/splash.dart';

void main() => runApp(MyUAT());

class MyUAT extends StatelessWidget {
  const MyUAT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante',
      debugShowCheckedModeBanner: false,
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
      home: SplashScreen(),
    );
  }
}