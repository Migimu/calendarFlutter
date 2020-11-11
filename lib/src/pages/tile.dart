import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

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
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    List datos = this.datosDias.split('|');
    //print(datos.length > 1);
    if (datos != []) {
      profesor = datos[0] as String;
      field2Controller.text = datos[0] as String;

      departamento = datos[1] as String;
      field1Controller.text = datos[1] as String;
      if (datos[1] as String == '') {
        dropdownValue = 'AADD';
      } else {
        dropdownValue = datos[1] as String;
      }

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
        var column = ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['AADD', 'DI', 'SGE', 'PSP', 'PMDM']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                print(field1Controller.text);
                print(field2Controller.text);
                print(field3Controller.text);
                print(index);
                print(index + 8);
                Navigator.pop(context);
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

/*Future<http.Response> updateAlbum(String title) {
  return http.put(
    'https://jsonplaceholder.typicode.com/albums/1',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "data":
        "Horas":string"8:00"
        "L":string"Santi"
        "M":string""
        "X":string""
        "J":string""
        "V":string""

        "query":string"select*from3284whereHoras='8:00'"

    }),
  );
}*/

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
