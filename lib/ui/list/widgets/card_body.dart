import 'package:flutter/material.dart';
import 'package:mceasy/model/cuti_model.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:mceasy/provider/form_change_notifier.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/form/form_page.dart';
import 'package:mceasy/utils/date_format_utils.dart';

import 'package:provider/provider.dart';


class CardBody extends StatefulWidget {
  const CardBody(
      {Key? key, required this.karyawanModel, required this.cutiModel})
      : super(key: key);

  final KaryawanModel karyawanModel;
  final CutiModel cutiModel;

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
            Expanded(
              child: Text(
                "${widget.karyawanModel.nama}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        TextWrap(label: "Nomor Induk", value: widget.karyawanModel.nomor_induk),
        const SizedBox(height: 10),
        if (widget.cutiModel.tanggal_cuti != null)
          TextWrap(
            label: "Tanggal Cuti",
            value: DateFormatUtils.formatDate(widget.cutiModel.tanggal_cuti!),
          ),
        const SizedBox(height: 10),
        if (widget.karyawanModel.tanggal_bergabung != null)
          TextWrap(
            label: "Tanggal Bergabung",
            value: DateFormatUtils.formatDate(widget.karyawanModel.tanggal_bergabung!),
          ),
        const SizedBox(height: 10),
        if (widget.cutiModel.keterangan != null)
          TextWrap(
            label: "Keterangan",
            value: widget.cutiModel.keterangan,
          ),
        const SizedBox(height: 10),
        if (widget.cutiModel.lama_cuti != null)
          TextWrap(
            label: "Cuti",
            value: widget.cutiModel.lama_cuti.toString(),
          ),
        const SizedBox(height: 10),
        if (widget.cutiModel.lama_cuti != null)
          TextWrap(
            label: "Sisa Cuti",
            value: (12 - (widget.cutiModel.lama_cuti)).toString(),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final bool? delete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Informasi"),
                      content: const Text(
                          "Yakin ingin menghapus data?"),
                      actions: [
                        TextButton(
                          child: const Text("Tidak"),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        TextButton(
                          child: const Text("Ya"),
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
                            content: Text('Error data'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error data'),
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
                label: const Text("Hapus"),
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
                            .initKaryawan(widget.karyawanModel);
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error data'),
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
                label: const Text("Edit"),
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
