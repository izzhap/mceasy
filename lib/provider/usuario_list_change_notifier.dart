import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'package:mceasy/ui/usuarios/model/usuario_entity.dart';
import 'package:mceasy/ui/usuarios/db/sqlite_usuario_respository.dart';

class UsuarioListChangeNotifier extends ChangeNotifier {
  List<UsuarioEntity> usuarios = [];
  List<UsuarioEntity> usuariosRemote = [];
  bool loading = false;
  int tabIndex = 0;

  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();

  UsuarioListChangeNotifier();

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setTabIndex(int value) {
    tabIndex = value;
    notifyListeners();
  }

  void setUsuarios(List<UsuarioEntity> usuarioss) {
    usuarios = usuarioss;
    notifyListeners();
  }

  void setUsuariosRemote(List<UsuarioEntity> usuarioss) {
    usuariosRemote = usuarioss;
    notifyListeners();
  }

  Future<int> addUsuario(UsuarioEntity usuario) async {
    var created = await usuarioSqliteRepository.create(usuario);
    if (created > 0) setUsuarios([...usuarios, usuario]);
    return created;
  }

  Future<int> updateUsuario(UsuarioEntity usuario) async {
    var updated = await usuarioSqliteRepository.update(usuario);
    if (updated > 0) {
      var index = usuarios.indexWhere((u) => u.id == usuario.id);
      usuarios[index] = usuario;
      var newUsuarios = [...usuarios];
      setUsuarios(newUsuarios);
    }
    return updated;
  }

  Future<List<UsuarioEntity>> getAllUsuarios({required bool isRemote}) async {
    loading = true;
    if (isRemote) {
      usuariosRemote = [];
    } else {
      usuarios = [];
    }
    var usuarioss =
         await usuarioSqliteRepository.getBy();
    if (isRemote) {
      setUsuariosRemote(usuarioss);
    } else {
      setUsuarios(usuarioss);
    }
    loading = false;
    return usuarioss;
  }

  Future<UsuarioEntity?> getOneUsuario(String id) async {
    var usuario = await usuarioSqliteRepository.getOne(id);
    return usuario;
  }

  Future<int> delete(int id) async {
    if (usuarios.isEmpty) {
      return 0;
    }
    var deleted = await usuarioSqliteRepository.delete(id);
    if (deleted > 0) {
      var index = usuarios.indexWhere((u) => u.id == id);
      usuarios.removeAt(index);
      var newUsuarios = [...usuarios];
      setUsuarios(newUsuarios);
    }
    return deleted;
  }

  Future<int> deleteAll() async {
    if (usuarios.isEmpty) {
      return 0;
    }
    var deleted = await usuarioSqliteRepository.deleteAll();
    if (deleted > 0) {
      usuarios = [];
      setUsuarios([]);
    }
    return deleted;
  }
}
