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

  void _onCreate(Database db, int newVersion) async {
    // table karyawan
    await db.execute(
      'CREATE TABLE karyawan(no INTEGER PRIMARY KEY, nomor_induk TEXT, nama TEXT, alamat TEXT, tanggal_lahir TEXT, tanggal_bergabung TEXT)',
    );
    await db.execute(
      "INSERT INTO karyawan (no, nomor_induk, nama, alamat, tanggal_lahir, tanggal_bergabung) VALUES ('1', 'IP06001', 'Agus', 'Jln Gaja Mada no 12 Surabaya', '1980-01-11T00:00:00.000', '2005-08-07T00:00:00.000'), ('2', 'IP06002', 'Amin', 'Jln Imam Bonjol no 11, Mojokerto', '1977-09-03T00:00:00.000', '2005-08-07T00:00:00.000'), ('3', 'IP06003', 'Yusuf', 'Jln A Yani Raya 15 No 14 Malang', '1973-08-09T00:00:00.000', '2006-08-07T00:00:00.000'), ('4', 'IP06004', 'Alyssa', 'Jln Bungur Sari V no 166, Bandung', '1973-08-09T00:00:00.000', '2006-09-06T00:00:00.000'), ('5', 'IP06005', 'Maulana', 'Jln Candi Agung, No 78 Gg 5, Jakarta', '1973-08-09T00:00:00.000', '2006-09-10T00:00:00.000'), ('6', 'IP06006', 'Agfika', 'Jln Nangka, Jakarta Timur', '1973-08-09T00:00:00.000', '2007-01-02T00:00:00.000'), ('7', 'IP06007', 'James', 'Jln Merpati, 8 Surabaya', '1973-08-09T00:00:00.000', '2004-05-04T00:00:00.000'), ('8', 'IP06008', 'Octavanus', 'Jln A Yani 17, B 08 Sidoarjo', '1973-08-09T00:00:00.000', '2007-05-19T00:00:00.000'), ('9', 'IP06009', 'Nugroho', 'Jln Duren tiga 167, Jakarta Selatan', '1973-08-09T00:00:00.000', '2008-01-16T00:00:00.000'), ('10', 'IP06010', 'Raisa', 'Jln Kelapa Sawit, Jakarta Selatan', '1973-08-09T00:00:00.000', '2008-08-16T00:00:00.000')",
    );

    // table cuti
    await db.execute(
      'CREATE TABLE cuti(no INTEGER PRIMARY KEY, nomor_induk TEXT, tanggal_cuti TEXT, lama_cuti INTEGER, keterangan TEXT)',
    );
    await db.execute(
      "INSERT INTO cuti(no, nomor_induk, tanggal_cuti, lama_cuti, keterangan) VALUES ('1','IP06001', '2020-08-02T00:00:00.000', 2, 'Acara Keluarga'), ('2','IP06001', '2020-08-18T00:00:00.000', 2, 'Anak Sakit'), ('3','IP06006', '2020-08-19T00:00:00.000', 1, 'Nenek Sakit'), ('4','IP06007', '2020-08-23T00:00:00.000', 1, 'Sakit'), ('5','IP06004', '2020-08-29T00:00:00.000', 5, 'Menikah'), ('6','IP06003', '2020-08-30T00:00:00.000', 2, 'Acara Keluarga')",
    );

  }
}
