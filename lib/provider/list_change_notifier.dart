import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:mceasy/db/sqlite_usuario_respository.dart';
import 'package:mceasy/model/karyawan_model.dart';


class ListChangeNotifier extends ChangeNotifier {
  List<KaryawanModel> listKaryawan = [];
  bool loading = false;
  int tabIndex = 0;

  final SqliteUsuarioRepository SqliteRepository =
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

  void setKaryawan(List<KaryawanModel> karyawans) {
    listKaryawan = karyawans;
    notifyListeners();
  }


  Future<int> addKaryawan(KaryawanModel karyawanModel) async {
    var created = await SqliteRepository.create(karyawanModel);
    if (created > 0) setKaryawan([...listKaryawan, karyawanModel]);
    return created;
  }

  Future<int> updateKaryawan(KaryawanModel karyawanModel) async {
    var updated = await SqliteRepository.update(karyawanModel);
    if (updated > 0) {
      var index = listKaryawan.indexWhere((u) => u.no == karyawanModel.no);
      listKaryawan[index] = karyawanModel;
      var newUsuarios = [...listKaryawan];
      setKaryawan(newUsuarios);
    }
    return updated;
  }

  Future<List<KaryawanModel>> getAllUsuarios() async {
    loading = true;
    listKaryawan = [];
    var usuarioss =
         await SqliteRepository.getBy();

    setKaryawan(usuarioss);
    loading = false;
    return usuarioss;
  }

  Future<int> delete(int id) async {
    if (listKaryawan.isEmpty) {
      return 0;
    }
    var deleted = await SqliteRepository.delete(id);
    if (deleted > 0) {
      var index = listKaryawan.indexWhere((u) => u.no == id);
      listKaryawan.removeAt(index);
      var newUsuarios = [...listKaryawan];
      setKaryawan(listKaryawan);
    }
    return deleted;
  }

  Future<int> deleteAll() async {
    if (listKaryawan.isEmpty) {
      return 0;
    }
    var deleted = await SqliteRepository.deleteAll();
    if (deleted > 0) {
      listKaryawan = [];
      setKaryawan([]);
    }
    return deleted;
  }
}
