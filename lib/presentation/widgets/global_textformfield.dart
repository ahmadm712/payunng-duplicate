import 'package:flutter/material.dart';

class GlobalTextformfield extends StatefulWidget {
  const GlobalTextformfield({
    super.key,
    required this.controller,
    required this.hint,
  });
  final TextEditingController controller;
  final String hint;

  @override
  State<GlobalTextformfield> createState() => _GlobalTextformfieldState();
}

class _GlobalTextformfieldState extends State<GlobalTextformfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        focusColor: Colors.white,
      ),
    );
  }
}
