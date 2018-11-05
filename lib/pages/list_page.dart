import 'package:droztips/blocs/application_bloc.dart';
import 'package:droztips/blocs/bloc_provider.dart';
import 'package:droztips/models/tip.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc tipsBloc = BlocProvider.of<ApplicationBloc>(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildListView(tipsBloc),
    );
  }

  Widget _buildAppBar() {
    return new AppBar(
      elevation: 0.0,
      backgroundColor: Color.fromRGBO(102, 181, 138, 1.0),
      centerTitle: true,
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "DR. OZ TIPS",
            style: new TextStyle(
              fontSize: 15.0,
              letterSpacing: 3.5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(ApplicationBloc tipsBloc) {
    return StreamBuilder<List<Tip>>(
      stream: tipsBloc.outTipList,
      builder: (BuildContext context, AsyncSnapshot<List<Tip>> snapshot) {
        return ListView.builder(
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            if (!snapshot.hasData) {
              CircularProgressIndicator();
            }

            return Card(
              child: new ListTile(
                leading: new Image.asset(
                  snapshot.data[index].image,
                  height: 50.0,
                  width: 50.0,
                ),
                title: new Text(snapshot.data[index].title),
                subtitle: new Text("test"),
                trailing: new Column(
                  children: <Widget>[
                    new RawMaterialButton(
                      onPressed: () {
                        tipsBloc.inIndex.add(index);
                      },
                      child: new Icon(
                        snapshot.data[index].favorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Color.fromRGBO(235, 64, 107, 1.0),
                        size: 18.0,
                      ),
                      shape: new CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
