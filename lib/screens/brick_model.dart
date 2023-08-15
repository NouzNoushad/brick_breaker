import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickHeight;
  final double brickWidth;
  final bool isBroken;
  const Brick(
      {super.key,
      required this.brickHeight,
      required this.brickWidth,
      required this.brickX,
      required this.brickY,
      required this.isBroken});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment(((2 * brickX + brickY) / 2 - brickY), brickY),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: size.height * brickHeight / 4,
          width: size.width * brickWidth / 2,
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
