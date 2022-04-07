import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:mceasy/db/sqlite_usuario_respository.dart';
import 'package:mceasy/model/karyawan_model.dart';


class ListChangeNotifier extends ChangeNotifier {
  List<KaryawanModel> usuarios = [];
  List<KaryawanModel> usuariosRemote = [];
  bool loading = false;
  int tabIndex = 0;

  final SqliteUsuarioRepository usuarioSqliteRepository =
      GetIt.I<SqliteUsuarioRepository>();

  ListChangeNotifier();

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setTabIndex(int value) {
    tabIndex = value;
    notifyListeners();
  }

  void setUsuarios(List<KaryawanModel> usuarioss) {
    usuarios = usuarioss;
    notifyListeners();
  }

  void setUsuariosRemote(List<KaryawanModel> usuarioss) {
    usuariosRemote = usuarioss;
    notifyListeners();
  }

  Future<int> addUsuario(KaryawanModel usuario) async {
    var created = await usuarioSqliteRepository.create(usuario);
    if (created > 0) setUsuarios([...usuarios, usuario]);
    return created;
  }

  Future<int> updateUsuario(KaryawanModel usuario) async {
    var updated = await usuarioSqliteRepository.update(usuario);
    if (updated > 0) {
      var index = usuarios.indexWhere((u) => u.no == usuario.no);
      usuarios[index] = usuario;
      var newUsuarios = [...usuarios];
      setUsuarios(newUsuarios);
    }
    return updated;
  }

  Future<List<KaryawanModel>> getAllUsuarios({required bool isRemote}) async {
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

  Future<KaryawanModel?> getOneUsuario(String id) async {
    var usuario = await usuarioSqliteRepository.getOne(id);
    return usuario;
  }

  Future<int> delete(int id) async {
    if (usuarios.isEmpty) {
      return 0;
    }
    var deleted = await usuarioSqliteRepository.delete(id);
    if (deleted > 0) {
      var index = usuarios.indexWhere((u) => u.no == id);
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
