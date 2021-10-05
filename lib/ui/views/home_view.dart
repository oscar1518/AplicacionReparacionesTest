import 'package:app_reparaciones/core/enums/view_state.dart';
import 'package:app_reparaciones/core/models/all_reparaciones.dart';
import 'package:app_reparaciones/core/viewmodels/home_model.dart';
import 'package:app_reparaciones/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  List<AllReparaciones> getReparaciones = [];
  final TextEditingController textoBuscador = TextEditingController();


 @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          children: [
            SizedBox(height: 40),
            textSearch(),
            containerList(),
            bottomOptions(model)
          ],
        ), 
      ),
    );
  }

  textSearch() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),),
            margin: EdgeInsets.fromLTRB(30,20,30,0),
            child:
              TextField(
                controller: textoBuscador,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black,),
                  hintText: 'Buscar reparación...'
                  
                ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }

  containerList() {
    return Expanded(child:Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.fromLTRB(30,20,30,20),
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(19),
            clipBehavior: Clip.hardEdge,
            child: ListView.builder(
              itemCount: getReparaciones.length,
              itemBuilder: (context, index) => 
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        for (int i = 0; i < getReparaciones.length ; i++){
                          getReparaciones[i].isSelected = false;
                        }
                        getReparaciones[index].isSelected = true;
                        setState(() {
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: 
                          getReparaciones[index].isSelected == true ?
                          Colors.black12 :
                          Colors.amber,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin:  EdgeInsets.fromLTRB(30,0,30,0),
                        child: Column(
                          children: [
                            SizedBox(height: 9),
                            Row(
                              children: [
                                SizedBox(width: 9),
                                Icon(Icons.person),
                                SizedBox(width: 9),
                                Text(getReparaciones[index].nombre)
                            ],),
                            SizedBox(height: 9)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  bottomOptions(HomeModel model) {
    return Column(
      children: [
        Row(children: [
          SizedBox(width: 30,),
          Expanded(
            child: GestureDetector(
                onTap: (){
                  // ON SELECTED ROW ... ->
                },
                child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Text(
                        'Ver Reparación',
                        style: TextStyle(color: Colors.black),
                      ),
                    SizedBox(height: 15,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: 
            model.state == ViewState.Busy
            ? Row(
              children: [
                Expanded(child: SizedBox()),
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                Expanded(child: SizedBox())
              ],
            )
            : GestureDetector(
              onTap: () async{
                await model.getAllReparacionesFromModel();
                getReparaciones = await model.extraerReparacionesBaseDatosL();
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),),
              child: Center(  
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      'Cargar reparaciones',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 30,),]
      ),
      SizedBox(height: 20,),
      ],
    );//bottomWidgets(model)
  }

}