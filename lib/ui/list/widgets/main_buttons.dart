import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mceasy/ui/usuarios/presentation/form/form_page.dart';
import 'package:mceasy/ui/usuarios/presentation/list/usuario_list_change_notifier.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          key: const Key('btn_delete'),
          heroTag: "btn_delete",
          backgroundColor: Colors.red,
          onPressed: () {
            _deleteAllUsers(context);
          },
          child: const Icon(Icons.delete_forever_outlined),
        ),
        const SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          heroTag: "btn_add",
          key: const Key('btn_add'),
          onPressed: () {
            _navToForm(context);
          },
          child: const Icon(Icons.add_outlined),
        ),
      ],
    );
  }

  void _deleteAllUsers(BuildContext context) {
    if (context.read<UsuarioListChangeNotifier>().usuarios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay usuarios para eliminar'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Está seguro?'),
        content:
            const Text('¿Está seguro que desea eliminar todos los usuarios?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              Navigator.of(context).pop();
              try {
                context.read<UsuarioListChangeNotifier>().deleteAll();
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al eliminar los usuarios'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _navToForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsuarioFormPage(
          edit: false,
        ),
      ),
    );
  }
}
