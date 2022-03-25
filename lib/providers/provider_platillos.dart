import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class ProviderPlatillos {
  List<dynamic> Platillo = [];
  ProviderPlatillos() {
    loadData();
  }

  void loadData() {
    rootBundle.loadString('assets/data/platillos.json').then((data) {
      Map dataMap = json.decode(data);
      Platillo = dataMap['platillos'];
    });
  }
}
