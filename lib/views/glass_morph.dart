// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorph extends StatelessWidget {
  final double blur;
  final double opacity;
  Widget child;
  String image;
  GlassMorph(
      {super.key,
      required this.child,
      required this.blur,
      required this.opacity,
      this.image = ""});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              decoration: BoxDecoration(
                  image: image == ""
                      ? null
                      : DecorationImage(
                          image: AssetImage(image),
                          // opacity,
                          fit: BoxFit.cover),
                  color: Colors.white.withOpacity(opacity),
                  gradient: LinearGradient(
                    transform: const GradientRotation(1),
                    colors: [
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.3),
                    ],
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  border: Border.all(
                      width: 1.5, color: Colors.white.withOpacity(0.2))),
              child: child,
            )));
  }
}
