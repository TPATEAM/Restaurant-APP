import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/models/platillo.dart';

List<Platillo> parsePlatillo(String responseBody)
{
  var list = json.decode(responseBody) as List<dynamic>;
  var platillos = list.map((model) => Platillo.fromJson(model)).toList();
  return platillos;
}

Future<List<Platillo>> fetchPlatillo() async {
  const url = 'https://raw.githubusercontent.com/TPATEAM/Restaurant-APP/main/assets/data/platillos.json?token=GHSAT0AAAAAABRQS7N3OBLYO5BV5GADKSH4YSA2HVA';
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200)
  {
    return compute(parsePlatillo, response.body);
  }
  else
  {
    throw Exception('Error al cargar los platillos');
  }
}