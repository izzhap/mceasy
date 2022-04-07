import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';


class FormChangeNotifier extends ChangeNotifier {
  int id = 1;
  String nama = "";
  String nomor_induk = "";
  String alamat = "";
  DateTime tanggal_lahir = DateTime.now();
  DateTime tanggal_bergabung = DateTime.now();


  bool loading = false;

  FormChangeNotifier();

  void initKaryawan(KaryawanModel karyawanModel) {
    id = karyawanModel.no ?? 1;
    nama = karyawanModel.nama;
    nomor_induk = karyawanModel.nomor_induk;
    alamat = karyawanModel.alamat;
    tanggal_lahir =
        karyawanModel.tanggal_lahir ?? DateTime(DateTime.now().year - 11);
    tanggal_bergabung =
        karyawanModel.tanggal_bergabung ?? DateTime(DateTime.now().year - 11);
  }

  void clear() {
    id = 1;
    nama = "";
    nomor_induk = "";
    alamat = "";
    tanggal_lahir = DateTime(DateTime.now().year - 10);
    tanggal_bergabung = DateTime(DateTime.now().year - 10);

  }

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }


  void changeNomorInduk(String value) {
    nomor_induk = value;
    notifyListeners();
  }

  void changeName(String value) {
    nama = value;
    notifyListeners();
  }

  void changeAlamat(String value) {
    alamat = value;
    notifyListeners();
  }

  void changeTanggalLahir(DateTime value) {
    tanggal_lahir = value;
    notifyListeners();
  }

  void changeTanggalBergabung(DateTime value) {
    tanggal_bergabung = value;
    notifyListeners();
  }
}
