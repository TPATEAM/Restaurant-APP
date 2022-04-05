class Ingredient {
  int? idIngredient;
  String? name;
  double? price;

  Ingredient({
    this.idIngredient,
    this.name,
    this.price,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      idIngredient: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }
}
