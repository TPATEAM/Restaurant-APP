class Platillo {
  int? platilloId;
  String? platilloName;
  String? platilloDescription;
  int? platilloIdCategory;
  String? platilloPrice;
  String? platilloImageUrl;
  String? platilloListaIngredientes;

  Platillo(
      {this.platilloId,
      this.platilloName,
      this.platilloDescription,
      this.platilloIdCategory,
      this.platilloPrice,
      this.platilloImageUrl,
      this.platilloListaIngredientes});

  Platillo.fromJson(Map<String, dynamic> json) {
    platilloId = json['platilloId'];
    platilloName = json['platilloName'];
    platilloDescription = json['platilloDescription'];
    platilloIdCategory = json['platilloIdCategory'];
    platilloPrice = json['platilloPrice'];
    platilloImageUrl = json['platilloImageUrl'];
    platilloListaIngredientes = json['platilloListaIngredientes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platilloId'] = platilloId;
    data['platilloName'] = platilloName;
    data['platilloDescription'] = platilloDescription;
    data['platilloIdCategory'] = platilloIdCategory;
    data['platilloPrice'] = platilloPrice;
    data['platilloImageUrl'] = platilloImageUrl;
    data['platilloListaIngredientes'] = platilloListaIngredientes;
    return data;
  }
}
