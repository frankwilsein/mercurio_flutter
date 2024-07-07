

class Dates {

  String id;
  String name;
  int ?cifras;

  Dates({
    required this.id,
    required this.name,
    this.cifras
  });

  factory Dates.fromMap( Map<String, dynamic> obj ) 
    => Dates(
      id: obj['id'],
      name: obj['name'],
      cifras: obj['cifras']
    );
  


}