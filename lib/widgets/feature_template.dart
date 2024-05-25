import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';

class FeatureTemplate extends StatefulWidget {
  const FeatureTemplate(
      {required this.title,
      required this.child,
      this.background = false,
      super.key});
  final String title;
  final Widget child;
  final bool background;
  @override
  State<FeatureTemplate> createState() => _FeatureTemplateState();
}

class _FeatureTemplateState extends State<FeatureTemplate> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Orchestrify",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: [
          widget.background
              ? Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('homeBackgroundImage.jpg'),
                        fit: BoxFit.cover),
                  ),
                )
              : const SizedBox(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment:
                widget.background ? Alignment.center : Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: widget.background
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: widget.child,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
