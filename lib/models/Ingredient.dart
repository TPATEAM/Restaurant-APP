import 'dart:ffi';

class Ingredient {
  int? idIngredient;
  String? name;
  String? description;
  bool? type;
  Float? price;

  Ingredient({
    this.idIngredient,
    this.name,
    this.description,
    this.type,
    this.price,
  });
}
