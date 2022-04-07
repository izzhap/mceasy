import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';


class FormChangeNotifier extends ChangeNotifier {
  int id = 1;
  String nama = "";
  String nomor_induk = "";
  String alamat = "";
  DateTime tanggal_lahir = DateTime.now();

  bool loading = false;

  FormChangeNotifier();

  void initKaryawan(KaryawanModel karyawanModel) {
    id = karyawanModel.no ?? 1;
    nama = karyawanModel.nama;
    alamat = karyawanModel.alamat;
    tanggal_lahir =
        karyawanModel.tanggal_lahir ?? DateTime(DateTime.now().year - 11);
  }

  void clear() {
    id = 1;
    nama = "";
    tanggal_lahir = DateTime(DateTime.now().year - 10);
  }

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }


  void changeName(String value) {
    nama = value;
    notifyListeners();
  }

  void changeTanggalLahir(DateTime value) {
    tanggal_lahir = value;
    notifyListeners();
  }
}
