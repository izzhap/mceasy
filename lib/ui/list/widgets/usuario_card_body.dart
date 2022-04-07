import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mceasy/ui/usuarios/model/usuario_entity.dart';
import 'package:mceasy/ui/usuarios/presentation/form/usuario_form_change_notifier.dart';
import 'package:mceasy/ui/usuarios/presentation/form/form_page.dart';
import 'package:mceasy/ui/usuarios/presentation/list/usuario_list_change_notifier.dart';
import 'package:mceasy/shared/utils/date_format_utils.dart';

class UsuarioCardBody extends StatefulWidget {
  const UsuarioCardBody(
      {Key? key, required this.usuario, required this.isRemote})
      : super(key: key);

  final UsuarioEntity usuario;
  final bool isRemote;

  @override
  State<UsuarioCardBody> createState() => _UsuarioCardBodyState();
}

class _UsuarioCardBodyState extends State<UsuarioCardBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.usuario.avatar != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.usuario.avatar!),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Software Developer",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        TextWrap(label: "Nombre", value: widget.usuario.nombre),
        const SizedBox(height: 10),
        if (widget.usuario.fechaNacimiento != null)
          TextWrap(
            label: "Fecha de Nacimiento",
            value: DateFormatUtils.formatDate(widget.usuario.fechaNacimiento!),
          ),
        const SizedBox(height: 10),
        if (widget.usuario.sexo != null)
          TextWrap(
            label: "Sexo",
            value: widget.usuario.sexo!.toUpperCase() == "F"
                ? "Femenino"
                : "Masculino",
          ),
        const SizedBox(height: 10),
        if (widget.usuario.email != null)
          TextWrap(
            label: "Email",
            value: widget.usuario.email!,
          ),
        const SizedBox(height: 10),
        if (!widget.isRemote)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final bool? delete = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Eliminar Usuario"),
                        content: const Text(
                            "¿Está seguro que desea eliminar el usuario?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancelar"),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            child: const Text("Eliminar"),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    );

                    if (delete == true) {
                      try {
                        var deleted = await context
                            .read<UsuarioListChangeNotifier>()
                            .delete(widget.usuario.id!);
                        if (deleted < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al eliminar el usuario'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error al eliminar el usuario'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  icon: const Icon(Icons.delete),
                  label: const Text("Eliminar"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        try {
                          context
                              .read<UsuarioFormChangeNotifier>()
                              .initUsuario(widget.usuario);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al inicializar usuario/s'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        return const UsuarioFormPage(
                          edit: true,
                        );
                      }),
                    );
                    setState(() {});
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  icon: const Icon(Icons.update),
                  label: const Text("Actualizar"),
                ),
              ),
            ],
          )
      ],
    );
  }
}

class TextWrap extends StatelessWidget {
  const TextWrap({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        Text("$label: " + value),
      ],
    );
  }
}
