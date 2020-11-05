import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

class LegendaC extends StatelessWidget {
  const LegendaC({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TileHora(
          title: "8:00",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "8:55",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "9:50",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "10:45",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "11:40",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "12:05",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "13:00",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "13:55",
        ),
        SizedBox(height: 1),
        TileHora(
          title: "14:50",
        )
      ],
    );
  }
}

class LegendaR extends StatelessWidget {
  const LegendaR({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TileDia(
          title: "L",
        ),
        TileDia(
          title: "M",
        ),
        TileDia(
          title: "X",
        ),
        TileDia(
          title: "J",
        ),
        TileDia(
          title: "V",
        ),
      ],
    );
  }
}

class LegendaGrid extends StatelessWidget {
  const LegendaGrid({Key key}) : super(key: key);
  static const horas = [
    "8:00",
    "8:55",
    "9:50",
    "10:45",
    "11:40",
    "12:05",
    "13:00",
    "13:55",
    "14:50"
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      primary: true,
      childAspectRatio: 1.875 / 3,
      physics: new NeverScrollableScrollPhysics(),
      children: List.generate(9, (index) {
        return Center(
            child: TileHora(
          title: horas[index],
        ));
      }),
    );
  }
}
