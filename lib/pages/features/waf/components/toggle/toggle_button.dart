import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    required this.onTap,
    required this.text,
    required this.selected,
    this.width = 150,
    super.key,
  });
  final VoidCallback onTap;
  final double width;
  final String text;
  final bool selected;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late Color containerColor;
  late Color textColor;
  late double borderWidth;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        height: 55,
        width: widget.width,
        decoration: BoxDecoration(
          color: !widget.selected ? mainColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: mainColor, width: !widget.selected ? 0 : 3),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.5),
              offset: const Offset(1.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: !widget.selected ? Colors.white : mainColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void onTap() {
    setState(() {
      widget.onTap();
      containerColor = !widget.selected ? mainColor : Colors.white;
      textColor = !widget.selected ? Colors.white : mainColor;
      borderWidth = !widget.selected ? 0 : 3;
    });
  }
}
