import 'package:flutter/material.dart';

class FilterCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueSetter<bool>? onChanged;

  const FilterCheckbox(
      {required this.label,
      required this.initialValue,
      required this.onChanged,
      super.key});

  @override
  State<FilterCheckbox> createState() => _FilterCheckboxState();
}

class _FilterCheckboxState extends State<FilterCheckbox> {
  late bool currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: currentValue,
          onChanged: (value) {
            setState(() {
              currentValue = value ?? false;
            });
            widget.onChanged?.call(currentValue);
          },
        ),
        Text(widget.label),
      ],
    );
  }
}
