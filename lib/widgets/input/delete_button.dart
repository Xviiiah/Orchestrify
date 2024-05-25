import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    required this.onTap,
    this.width = 150,
    super.key,
  });
  final VoidCallback onTap;
  final double width;
  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  Color containerColor = mainColor;
  Color textColor = Colors.white;
  double borderWidth = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: onHover,
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        height: 55,
        width: widget.width,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: mainColor, width: borderWidth),
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
            "Delete",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void onHover(hovered) {
    setState(() {
      containerColor = hovered ? Colors.white : mainColor;
      textColor = hovered ? mainColor : Colors.white;
      borderWidth = hovered ? 3 : 0;
    });
  }
}
