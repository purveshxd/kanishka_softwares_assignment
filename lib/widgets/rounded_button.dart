// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const RoundedButton({
    Key? key,
    required this.onPressed, required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.amber.shade300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: (MediaQuery.of(context).size.shortestSide / 100) * 14,
      onPressed: onPressed,
      minWidth: double.infinity,
      child:  Text(label),
    );
  }
}
