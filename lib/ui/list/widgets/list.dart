import 'package:flutter/material.dart';
import 'package:mceasy/model/cuti_model.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/list/widgets/card_body.dart';
import 'package:mceasy/widgets/custom_card.dart';
import 'package:mceasy/widgets/no_data.dart';

import 'package:provider/provider.dart';


class WList extends StatefulWidget {
  const WList({Key? key, required this.pos}) : super(key: key);

  final int pos;

  @override
  State<WList> createState() => _WListState();
}

class _WListState extends State<WList> {
  @override
  void initState() {
    super.initState();
    _loadKaryawan();
  }

  void _loadKaryawan() {
    try {
        context
            .read<ListChangeNotifier>()
            .getAllFilterCuti(widget.pos);
      context
          .read<ListChangeNotifier>()
          .getAllFilter(widget.pos);
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

  @override
  Widget build(BuildContext context) {
    var dataKaryawan = context.watch<ListChangeNotifier>().listKaryawan;
    var dataCuti = context.watch<ListChangeNotifier>().listCuti;
    return Stack(
      children: [
        Column(
          children: [
            if (dataKaryawan.isEmpty &&
                !context.watch<ListChangeNotifier>().loading)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            if (dataKaryawan.isEmpty &&
                !context.watch<ListChangeNotifier>().loading)
              const NoData(label: "Data kosong"),
            if (dataKaryawan.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: dataKaryawan.length,
                        itemBuilder: (context, index) {
                          KaryawanModel karyawanModel = dataKaryawan[index];
                          CutiModel? cutiModel = dataCuti[index];
                          return Column(
                            children: [
                              CustomCard(
                                child: CardBody(
                                  karyawanModel: karyawanModel,
                                  cutiModel: cutiModel,
                                ),
                                padding: 15,
                              ),
                              if (index == dataKaryawan.length - 1)
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
        if (context.watch<ListChangeNotifier>().loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
