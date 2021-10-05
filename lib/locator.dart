import 'package:app_reparaciones/core/data/db.dart';
import 'package:app_reparaciones/core/services/reparaciones_sevice.dart';
import 'package:get_it/get_it.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => HomeModel());
  locator.registerLazySingleton(() => ReparacionesService());
  locator.registerLazySingleton(() => DB());  
}