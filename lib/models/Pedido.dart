import 'dart:convert';

List<Pedido> pedidoFromJson(String str) => List<Pedido>.from(json.decode(str).map((x) => Pedido.fromJson(x)));

String pedidoToJson(List<Pedido> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pedido{
  int? id;
  int? numMesa;
  DateTime? fecha;
  int? empleado;
  int? platillo;
  String? anotaciones;
  String? codigo;
  bool? estado;
  String? extras;

  Pedido({
    this.id,
    this.numMesa,
    this.fecha,
    this.empleado,
    this.platillo,
    this.anotaciones,
    this.codigo,
    this.estado,
    this.extras,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
    id: json["id"],
    numMesa: json["numMesa"],
    fecha: json["fecha"].toDate(),
    empleado: json["empleado"],
    platillo: json["platillo"],
    anotaciones: json["anotaciones"],
    codigo: json["codigo"],
    estado: json["estado"],
    extras: json["extras"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "numMesa": numMesa,
    "fecha": fecha,
    "empleado": empleado,
    "platillo": platillo,
    "anotaciones": anotaciones,
    "codigo": codigo,
    "estado": estado,
    "extras": extras,
  };
}