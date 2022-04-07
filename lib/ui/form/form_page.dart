import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:mceasy/db/sqlite_respository.dart';
import 'package:mceasy/provider/form_change_notifier.dart';
import 'package:mceasy/ui/form/widgets/form.dart';
import 'package:mceasy/widgets/custom_card.dart';
import 'package:provider/provider.dart';


class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.edit}) : super(key: key);
  final bool edit;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final SqliteRepository usuarioSqliteRepository =
      GetIt.I<SqliteRepository>();

  @override
  void initState() {
    super.initState();
    if (!widget.edit) {
      context.read<FormChangeNotifier>().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Form Page',
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomCard(
            padding: 20,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.edit ? "Edit Karyawan" : "Tambah Karyawan",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  WForm(edit: widget.edit),
                ],
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
