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
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: SplashScreen(),
    );
  }
}