import 'package:flutter/material.dart';

import 'package:mceasy/ui/usuarios/model/usuario_entity.dart';

class UsuarioFormChangeNotifier extends ChangeNotifier {
  final List<String> sexos = ["Femenino", "Masculino"];

  int id = 1;
  String nombre = "";
  String selectedSexo = "Femenino";
  DateTime fechaNacimiento = DateTime.now();

  bool loading = false;

  UsuarioFormChangeNotifier();

  void initUsuario(UsuarioEntity usuarioEntity) {
    id = usuarioEntity.id ?? 1;
    nombre = usuarioEntity.nombre;
    selectedSexo = sexos
        .where(
            (String element) => element.startsWith(usuarioEntity.sexo ?? "F"))
        .first;
    fechaNacimiento =
        usuarioEntity.fechaNacimiento ?? DateTime(DateTime.now().year - 11);
  }

  void clear() {
    id = 1;
    nombre = "";
    selectedSexo = "Femenino";
    fechaNacimiento = DateTime(DateTime.now().year - 10);
  }

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void changeSexo(String? value) {
    selectedSexo = value ?? "Femenino";
    notifyListeners();
  }

  void changeNombre(String value) {
    nombre = value;
    notifyListeners();
  }

  void changeFechaNacimiento(DateTime value) {
    fechaNacimiento = value;
    notifyListeners();
  }

  String extractFirstLetterSelectedSexo() {
    return selectedSexo.substring(0, 1);
  }
}
