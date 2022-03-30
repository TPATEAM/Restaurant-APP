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
      idPlatillo: json['idPlatillo'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
      listaIngredientes: json['listaIngredientes'],
      idCategory: int.parse(json['c1ategory'].toString()),
    );
  }

  List<Platillo> fromFbtoList(List<dynamic> lista) {
    List<Platillo> listaPlatillos = [];
    lista.forEach((element) {
      listaPlatillos.add(Platillo.fromJson(element));
    });
    return listaPlatillos;
  }
}
