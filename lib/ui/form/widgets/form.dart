import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:mceasy/provider/form_change_notifier.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/utils/date_format_utils.dart';

import 'package:provider/provider.dart';

class WForm extends StatefulWidget {
  const WForm({Key? key, required this.edit}) : super(key: key);
  final bool edit;
  @override
  State<WForm> createState() => _FormState();
}

class _FormState extends State<WForm> {
  TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormatUtils.formatDate(
        context.read<FormChangeNotifier>().tanggal_lahir);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                    ),
                    initialValue:
                        context.read<FormChangeNotifier>().nama,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak boleh kosong';
                      }

                      return null;
                    },
                    onChanged:
                        context.read<FormChangeNotifier>().changeName,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal lahir',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                      return null;
                    },
                    onTap: () async {
                      await _changeDate(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _saveKaryawan(context);
                        } catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Operation success'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(!widget.edit
                        ? Icons.add_outlined
                        : Icons.edit_outlined),
                    label: Text(widget.edit ? "Edit" : "Tambah"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        if (context.watch<FormChangeNotifier>().loading)
          Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
      ],
    );
  }

  Future<void> _changeDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 5),
      firstDate: DateTime(1700),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      context.read<FormChangeNotifier>().changeTanggalLahir(date);
      dateController.text = DateFormatUtils.formatDate(date);
    }
  }

  Future<void> _saveKaryawan(BuildContext context) async {
    context.read<FormChangeNotifier>().changeLoading(true);
    var usuario = KaryawanModel(
      no: context.read<FormChangeNotifier>().id,
      nomor_induk: context.read<FormChangeNotifier>().nomor_induk,
      nama: context.read<FormChangeNotifier>().nama,
      tanggal_lahir:
          context.read<FormChangeNotifier>().tanggal_lahir,
      alamat: context.read<FormChangeNotifier>().alamat,
    );

    try {
      int createdOrUpdatedUser;
      if (!widget.edit) {
        createdOrUpdatedUser =
            await context.read<ListChangeNotifier>().addKaryawan(
                  usuario,
                );
      } else {
        createdOrUpdatedUser =
            await context.read<ListChangeNotifier>().updateKaryawan(
                  usuario,
                );
      }
      if (createdOrUpdatedUser > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(widget.edit ? 'Edit Karyawan' : 'Tambah Karyawan'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Error ${widget.edit ? 'Edit' : 'Tambah'} "),
            backgroundColor: Colors.red,
          ),
        );
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
        ),
      );
    }
    context.read<FormChangeNotifier>().changeName("");
    context.read<FormChangeNotifier>().changeLoading(false);
  }
}
