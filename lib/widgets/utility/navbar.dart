import 'package:flutter/material.dart';
import 'package:restaurant/values.dart';

class NavBar extends StatelessWidget {
  final int idx;
  const NavBar({Key? key, required this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.chair_rounded),
          label: 'Mesas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'Platillos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Pedidos',
        ),
      ],
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      enableFeedback: true,
      backgroundColor: fusionRed,
      unselectedItemColor: Colors.white38,
      selectedItemColor: Colors.white,
      currentIndex: idx,
      onTap: (int index) {},
    );
  }
}