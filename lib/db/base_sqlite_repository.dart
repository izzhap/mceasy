import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BaseSqliteRepository {
  static final BaseSqliteRepository db = BaseSqliteRepository._();

  Database? _database;

  BaseSqliteRepository._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  Database? get instance => _database;

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mceasy.db');
    print("DB path: $path");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  //Create the table
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE karyawan(no INTEGER PRIMARY KEY, nomor_induk TEXT, nama TEXT, alamat TEXT, tanggal_lahir TEXT, tanggal_bergabung TEXT)',
    );
    await db.execute(
      'CREATE TABLE cuti(nomor_induk TEXT PRIMARY KEY, tanggal_cuti TEXT, lama_cuti INTEGER, keterangan TEXT)',
    );
  }
}
