import 'package:app_reparaciones/core/data/db.dart';
import 'package:app_reparaciones/core/enums/view_state.dart';
import 'package:app_reparaciones/core/models/all_reparaciones.dart';
import 'package:app_reparaciones/core/services/reparaciones_sevice.dart';
import '../../locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel{

  //Variables:
  final ReparacionesService reparaciones = locator<ReparacionesService>();
  final DB db = locator<DB>();

   Future<void> getAllReparacionesFromModel() async {
    
    List<AllReparaciones> allReparaciones = [];
    bool dbVacia;

    setState(ViewState.Busy);

    allReparaciones = await reparaciones.getAllReparaciones();
    dbVacia = await db.comprobarReparacionesExistentes();

    if ( dbVacia == false){
      db.deleteReparaciones();
    } 
    for (AllReparaciones repa in allReparaciones){
      db.insertReparacion(repa);
    }  
    
    setState(ViewState.Idle);
  }

     Future<List<AllReparaciones>> extraerReparacionesBaseDatosL() async {
    
    List<AllReparaciones> allReparaciones = [];

    setState(ViewState.Busy);
    allReparaciones = await db.getAllReparacionesFromDBL();
    setState(ViewState.Idle);

    return allReparaciones;
  }
  
}