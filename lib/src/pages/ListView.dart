import 'package:calendar/src/pages/grid.dart';
import 'package:flutter/material.dart';

class Vista extends StatelessWidget {
  const Vista({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          child: Grid(),
        ),
      ],
    );
  }
}
