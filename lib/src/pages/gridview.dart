import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

    return StaggeredGridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      primary: true,
      physics: new NeverScrollableScrollPhysics(),
      staggeredTiles: _staggeredTiles(),
      children: List.generate(45, (index) {
        return Center(
            child: Tile(
          index: index,
        ));
      }),
    );
  }
}
