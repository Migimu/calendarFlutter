import 'dart:convert';

import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchHoras() async {
  final response = await http.get('https://api.apispreadsheets.com/data/2912/');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body)['data'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class GridViews extends StatefulWidget {
  GridViews({Key key}) : super(key: key);

  @override
  _GridViewsState createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
  Future<List<dynamic>> listaHoras;

  @override
  void initState() {
    super.initState();
    listaHoras = fetchHoras();
  }

  List<StaggeredTile> _staggeredTiles() {
    List<StaggeredTile> lista = [];
    for (var i = 0; i <= 45; i++) {
      if (i == 20) {
        lista.add(const StaggeredTile.count(5, 1));
      }
      lista.add(const StaggeredTile.count(1, 1));
    }
    return lista;
  }

  List<Widget> _tiles(
    AsyncSnapshot snapshot,
  ) {
    List<Widget> lista = [];
    int x = 0, y = 0;
    for (var index = 0; index <= 45; index++) {
      List dias = ['L', 'M', 'X', 'J', 'V'];

      var data;

      if (y < 5) {
        if (x != 4) {
          data = snapshot.data[x][dias[y]];
        }
        y++;
        print('$y');
      } else {
        y = 0;
        x++;
        if (x != 4) {
          data = snapshot.data[x][dias[y]];
          y++;
        }
        print('$y');
      }

      if (x == 4) {
        //index = 20;
      }
      print('X: $x Y: $y DATA: $data INDEX: $index');

      if (index == 21) {
        lista.add(Container(
          child: Center(
            child: Container(
              child: Text('Patio'),
            ),
          ),
          color: Colors.amber[200],
        ));
      }
      if (x != 4) {
        lista.add(Center(
            child: Tile(
          index: index,
          datosDias: data,
        )));
      }
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listaHoras,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return StaggeredGridView.count(
                shrinkWrap: true,
                crossAxisCount: 5,
                primary: true,
                physics: new NeverScrollableScrollPhysics(),
                staggeredTiles: _staggeredTiles(),
                children: _tiles(snapshot));
          }
          return Column(children: [Center(child: CircularProgressIndicator())]);
        });
  }
}
