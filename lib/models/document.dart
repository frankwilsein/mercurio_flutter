import 'dart:convert';

class Document {
  Document(
      {required this.LUGARFECHA,
      required this.RECEPTOR,
      required this.EMISOR,
      required this.CODIGO,
      required this.CONTENIDO,
      required this.FIRMA,
      this.picture,
      this.id});

  String LUGARFECHA;
  String? RECEPTOR;
  String? EMISOR;
  String CODIGO;
  String? CONTENIDO;
  String? FIRMA;
  String? picture;
  String? id;

  factory Document.fromJson(String str) => Document.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Document.fromMap(Map<String, dynamic> json) => Document(
       
        LUGARFECHA: json["LUGARFECHA"],
        RECEPTOR: json["RECEPTOR"],
        EMISOR: json["EMISOR"],
        CODIGO: json["CODIGO"],
        CONTENIDO: json["CONTENIDO"],
        FIRMA: json["FIRMA"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
      
        "LUGARFECHA": LUGARFECHA,
        "RECEPTOR": RECEPTOR,
        "EMISOR": EMISOR,
        "CODIGO": CODIGO,
        "CONTENIDO": CONTENIDO,
        "FIRMA": FIRMA,
        "picture": picture,
      };

  Document copy() => Document(

      LUGARFECHA: this.LUGARFECHA,
      RECEPTOR: this.RECEPTOR,
      EMISOR: this.EMISOR,
      CODIGO: this.CODIGO,
      CONTENIDO: this.CONTENIDO,
      FIRMA: this.FIRMA,
      picture: this.picture,
      id: this.id);
}
