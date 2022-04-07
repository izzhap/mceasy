import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:mceasy/db/sqlite_respository.dart';
import 'package:mceasy/model/cuti_model.dart';
import 'package:mceasy/model/karyawan_model.dart';


class ListChangeNotifier extends ChangeNotifier {
  List<KaryawanModel> listKaryawan = [];
  List<CutiModel> listCuti = [];
  bool loading = false;
  int tabIndex = 0;

  final SqliteRepository sqliteRepository =
      GetIt.I<SqliteRepository>();

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

  void setCuti(List<CutiModel> cutis) {
    listCuti = cutis;
    notifyListeners();
  }


  Future<int> addKaryawan(KaryawanModel karyawanModel) async {
    var created = await sqliteRepository.create(karyawanModel);
    if (created > 0) setKaryawan([...listKaryawan, karyawanModel]);
    return created;
  }


  Future<int> updateKaryawan(KaryawanModel karyawanModel) async {
    var updated = await sqliteRepository.update(karyawanModel);
    if (updated > 0) {
      var index = listKaryawan.indexWhere((u) => u.no == karyawanModel.no);
      listKaryawan[index] = karyawanModel;
      var newKar = [...listKaryawan];
      setKaryawan(newKar);
    }
    return updated;
  }


  Future<List<KaryawanModel>> getAllFilter(int pos) async {
    loading = true;
    listKaryawan = [];
    var data =
         await sqliteRepository.getAllFilter(pos);

    setKaryawan(data);
    loading = false;
    return data;
  }

  Future<List<CutiModel>> getAllFilterCuti(int pos) async {
    listCuti = [];
    var data =
    await sqliteRepository.getAllFilterCuti(pos);

    setCuti(data);
    loading = false;
    return data;
  }

  Future<int> delete(int id) async {
    if (listKaryawan.isEmpty) {
      return 0;
    }
    var deleted = await sqliteRepository.delete(id);
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
    var deleted = await sqliteRepository.deleteAll();
    if (deleted > 0) {
      listKaryawan = [];
      setKaryawan([]);
    }
    return deleted;
  }
}
