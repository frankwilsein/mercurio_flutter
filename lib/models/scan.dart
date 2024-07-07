import 'dart:convert';

class Scan {
    List<String> ?codigo;
    List<String> ?contenido;
    List<String> ?emisor;
    List<String> ?firma;
    List<String> ?lugarfecha;
    List<String> ?receptor;

    Scan({
        required this.codigo,
        required this.contenido,
        required this.emisor,
        required this.firma,
        required this.lugarfecha,
        required this.receptor,
    });

    factory Scan.fromJson(String str) => Scan.fromMap(json.decode(str));

  get length => null;

    String toJson() => json.encode(toMap(String));

    factory Scan.fromMap(Map<String, dynamic> json) => Scan(
        codigo: List<String>.from(json["CODIGO"].map((x) => x)),
        contenido: List<String>.from(json["CONTENIDO"].map((x) => x)),
        emisor: List<String>.from(json["EMISOR"].map((x) => x)),
        firma: List<String>.from(json["FIRMA"].map((x) => x)),
        lugarfecha: List<String>.from(json["LUGARFECHA"].map((x) => x)),
        receptor: List<String>.from(json["RECEPTOR"].map((x) => x)),
    );

    Map<String, dynamic> toMap(data) => {
        "CODIGO": List<dynamic>.from(codigo!.map((x) => x)),
        "CONTENIDO": List<dynamic>.from(contenido!.map((x) => x)),
        "EMISOR": List<dynamic>.from(emisor!.map((x) => x)),
        "FIRMA": List<dynamic>.from(firma!.map((x) => x)),
        "LUGARFECHA": List<dynamic>.from(lugarfecha!.map((x) => x)),
        "RECEPTOR": List<dynamic>.from(receptor!.map((x) => x)),
    };
   /* Map<String, dynamic> toList(data) =>{
        codigo: codigo?.join(" "),
        Scontenido: List<String>.from(json["CONTENIDO"].map((x) => x)),
        Semisor: List<String>.from(json["EMISOR"].map((x) => x)),
        Sfirma: List<String>.from(json["FIRMA"].map((x) => x)),
        Slugarfecha: List<String>.from(json["LUGARFECHA"].map((x) => x)),
        Sreceptor: List<String>.from(json["RECEPTOR"].map((x) => x)),
    };*/ 
}

/*
class Scan {
  Scan(
      {//required this.available,
      required this.LUGARFECHA,
      required this.RECEPTOR,
      required this.EMISOR,
      required this.CODIGO,
      required this.CONTENIDO,
      required this.FIRMA,
      this.picture,
      this.id});

  //bool available;
  List<String> LUGARFECHA;
  List<String>? RECEPTOR;
  List<String>? EMISOR;
  List<String> CODIGO;
  List<String>? CONTENIDO;
  List<String>? FIRMA;
  List<String>? picture;
  List<String>? id;

  factory Scan.fromJson(String str) => Scan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Scan.fromMap(Map<String, dynamic> json) => Scan(
        //available: json["available"],
        LUGARFECHA: json["LUGARFECHA"],
        RECEPTOR: json["RECEPTOR"],
        EMISOR: json["EMISOR"],
        CODIGO: json["CODIGO"],
        CONTENIDO: json["CONTENIDO"],
        FIRMA: json["FIRMA"],
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        //"available": available,
        "LUGARFECHA": LUGARFECHA,
        "RECEPTOR": RECEPTOR,
        "EMISOR": EMISOR,
        "CODIGO": CODIGO,
        "CONTENIDO": CONTENIDO,
        "FIRMA": FIRMA,
        "picture": picture,
      };

  Scan copy() => Scan(
     // available: this.available,
      LUGARFECHA: this.LUGARFECHA,
      RECEPTOR: this.RECEPTOR,
      EMISOR: this.EMISOR,
      CODIGO: this.CODIGO,
      CONTENIDO: this.CONTENIDO,
      FIRMA: this.FIRMA,
      picture: this.picture,
      id: this.id);
}*/
