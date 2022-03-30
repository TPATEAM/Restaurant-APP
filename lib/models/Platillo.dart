import 'package:restaurant/models/Ingredient.dart';

class Platillo {
  int? idPlatillo;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  String? listaIngredientes;
  int? idCategory;

  Platillo({
    required this.idPlatillo,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.listaIngredientes,
    required this.idCategory,
  });

  factory Platillo.fromJson(Map<String, dynamic> json) {
    return Platillo(
      idPlatillo: json['id'],
      name: json['name'], 
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
      listaIngredientes: json['idIngredientes'],
      idCategory: json['idCategory'],
    );
  }
}
