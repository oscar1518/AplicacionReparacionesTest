import 'package:app_reparaciones/routes/routes.dart';
import 'package:flutter/material.dart';
import 'locator.dart';
 
void main() {
  setupLocator();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}