import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:mceasy/provider/form_change_notifier.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/form/form_page.dart';
import 'package:mceasy/utils/date_format_utils.dart';

import 'package:provider/provider.dart';


class CardBody extends StatefulWidget {
  const CardBody(
      {Key? key, required this.karyawanModel, required this.isRemote})
      : super(key: key);

  final KaryawanModel karyawanModel;
  final bool isRemote;

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
                    child: Icon(Icons.person)),
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
        TextWrap(label: "Nombre", value: widget.karyawanModel.nama),
        const SizedBox(height: 10),
        if (widget.karyawanModel.tanggal_lahir != null)
          TextWrap(
            label: "Fecha de Nacimiento",
            value: DateFormatUtils.formatDate(widget.karyawanModel.tanggal_lahir!),
          ),
        const SizedBox(height: 10),
        if (widget.karyawanModel.nomor_induk != null)
          TextWrap(
            label: "Email",
            value: widget.karyawanModel.nama,
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
                            .read<ListChangeNotifier>()
                            .delete(widget.karyawanModel.no!);
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
                              .read<FormChangeNotifier>()
                              .initUsuario(widget.karyawanModel);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al inicializar usuario/s'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        return const FormPage(
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
