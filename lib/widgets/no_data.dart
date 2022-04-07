import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty-box.png'),
        Text(label),
      ],
    );
  }
}
