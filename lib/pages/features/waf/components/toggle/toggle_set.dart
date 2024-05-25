import 'package:flutter/material.dart';
import 'package:forti_grad/pages/features/waf/components/toggle/toggle_button.dart';

import '../../../../../widgets/spacers.dart';

typedef EnabledCallback = void Function(bool val);

class ToggleSet extends StatefulWidget {
  const ToggleSet({required this.enabled, super.key, required this.isEnabled});

  final Function enabled;
  final bool isEnabled;
  @override
  State<ToggleSet> createState() => _ToggleSetState();
}

class _ToggleSetState extends State<ToggleSet> {
  late List<bool> boolList;

  @override
  void initState() {
    boolList = [widget.isEnabled, !widget.isEnabled];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ToggleButton(
          onTap: toggle,
          selected: boolList[0],
          text: "Enable",
        ),
        const HSpacer10(),
        ToggleButton(
          onTap: toggle,
          selected: boolList[1],
          text: "Disable",
        ),
      ],
    );
  }

  void toggle() {
    setState(() {
      boolList[1] = !boolList[1];
      boolList[0] = !boolList[0];
      widget.enabled(boolList[0]);
    });
  }
}
