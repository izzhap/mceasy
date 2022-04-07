import 'package:flutter/material.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/list/widgets/main_buttons.dart';
import 'package:mceasy/ui/list/widgets/usuario_list.dart';

import 'package:provider/provider.dart';


class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'List Page',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton:
          context.watch<ListChangeNotifier>().tabIndex == 1
              ? null
              : const MainButtons(),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: context.watch<ListChangeNotifier>().tabIndex,
              children: [
                const UsuarioList(
                  isRemote: false,
                ),
                RefreshIndicator(
                  onRefresh: () {
                    try {
                      return context
                          .read<ListChangeNotifier>()
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
    );
  }
}
