import 'package:flutter/material.dart';

import '../../constants.dart';

typedef MenuValue = void Function(dynamic val);

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.size,
    required this.onChange,
    required this.menuItems,
    required this.label,
    this.originalValue,
  });

  final Size size;
  final MenuValue onChange;
  final String label;
  final String? originalValue;
  final List<String> menuItems;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  late String selectedItem;
  @override
  void initState() {
    if (widget.originalValue != null) {
      for (int i = 0; i < widget.menuItems.length; i++) {
        if (widget.originalValue == widget.menuItems[i]) {
          selectedItem = widget.originalValue!;
        }
      }
    } else {
      selectedItem = widget.menuItems.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Container(
          width: widget.size.width * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            dropdownColor: Colors.black,
            focusColor: Colors.transparent,
            style: const TextStyle(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
            alignment: Alignment.center,
            isExpanded: true,
            value: selectedItem,
            onChanged: (String? val) {
              setState(() {
                selectedItem = val!;
                widget.onChange(val);
              });
            },
            items: widget.menuItems
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
