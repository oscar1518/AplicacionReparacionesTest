class AllReparaciones {
  String reparacion;
  String nombre;

  bool? isSelected;

  AllReparaciones(
    {
      required this.reparacion, 
      required this.nombre,
      this.isSelected
    });

  factory AllReparaciones.fromJson(Map<String, dynamic> json) =>
  AllReparaciones (
    reparacion : json['id'],
    nombre : json['nombre'],
    );

  Map<String, dynamic> toJson() => 
  { 'id' : reparacion, 'nombre' : nombre};
}