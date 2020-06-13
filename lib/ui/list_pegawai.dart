import 'package:flutter/material.dart';
import 'package:sqlitecrud/helper/db_helper.dart';
import 'package:sqlitecrud/ui/form_pegawai.dart';
import 'package:sqlitecrud/model/model_pegawai.dart';

class ListPegawai extends StatefulWidget {
  @override
  _ListPegawaiState createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  List<ModelPegawai> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getAllPegawai().then((pegawais) {
      setState(() {
        pegawais.forEach((pegawai) {
          items.add(ModelPegawai.fromMap(pegawai));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Pegawai',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Data Pegawai Apps'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return new Column(
                  children: <Widget>[
                    Divider(
                      height: 5.0,
                    ),
                    ListTile(
                      title: new Text(
                        '${items[position].emailId}',
                        style: new TextStyle(
                            fontSize: 22.0, color: Colors.deepOrangeAccent),
                      ),
                      subtitle: SingleChildScrollView(
                        child: new Text(
                          '${items[position].firstName}',
                          style: new TextStyle(
                              fontSize: 18.0, fontStyle: FontStyle.italic),
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 15.0,
                            child: new Text(
                              '${items[position].id}',
                              style: new TextStyle(
                                  fontSize: 22.0, color: Colors.white),
                            ),
                          ),
                          new IconButton(icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () =>_deletePegawai(context, items[position], position),
                          )
                        ],
                      ),
                      onTap: () => _navigateToPegawai(context, items[position]),
                    )
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewPegawai(context),
        ),
      ),
    );
  }

//save
  void _createNewPegawai(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FormPegawai(ModelPegawai('', '', '', ''))),
    );
    if (result == 'save') {
      db.getAllPegawai().then((pegawais) {
        setState(() {
          items.clear();
          pegawais.forEach((pegawai) {
            items.add(ModelPegawai.fromMap(pegawai));
          });
        });
      });
    }
  }

//  //untuk delete
  void _deletePegawai(
      BuildContext context, ModelPegawai pegawai, int position) async {
    db.deletePegawai(pegawai.id).then((pegawais) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

//update
  void _navigateToPegawai(BuildContext context, ModelPegawai pegawai) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormPegawai(pegawai)),
    );
    if (result == 'update') {
      db.getAllPegawai().then((pegawais) {
        setState(() {
          items.clear();
          pegawais.forEach((pegawai) {
            items.add(ModelPegawai.fromMap(pegawai));
          });
        });
      });
    }
  }

}
