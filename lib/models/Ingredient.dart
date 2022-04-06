class Ingredient {
  int? idIngredient;
  String? name;
  double? price;
  bool? selected;

  Ingredient({
    this.idIngredient,
    this.name,
    this.price,
    this.selected = true,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      idIngredient: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }
}
