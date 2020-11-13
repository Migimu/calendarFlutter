import 'package:calendar/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Tile extends StatefulWidget {
  Tile(
      {Key key,
      @required this.index,
      @required this.datosDias,
      @required this.notifyParent,
      @required this.lista,
      @required this.posX})
      : super(key: key);
  final Function() notifyParent;
  final String index;
  final String datosDias;
  final List lista;
  final int posX;

  @override
  _TileState createState() => _TileState(index, datosDias, lista, posX);
}

class _TileState extends State<Tile> {
  String index;
  String datosDias;
  List lista;
  int posX;
  _TileState(String index, String datosDias, List lista, int posX) {
    this.index = index;
    this.datosDias = datosDias;
    this.lista = lista;
    this.posX = posX;
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
  String horas = "1";

  @override
  Widget build(BuildContext context) {
    List datos = this.datosDias.split('|');
    //print(datos.length > 1);
    if (datos != []) {
      departamento = datos[1] as String;
      field1Controller.text = datos[1] as String;
      if (datos[1] as String == '') {
        dropdownValue = 'AADD';
      } else {
        dropdownValue = datos[1] as String;
      }

      profesor = datos[0] as String;
      field2Controller.text = datos[0] as String;

      notasAdicionales = datos[2] as String;

      field3Controller.text = datos[2] as String;

      if (datos[3] != "") {
        int value = int.parse(datos[3], radix: 16);
        pickerColor = new Color(value);
        currentColor = new Color(value);
      } else {
        pickerColor = Colors.white;
        currentColor = Colors.white;
      }
    }

    double height = 0;
    if (datos[4] == "2") {
      height = 140.0;
    } else {
      height = 70.0;
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
        height: height,
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
                  horas = value ? "2" : "1";
                });
              },
              secondary: const Icon(Icons.hourglass_empty),
            ),
            FlatButton(
              child: Text("Save"),
              color: Colors.amber[300],
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    departamento = field1Controller.text;
                    profesor = field2Controller.text;
                    notasAdicionales = field3Controller.text;
                    pickerColor = colorNuevo;
                  });
                });
                //print(field1Controller.text);
                //print(field2Controller.text);
                //print(field3Controller.text);
                //print(index);
                //print(index + 8);
                String colorString = colorNuevo.toString(); // Color(0x12345678)
                String valueString = colorString.split('(0x')[1].split(')')[0];
                String datos = field2Controller.text +
                    "|" +
                    field1Controller.text +
                    "|" +
                    field3Controller.text +
                    "|" +
                    valueString +
                    "|" +
                    horas;
                updateAlbum(lista, index, datos, posX);

                Navigator.pop(context);
                //main();
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

Future<http.Response> updateAlbum(
    List listadatos, String index, String datos, int x) {
  http.get(
      "https://api.apispreadsheets.com/data/2912/?query=deletefrom2912f*'");
  print(listadatos[x]);
  listadatos[x][index] = datos;
  print(datos);
  print(listadatos);
  return http.post(
    'https://api.apispreadsheets.com/data/2912/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: convert.jsonEncode(<String, List>{'data': listadatos}),
  );
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
