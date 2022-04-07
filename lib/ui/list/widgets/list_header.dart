import 'package:flutter/material.dart';
import 'package:mceasy/ui/form/form_page.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormPage(
                      edit: false,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Simpan")),
        ],
      ),
    );
  }
}
