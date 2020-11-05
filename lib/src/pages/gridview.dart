import 'dart:convert';

import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class GridViews extends StatelessWidget {
  const GridViews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<StaggeredTile> _staggeredTiles() {
      List<StaggeredTile> lista = [];
      for (var i = 0; i < 45; i++) {
        lista.add(const StaggeredTile.count(1, 1));
      }
      return lista;
    }

    fetchHoras();
    return StaggeredGridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      primary: true,
      physics: new NeverScrollableScrollPhysics(),
      staggeredTiles: _staggeredTiles(),
      children: List.generate(45, (index) {
        if (index >= 20 && index <= 24) {
          return Center(
              child: Container(
            child: Text('data'),
          ));
        }
        return Center(
            child: Tile(
          index: index,
        ));
      }),
    );
  }

  Future<List<dynamic>> fetchHoras() async {
    //print(http.get('https://api.apispreadsheets.com/data/2912/'));
    final response =
        await http.get('https://api.apispreadsheets.com/data/2912/');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var data = jsonDecode(response.body)['data'];
      var reversed = data[1].map((k, v) => MapEntry(v, k));
      print(reversed[0]);
      return jsonDecode(response.body)['data'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
