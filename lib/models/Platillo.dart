class Platillo
{
  int? id;
  String? name;
  String? description;
  String? category;
  String? price;
  String? imageUrl;

  Platillo({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.imageUrl,
  });

  factory Platillo.fromJson(Map<String, dynamic> json) {
    return Platillo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}