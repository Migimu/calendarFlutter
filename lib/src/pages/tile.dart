import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Tile extends StatefulWidget {
  Tile({Key key, @required this.index}) : super(key: key);
  final int index;

  @override
  _TileState createState() => _TileState(index);
}

class _TileState extends State<Tile> {
  int index;
  _TileState(int index) {
    this.index = index;
  }

  //_TileState(int index);
  String departamento = "";
  String profesor = "";
  String notasAdicionales = "";
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool hasBeenPressed = false;
  Color colorNuevo;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: pickerColor,
          /*border: Border.all(
            color: Colors.black,
            width: 1,
          ),*/
        ),
        width: 70.0,
        height: 70.0,
        child: Column(
          children: [
            Text(departamento),
            Text(profesor),
            Text(notasAdicionales)
          ],
        ),
      ),
      onTap: () {
        void changeColor(Color color) {
          print(color == "MaterialColor(primary value: Color(0xff2196f3)");
          setState(() => pickerColor = color);
        }

        var column = ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Nombre departamento", /* border: InputBorder.none*/
              ),
              controller: field1Controller,
            ),
            Divider(
              height: 10,
              thickness: 10,
              color: Colors.white70,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Profesor ", /*border: InputBorder.none*/
              ),
              controller: field2Controller,
            ),
            Divider(
              height: 10,
              thickness: 10,
              color: Colors.white70,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Notas adicionales", /*border: InputBorder.none*/
              ),
              controller: field3Controller,
            ),
            Divider(
              height: 10,
              thickness: 10,
              color: Colors.white70,
            ),
            Container(
              child: BlockPicker(
                pickerColor: currentColor,
                onColorChanged: (color) => colorNuevo = color,
              ),
              height: 270,
            ),
            FlatButton(
                child: Text("Dos horas?"),
                //color: hasBeenPressed ? Colors.green[200] : Colors.red[300],
                onPressed: () => {
                      setState(() {
                        hasBeenPressed = !hasBeenPressed;
                        print(hasBeenPressed);
                        this.currentColor = Colors.green[200];
                      })
                    }),
            FlatButton(
              child: Text("Save"),
              color: Colors.amber[300],
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  departamento = field1Controller.text;
                });
                setState(() {
                  profesor = field2Controller.text;
                });
                setState(() {
                  notasAdicionales = field3Controller.text;
                });
                pickerColor = colorNuevo;
                /*setState(() {
                  StaggeredTile.count(index, index + 8);
                });*/
                print(field1Controller.text);
                print(field2Controller.text);
                print(field3Controller.text);
                print(index);
                print(index + 8);
              },
            )
          ],
        );

        showDialog(
            child: Dialog(
              child: column,
            ),
            context: context);
        //print(this.index);
      },
    ));
  }
}

class TileHora extends StatelessWidget {
  const TileHora({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.green[400],
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          width: 60.0,
          height: 70.0,
          child: Center(child: Text(this.title))),
    );
  }
}

class TileDia extends StatelessWidget {
  const TileDia({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.green[400],
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          width: 60.0,
          height: 50.0,
          child: Center(child: Text(this.title))),
    );
  }
}
