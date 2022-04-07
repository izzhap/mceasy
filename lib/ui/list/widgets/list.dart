import 'package:flutter/material.dart';
import 'package:mceasy/model/karyawan_model.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/list/widgets/card_body.dart';
import 'package:mceasy/widgets/custom_card.dart';
import 'package:mceasy/widgets/no_data.dart';

import 'package:provider/provider.dart';


class WList extends StatefulWidget {
  const WList({Key? key, required this.isRemote}) : super(key: key);

  final bool isRemote;

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
          .getAllUsuarios();
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
    var myData = context.watch<ListChangeNotifier>().listKaryawan;
    return Stack(
      children: [
        Column(
          children: [
            if (myData.isEmpty &&
                !context.watch<ListChangeNotifier>().loading)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            if (myData.isEmpty &&
                !context.watch<ListChangeNotifier>().loading)
              const NoData(label: "Data kosong"),
            if (myData.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: myData.length,
                        itemBuilder: (context, index) {
                          KaryawanModel usuario = myData[index];
                          return Column(
                            children: [
                              CustomCard(
                                child: CardBody(
                                  karyawanModel: usuario,
                                  isRemote: widget.isRemote,
                                ),
                                padding: 15,
                              ),
                              if (index == myData.length - 1)
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
