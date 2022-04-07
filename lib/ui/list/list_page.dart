import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mceasy/ui/usuarios/presentation/list/usuario_list_change_notifier.dart';
import 'package:mceasy/ui/usuarios/presentation/list/widgets/main_buttons.dart';
import 'package:mceasy/ui/usuarios/presentation/list/widgets/usuario_list.dart';

class UsuarioListPage extends StatelessWidget {
  const UsuarioListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Usuarios'),
          leading: SizedBox.fromSize(),
          centerTitle: true,
        ),
        floatingActionButton:
            context.watch<UsuarioListChangeNotifier>().tabIndex == 1
                ? null
                : const MainButtons(),
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: context.watch<UsuarioListChangeNotifier>().tabIndex,
                children: [
                  const UsuarioList(
                    isRemote: false,
                  ),
                  RefreshIndicator(
                    onRefresh: () {
                      try {
                        return context
                            .read<UsuarioListChangeNotifier>()
                            .getAllUsuarios(isRemote: true);
                      } catch (e) {
                        print(e);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al traer a los usuarios'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return Future.value();
                    },
                    child: const UsuarioList(
                      isRemote: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
