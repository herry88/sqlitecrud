class ModelPegawai{
  //Declaration Variable
  int _id;
  String _firstName, _secondName, _mobileNo, _emailId;

  ModelPegawai(this._firstName, this._secondName, this._mobileNo, this._emailId);

  //map model Pegawai
  ModelPegawai.map(dynamic obj){
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    this._secondName = obj['secondName'];
    this._mobileNo  = obj['mobileNo'];
    this._emailId = obj['emailId'];
  }

  //get Variable
  int get id => _id;
  String get firstName => _firstName;
  String get secondName => _secondName;
  String get mobileNo => _mobileNo;
  String get emailId => _emailId;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['secondName'] = _secondName;
    map['mobileNo'] = _mobileNo;
    map['emailId'] = _emailId;
    return map;
  }

  ModelPegawai.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._secondName = map['secondName'];
    this._mobileNo = map['mobileNo'];
    this._emailId = map['emailId'];
  }
}