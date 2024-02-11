import 'package:flutter/material.dart';

class InnerShadow extends StatelessWidget {
  const InnerShadow({
    super.key,
    required this.child,
    this.size = 5,
    this.borderRadius = 8,
    this.innerColor = Colors.white,
  });

  final Widget child;
  final double size;
  final double borderRadius;
  final Color innerColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        padding: EdgeInsets.all(size),
        child: Container(
          decoration: BoxDecoration(
            color: innerColor,
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: innerColor,
                blurRadius: size,
                spreadRadius: size,
              )
            ],
          ),
          width: double.infinity,
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
