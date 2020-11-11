import 'dart:convert';

import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class GridViews extends StatefulWidget {
  const GridViews({Key key}) : super(key: key);

  @override
  _GridViewsState createState() => _GridViewsState();
}

class _GridViewsState extends State<GridViews> {
  Future<List<dynamic>> listaHoras = null;
  @override
  void initState() {
    super.initState();
    listaHoras = fetchHoras();
  }

  @override
  Widget build(BuildContext context) {
    List<StaggeredTile> _staggeredTiles(AsyncSnapshot snapshot) {
      int x = 0, y = -1;
      List dias = ['L', 'M', 'X', 'J', 'V'];
      List<StaggeredTile> lista = [];
      for (var i = 0; i <= 40; i++) {
        if (y < 4) {
          y++;
        } else {
          y = 0;
          if (i < 40) {
            x++;
          }
          if (x != 4) {}
        }
        print('X: $x Y: $y INDEX: $i');
        if (i == 20) {
          lista.add(const StaggeredTile.count(5, 1));
        }
        if (x != 4) {
          print(snapshot.data[x][dias[y]].split('|')[4] == "2");
          if (snapshot.data[x][dias[y]].split('|')[4] == "2") {
            if (x != 0 &&
                (snapshot.data[x][dias[y]] == snapshot.data[x - 1][dias[y]])) {
              lista.add(const StaggeredTile.count(1, 2));
              print("1,2");
            }
          }
          if (snapshot.data[x][dias[y]].split('|')[4] == "1" ||
              snapshot.data[x][dias[y]].split('|')[4] == "") {
            lista.add(const StaggeredTile.count(1, 1));
            print("1,1");
          }
        }
        print(snapshot.data[x][dias[y]].split('|'));
      }

      return lista;
    }

    List<Widget> _tiles(
      AsyncSnapshot snapshot,
    ) {
      List<Widget> lista = [];
      int x = 0, y = 0;
      for (var index = 0; index <= 40; index++) {
        List dias = ['L', 'M', 'X', 'J', 'V'];

        var data = null;

        if (y < 5) {
          if (x != 4) {
            data = snapshot.data[x][dias[y]];
          }
          y++;
          //print('$y');
        } else {
          y = 0;
          x++;
          if (x != 4) {
            data = snapshot.data[x][dias[y]];
            y++;
          }
          //print('$y');
        }

        if (x == 4) {
          //index = 20;
        }
        //print('X: $x Y: $y DATA: $data INDEX: $index');

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
          print('X: $x Y: $y-1 INDEX: $index');
          print(y - 1);
          if (snapshot.data[x][dias[y - 1]].split('|')[4] == "2") {
            print(snapshot.data[x][dias[y - 1]]);
            if (x != 0 &&
                (snapshot.data[x][dias[y - 1]] ==
                    snapshot.data[x - 1][dias[y - 1]])) {
              lista.add(Center(
                  child: Tile(
                index: index,
                datosDias: data,
                notifyParent: refresh,
              )));
            }
          }
          if (snapshot.data[x][dias[y - 1]].split('|')[4] == "1" ||
              snapshot.data[x][dias[y - 1]].split('|')[4] == "") {
            lista.add(Center(
                child: Tile(
              index: index,
              datosDias: data,
              notifyParent: refresh,
            )));
          }
        }
      }
      print(lista);
      return lista;
    }

    //Future<List<dynamic>> listaHoras = fetchHoras();
    return FutureBuilder(
        future: fetchHoras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int cont = 0;

            //print(snapshot.data);
            return StaggeredGridView.count(
                shrinkWrap: true,
                crossAxisCount: 5,
                primary: true,
                physics: new NeverScrollableScrollPhysics(),
                staggeredTiles: _staggeredTiles(snapshot),
                children: _tiles(snapshot));
          }
          return Column(children: [Center(child: CircularProgressIndicator())]);
        });
  }

  refresh() {
    setState(() {});
  }

  Future<List<dynamic>> fetchHoras() async {
    final response =
        await http.get('https://api.apispreadsheets.com/data/2912/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body)['data'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}
