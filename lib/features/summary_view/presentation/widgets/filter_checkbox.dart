import 'package:flutter/material.dart';

class FilterCheckbox extends StatelessWidget {
  final String label;
  final bool initialValue;
  final ValueSetter<bool?> onChanged;

  const FilterCheckbox(
      {required this.label,
      required this.initialValue,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: initialValue,
          onChanged: (value) => onChanged(value),
        ),
        Text(label),
      ],
    );
  }
}
