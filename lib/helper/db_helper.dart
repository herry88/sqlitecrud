import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlitecrud/model/model_pegawai.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  final String tablePegawai = 'noteTable';
  final String columnId = 'id';
  final String columnFirstName = 'firstName';
  final String columnSecondName = 'secondName';
  final String columnMobileNo = 'mobileNo';
  final String columnEmailId = 'emailId';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

//build database
  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pegawai.db');

    //await deleteDatabase
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    //buat method atas nama oncreate alt+enter
    return db;
  }

//create database
  void _onCreate(Database db, int newversion) async {
    await db
        .execute('CREATE TABLE $tablePegawai($columnId INTEGER PRIMARY KEY, '
            '$columnFirstName TEXT, '
            '$columnSecondName TEXT, '
            '$columnMobileNo TEXT, '
            '$columnEmailId TEXT)');
  }

//  ini untuk save data
  Future<int> savePegawai(ModelPegawai pegawai) async {
    var dbClient = await db;
    var result = await dbClient.insert(tablePegawai, pegawai.toMap());
    return result;
  }

//  ini untuk menampilkan data
  Future<List> getAllPegawai() async {
    var dbClient = await db;
    var result = await dbClient.query(tablePegawai, columns: [
      columnId,
      columnFirstName,
      columnSecondName,
      columnMobileNo,
      columnEmailId
    ]);
    return result.toList();
  }

//untuk count data
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FORM $tablePegawai'));
  }

  Future<int> deletePegawai(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tablePegawai, where: '$columnId = ? ', whereArgs: [id]);
  }

  Future<int> updatePegawai(ModelPegawai pegawai) async {
    var dbClient = await db;
    return await dbClient.update(tablePegawai, pegawai.toMap(),
        where: "$columnId = ?", whereArgs: [pegawai.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
