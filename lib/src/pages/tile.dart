import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Tile extends StatefulWidget {
  Tile(
      {Key key,
      @required this.index,
      @required this.datosDias,
      @required this.notifyParent})
      : super(key: key);
  final Function() notifyParent;
  final int index;
  final String datosDias;

  @override
  _TileState createState() => _TileState(index, datosDias);
}

class _TileState extends State<Tile> {
  int index;
  String datosDias;
  _TileState(int index, String datosDias) {
    this.index = index;
    this.datosDias = datosDias;
  }

  //_TileState(int index);
  String departamento = "";
  String profesor = "";
  String notasAdicionales = "";
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;
  bool hasBeenPressed = false;
  Color colorNuevo;

  @override
  Widget build(BuildContext context) {
    List datos = this.datosDias.split('|');
    //print(datos.length > 1);
    if (datos != []) {
      profesor = datos[1] as String;
      field2Controller.text = datos[1] as String;

      departamento = datos[0] as String;
      field1Controller.text = datos[0] as String;

      notasAdicionales = datos[2] as String;
      field3Controller.text = datos[2] as String;
    }

    return Center(
        child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: pickerColor,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: 70.0,
        height: 70.0,
        child: Column(
          children: [
            Flexible(child: Text(departamento)),
            Flexible(child: Text(profesor)),
            Flexible(child: Text(notasAdicionales))
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
                hintText: "Nombre clase", /* border: InputBorder.none*/
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
            CheckboxListTile(
              title: const Text('DOS HORAS?'),
              value: timeDilation != 1.0,
              onChanged: (bool value) {
                setState(() {
                  timeDilation = value ? 1.0 : 1.0;
                });
              },
              secondary: const Icon(Icons.hourglass_empty),
            ),
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
