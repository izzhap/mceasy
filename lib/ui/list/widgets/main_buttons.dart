import 'package:flutter/material.dart';
import 'package:mceasy/provider/list_change_notifier.dart';
import 'package:mceasy/ui/form/form_page.dart';

import 'package:provider/provider.dart';

class MainButtons extends StatelessWidget {
  const MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "btn_add",
          key: const Key('btn_add'),
          onPressed: () {
            _navToForm(context);
          },
          child: const Icon(Icons.add_outlined),
        ),
      ],
    );
  }

  void _navToForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormPage(
          edit: false,
        ),
      ),
    );
  }
}
