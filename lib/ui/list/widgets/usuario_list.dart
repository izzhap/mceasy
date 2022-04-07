import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mceasy/ui/usuarios/model/usuario_entity.dart';
import 'package:mceasy/ui/usuarios/presentation/list/usuario_list_change_notifier.dart';
import 'package:mceasy/ui/usuarios/presentation/list/widgets/usuario_card_body.dart';
import 'package:mceasy/shared/widgets/custom_card.dart';
import 'package:mceasy/shared/widgets/no_data.dart';

class UsuarioList extends StatefulWidget {
  const UsuarioList({Key? key, required this.isRemote}) : super(key: key);

  final bool isRemote;

  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {
  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    try {
      context
          .read<UsuarioListChangeNotifier>()
          .getAllUsuarios(isRemote: widget.isRemote);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al traer a los usuarios'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var myUsuarios = widget.isRemote
        ? context.watch<UsuarioListChangeNotifier>().usuariosRemote
        : context.watch<UsuarioListChangeNotifier>().usuarios;
    return Stack(
      children: [
        Column(
          children: [
            if (myUsuarios.isEmpty &&
                !context.watch<UsuarioListChangeNotifier>().loading)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            if (myUsuarios.isEmpty &&
                !context.watch<UsuarioListChangeNotifier>().loading)
              const NoData(label: "No Hay Usuarios"),
            if (myUsuarios.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: myUsuarios.length,
                        itemBuilder: (context, index) {
                          UsuarioEntity usuario = myUsuarios[index];
                          return Column(
                            children: [
                              CustomCard(
                                child: UsuarioCardBody(
                                  usuario: usuario,
                                  isRemote: widget.isRemote,
                                ),
                                padding: 15,
                              ),
                              if (index == myUsuarios.length - 1)
                                const SizedBox(
                                  height: 80,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        if (context.watch<UsuarioListChangeNotifier>().loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
