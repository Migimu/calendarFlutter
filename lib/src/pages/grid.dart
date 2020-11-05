import 'package:calendar/src/pages/calendar_legend.dart';
import 'package:calendar/src/pages/gridview.dart';
import 'package:calendar/src/pages/tile.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Container(
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(8),
          },
          children: [
            TableRow(children: [
              Column(children: [
                Container(
                  child: Text(""),
                  width: 50.0,
                  height: 50.0,
                )
              ]),
              Column(children: [LegendaR()]),
            ]),
            TableRow(children: [LegendaGrid(), GridViews()]),
          ],
        ),
      ),
    ]));
  }
}
