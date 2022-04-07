import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';


class FormChangeNotifier extends ChangeNotifier {
  final List<String> sexos = ["Femenino", "Masculino"];

  int id = 1;
  String nama = "";
  String nomor_induk = "";
  String alamat = "";
  DateTime tanggal_lahir = DateTime.now();

  bool loading = false;

  FormChangeNotifier();

  void initUsuario(KaryawanModel usuarioEntity) {
    id = usuarioEntity.no ?? 1;
    nama = usuarioEntity.nama;
    alamat = usuarioEntity.alamat;
    tanggal_lahir =
        usuarioEntity.tanggal_lahir ?? DateTime(DateTime.now().year - 11);
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


  void changeNombre(String value) {
    nama = value;
    notifyListeners();
  }

  void changeFechaNacimiento(DateTime value) {
    tanggal_lahir = value;
    notifyListeners();
  }
}
