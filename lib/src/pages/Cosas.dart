//Stateless tile

/*class Tile extends StatelessWidget {
  Tile({Key key, @required this.index}) : super(key: key);
  final int index;
  final String departamento = "";
  final String profesor = "";
  final String notasAdicionales = "";
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber[600],
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        width: 70.0,
        height: 70.0,
        child: Column(
          children: [
            Text(departamento),
            Text(profesor),
            Text(notasAdicionales)
          ],
        ),
      ),
      onTap: () {
        var column = Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Nombre departamento", /* border: InputBorder.none*/
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
            FlatButton(
              child: Text("Save"),
              color: Colors.amber[300],
              onPressed: () {
                Navigator.pop(context);
                print(field1Controller.text);
                print(field2Controller.text);
                print(field3Controller.text);
              },
            )
          ],
          mainAxisSize: MainAxisSize.values[0],
        );
        showDialog(
            child: Dialog(
              child: column,
            ),
            context: context);
        print(this.index);
      },
    ));
  }
}*/

////////////////////////////////////////////////////////////////////////////////

/*var column = Column(
          children: <Widget>[
            
          ],
          mainAxisSize: MainAxisSize.values[0],
        );*/
