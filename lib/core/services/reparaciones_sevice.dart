import 'dart:convert';
import 'package:app_reparaciones/core/models/all_reparaciones.dart';
import 'package:http/http.dart' as http;

class ReparacionesService {

  // MÉTODO PARA OBTENER TODAS LAS REPARACIONES 
  Future<List<AllReparaciones>> getAllReparaciones() async {
    List<AllReparaciones> reparaciones = [];

    try{
      Uri url = Uri.parse('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var reparacionesJson = json.decode(response.body);
        for (var reparacionJson in reparacionesJson) {
          reparaciones.add(AllReparaciones.fromJson(reparacionJson));
        }
      } else {
        print("ERROR DE CONEXIÓN");
      }
    }catch (ex){
      print("Error de conexión en getAllReparaciones");
    }
    return reparaciones;
  }


}