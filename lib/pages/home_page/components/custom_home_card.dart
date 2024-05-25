import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';

class CustomHomeCard extends StatefulWidget {
  const CustomHomeCard({
    required this.text,
    required this.destination,
    super.key,
  });
  final String text;
  final Widget destination;
  @override
  State<CustomHomeCard> createState() => _CustomHomeCardState();
}

class _CustomHomeCardState extends State<CustomHomeCard> {
  Color containerColor = Colors.black12;
  Color textColor = Colors.black;
  double borderWidth = 3;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: mainColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
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
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: textColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void onHover(hovered) {
    setState(() {
      containerColor = hovered ? mainColor : Colors.black12;
      textColor = hovered ? Colors.white : Colors.black;
      borderWidth = hovered ? 0 : 3;
    });
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.destination),
    );
  }
}
