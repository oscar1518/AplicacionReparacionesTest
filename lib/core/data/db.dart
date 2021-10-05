import 'package:app_reparaciones/core/enums/view_state.dart';
import 'package:app_reparaciones/core/models/all_reparaciones.dart';
import 'package:app_reparaciones/core/viewmodels/base_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB extends BaseModel{

  Future<Database> _openDB() async {

    return openDatabase(join(await getDatabasesPath(), 'reparaciones.db'),
    onCreate: (db, version){
      return db.execute("Create table reparaciones (id TEXT PRIMARY KEY, nombre TEXT)");
    }, version: 1);
  }

  Future<List<AllReparaciones>> getAllReparacionesFromDBL() async{
    Database database = await _openDB();
    final List<Map<String, dynamic>> reparacionesMap = await database.query('reparaciones');

    return List.generate(reparacionesMap.length, (index) => AllReparaciones(reparacion: reparacionesMap[index]['id'], nombre: reparacionesMap[index]['nombre']));
  }

  Future<void> insertReparacion(AllReparaciones reparaciones) async {
    Database database = await _openDB();

    database.insert("reparaciones", reparaciones.toJson());
  }

  Future<void> deleteReparaciones() async {
    Database database = await _openDB();

    database.delete('reparaciones');
  }

  Future<void> deleteReparacionesById(AllReparaciones reparaciones) async {
    Database database = await _openDB();

    database.delete('reparaciones', where: 'id = ?', whereArgs: [reparaciones.reparacion]);


  }

    Future<bool> comprobarReparacionesExistentes() async{

    setState(ViewState.Busy);

    bool dbVacia;

    Database database = await _openDB();
    final List<Map<String, dynamic>> reparacionesMap = await database.query('reparaciones');

    List<AllReparaciones> reparacionesExistentes = List.generate(reparacionesMap.length, (index) => AllReparaciones(reparacion: reparacionesMap[index]['id'], nombre: reparacionesMap[index]['nombre']));

    if (reparacionesExistentes.isEmpty){
      dbVacia = true;
    } else{
      dbVacia = false;
    }
    
    setState(ViewState.Idle);

    return  dbVacia;
  }

}