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

  factory Platillo.fromJson(Map<String, dynamic> json) => Platillo(
    idPlatillo: json['platilloId'],
    name: json['platilloName'],
    description: json['platilloDescription'],
    price: json['platilloPrice'],
    imageUrl: json['platilloImageUrl'],
    listaIngredientes: json['platilloListaIngredientes'],
    idCategory: json['platilloIdCategory'],
  );
}
