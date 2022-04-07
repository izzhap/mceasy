import 'package:flutter/material.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/list/widgets/main_buttons.dart';
import 'package:mceasy/ui/list/widgets/list.dart';

import 'package:provider/provider.dart';


class ListPage extends StatelessWidget {
  const ListPage({Key? key,required this.pos, required this.title}) : super(key: key);
  final int pos;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
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
                WList(
                  pos: pos,
                ),
                RefreshIndicator(
                  onRefresh: () {
                    try {
                        context
                            .read<ListChangeNotifier>()
                            .getAllFilterCuti(pos);

                      return context
                          .read<ListChangeNotifier>()
                          .getAllFilter(pos);
                    } catch (e) {
                      print(e);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error data'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    return Future.value();
                  },
                  child: WList(
                    pos: pos,
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
