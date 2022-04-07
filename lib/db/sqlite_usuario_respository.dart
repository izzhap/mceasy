import 'package:mceasy/model/karyawan_model.dart';
import 'package:sqflite/sqflite.dart';


class SqliteUsuarioRepository {
  final Database _database;
  final String _tableNameEmployee = "karyawan";
  final String _tableNameLeave = "cuti";

  SqliteUsuarioRepository(this._database);

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

  Future<List<KaryawanModel>> getBy() async {
    List<Map<String, Object?>> allId =
    await _database.rawQuery('SELECT * FROM $_tableNameEmployee');
    //await _database.rawQuery('SELECT * FROM $_tableNameEmployee where nama=?', ['popo']);
    return allId
        .map((karyawan) => KaryawanModel.fromLocalJson(karyawan))
        .toList();
  }

  Future<int> update(KaryawanModel karyawanModel) async {
    Map<String, dynamic> usuarioJson = karyawanModel.toLocalJson();
    return _database.update(
      _tableNameEmployee,
      usuarioJson,
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

  Future<KaryawanModel?> getOne(String id) async {
    List<Map<String, Object?>> karyawan = await _database.query(_tableNameEmployee,
        where: "no = ?", whereArgs: [id], limit: 1);

    if (karyawan.isEmpty) {
      return null;
    }

    KaryawanModel usuario = KaryawanModel.fromLocalJson(karyawan.first);

    return usuario;
  }

  Future<int> delete(int id) {
    return _database.delete(_tableNameEmployee, where: "no = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() {
    return _database.delete(_tableNameEmployee);
  }
}
