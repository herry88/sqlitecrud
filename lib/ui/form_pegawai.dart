import 'package:flutter/material.dart';
import 'package:sqlitecrud/model/model_pegawai.dart';
import 'package:sqlitecrud/helper/db_helper.dart';

class FormPegawai extends StatefulWidget {
  //ini ditambah
  final ModelPegawai modelPegawai;
  FormPegawai(this.modelPegawai);
  //sampai sini

  @override
  _FormPegawaiState createState() => _FormPegawaiState();
}

class _FormPegawaiState extends State<FormPegawai> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _firstNameController;
  TextEditingController _secondNameController;
  TextEditingController _mobileNoController;
  TextEditingController _emailidController;

  //ctrl + o cari initsate enter
  @override
  void initState() {
    super.initState();
    _firstNameController =
    new TextEditingController(text: widget.modelPegawai.firstName);
    _secondNameController =
    new TextEditingController(text: widget.modelPegawai.secondName);
    _mobileNoController =
    new TextEditingController(text: widget.modelPegawai.mobileNo);
    _emailidController =
    new TextEditingController(text: widget.modelPegawai.emailId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Form Pegawai'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: new Column(
            children: <Widget>[
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'FirstName'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              TextField(
                controller: _secondNameController,
                decoration: InputDecoration(labelText: 'SecondName'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              TextField(
                controller: _mobileNoController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
              Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              TextField(
                controller: _emailidController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              RaisedButton(
                child: (widget.modelPegawai.id != null)
                    ? Text('Update')
                    : Text('Add'),
                onPressed: () {
                  if (widget.modelPegawai.id != null) {
                    db
                        .updatePegawai(ModelPegawai.fromMap({
                      'id': widget.modelPegawai.id,
                      'firstname': _firstNameController.text,
                      'secondname': _secondNameController.text,
                      'mobileno': _mobileNoController.text,
                      'emailid': _emailidController.text
                    }))
                        .then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db.savePegawai(ModelPegawai(_firstNameController.text,
                        _secondNameController.text,
                        _mobileNoController.text,
                        _emailidController.text)).then((_) {
                      Navigator.pop(context, 'save');
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}