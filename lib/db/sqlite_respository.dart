import 'package:mceasy/model/cuti_model.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:sqflite/sqflite.dart';


class SqliteRepository {
  final Database _database;
  final String _tableNameEmployee = "karyawan";
  final String _tableNameCuti = "cuti";

  SqliteRepository(this._database);

  Future<int> create(KaryawanModel karyawanModel) async {
    int id = await _getLastInsertedElementId();
    karyawanModel.no = id + 1;
    Map<String, dynamic> karyawanJson = karyawanModel.toLocalJson();

    return _database.insert(_tableNameEmployee, karyawanJson);
  }

  Future<int> _getLastInsertedElementId() async {
    List<Map<String, Object?>> allId =
        await _database.rawQuery('SELECT MAX(no) FROM $_tableNameEmployee');
    int id = allId.first['MAX(no)'] as int? ?? 0;
    return id;
  }

  Future<List<KaryawanModel>> getAllFilter(int pos) async {
    List<Map<String, Object?>> query = [];
    if(pos == 1){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY nama ORDER BY k.tanggal_bergabung ASC limit 3');
    }else if(pos == 2){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY nama');
    }else if(pos == 3){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY c.lama_cuti HAVING c.lama_cuti > 1');
    }else if(pos == 4){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk');
    }
    return query
        .map((karyawan) => KaryawanModel.fromLocalJson(karyawan))
        .toList();
  }

  Future<List<CutiModel>> getAllFilterCuti(int pos) async {
    List<Map<String, Object?>> query = [];
    if(pos == 1){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY nama ORDER BY k.tanggal_bergabung ASC limit 3');
    }else if(pos == 2){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY nama');
    }else if(pos == 3){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk GROUP BY c.lama_cuti HAVING c.lama_cuti > 1');
    }else if(pos == 4){
      query = await _database.rawQuery('SELECT k.*,c.tanggal_cuti, c.keterangan, c.lama_cuti  FROM $_tableNameEmployee k JOIN $_tableNameCuti c ON k.nomor_induk = c.nomor_induk');
    }
    return query
        .map((cuti) => CutiModel.fromLocalJson(cuti))
        .toList();
  }

  Future<int> update(KaryawanModel karyawanModel) async {
    Map<String, dynamic> dataJson = karyawanModel.toLocalJson();
    return _database.update(
      _tableNameEmployee,
      dataJson,
      where: "no = ?",
      whereArgs: [karyawanModel.no],
    );
  }


  Future<List<KaryawanModel>> getAll() async {
    List<Map<String, Object?>> karyawan = await _database.query(_tableNameEmployee);
    if (karyawan.isEmpty) {
      return [];
    }

    return karyawan
        .map((karyawan) => KaryawanModel.fromLocalJson(karyawan))
        .toList();
  }


  Future<int> delete(int id) {
    return _database.delete(_tableNameEmployee, where: "no = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() {
    return _database.delete(_tableNameEmployee);
  }
}
