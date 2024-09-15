import 'package:flutter/material.dart';

class GlobalDropdown extends StatefulWidget {
  const GlobalDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.selectedValue,
  });
  final List<String> options;
  final Function(String?) onChanged;
  final String? selectedValue;
  @override
  State<GlobalDropdown> createState() => _GlobalDropdownState();
}

class _GlobalDropdownState extends State<GlobalDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          focusColor: Colors.white,
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        hint: const Text('Pilih'),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onChanged(_selectedValue);
        },
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: widget.options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
