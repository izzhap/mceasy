import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double padding;
  const CustomCard({Key? key, required this.child, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double margin = 3.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        margin: const EdgeInsets.all(margin),
        padding: EdgeInsets.only(top: padding, left: padding, right: padding),
        width: double.infinity,
        decoration: _customBoxDecoration(),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _customBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
          ]);
}
