import 'package:sqflite/sqflite.dart';

import 'package:mceasy/ui/usuarios/model/usuario_entity.dart';

class SqliteUsuarioRepository {
  final Database _database;
  final String _tableNameEmployee = "karyawan";
  final String _tableNameLeave = "cuti";

  SqliteUsuarioRepository(this._database);

  Future<int> create(UsuarioEntity usuarioEntity) async {
    int id = await _getLastInsertedElementId();
    usuarioEntity.id = id + 1;
    Map<String, dynamic> usuarioJson = usuarioEntity.toLocalJson();

    return _database.insert(_tableName, usuarioJson);
  }

  Future<int> _getLastInsertedElementId() async {
    List<Map<String, Object?>> allId =
        await _database.rawQuery('SELECT MAX(id) FROM $_tableName');
    int id = allId.first['MAX(id)'] as int? ?? 0;
    return id;
  }

  Future<List<UsuarioEntity>> getBy() async {
    List<Map<String, Object?>> allId =
    await _database.rawQuery('SELECT * FROM $_tableName where nombre=?', ['popo']);
    return allId
        .map((usuario) => UsuarioEntity.fromLocalJson(usuario))
        .toList();
  }

  Future<int> update(UsuarioEntity usuarioEntity) async {
    Map<String, dynamic> usuarioJson = usuarioEntity.toLocalJson();
    return _database.update(
      _tableName,
      usuarioJson,
      where: "id = ?",
      whereArgs: [usuarioEntity.id],
    );
  }

  Future<List<UsuarioEntity>> getAll() async {
    List<Map<String, Object?>> usuarios = await _database.query(_tableName);
    if (usuarios.isEmpty) {
      return [];
    }

    return usuarios
        .map((usuario) => UsuarioEntity.fromLocalJson(usuario))
        .toList();
  }

  Future<UsuarioEntity?> getOne(String id) async {
    List<Map<String, Object?>> usuarios = await _database.query(_tableName,
        where: "id = ?", whereArgs: [id], limit: 1);

    if (usuarios.isEmpty) {
      return null;
    }

    UsuarioEntity usuario = UsuarioEntity.fromLocalJson(usuarios.first);

    return usuario;
  }

  Future<int> delete(int id) {
    return _database.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() {
    return _database.delete(_tableName);
  }
}
