import 'package:brick_breaker/cubit/brick_breaker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brick_model.dart';

class BrickBreakerGame extends StatefulWidget {
  const BrickBreakerGame({super.key});

  @override
  State<BrickBreakerGame> createState() => _BrickBreakerGameState();
}

class _BrickBreakerGameState extends State<BrickBreakerGame> {
  late BrickBreakerCubit brickBreakerCubit;

  @override
  void initState() {
    brickBreakerCubit = BlocProvider.of<BrickBreakerCubit>(context);
    brickBreakerCubit.initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 14, 65),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return BlocBuilder<BrickBreakerCubit, BrickBreakerState>(
            builder: (context, state) {
              brickBreakerCubit.height = constraints.maxHeight;
              brickBreakerCubit.width = constraints.maxWidth;
              return Stack(
                children: [
                  const Positioned(
                    right: 10,
                    top: 10,
                    child: Text(
                      'Score: 0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    left: brickBreakerCubit.xPosition,
                    top: brickBreakerCubit.yPosition,
                    child: CircleAvatar(
                      radius: brickBreakerCubit.radius,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  Positioned(
                      left: brickBreakerCubit.sliderXPosition,
                      bottom: 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (drag) =>
                            brickBreakerCubit.sliderMovementUpdate(drag),
                        onTap: brickBreakerCubit.startGame,
                        child: Container(
                          height: brickBreakerCubit.sliderHeight,
                          width: brickBreakerCubit.sliderWidth,
                          color: Colors.pink,
                        ),
                      )),
                  Brick(
                    brickX: brickBreakerCubit.brick[0][0],
                    brickY: brickBreakerCubit.brick[0][1],
                    isBroken: brickBreakerCubit.brick[0][2],
                    brickWidth: brickBreakerCubit.brickWidth,
                    brickHeight: brickBreakerCubit.brickHeight,
                  ),
                  Brick(
                    brickX: brickBreakerCubit.brick[1][0],
                    brickY: brickBreakerCubit.brick[1][1],
                    isBroken: brickBreakerCubit.brick[1][2],
                    brickWidth: brickBreakerCubit.brickWidth,
                    brickHeight: brickBreakerCubit.brickHeight,
                  ),
                  Brick(
                    brickX: brickBreakerCubit.brick[2][0],
                    brickY: brickBreakerCubit.brick[2][1],
                    isBroken: brickBreakerCubit.brick[2][2],
                    brickWidth: brickBreakerCubit.brickWidth,
                    brickHeight: brickBreakerCubit.brickHeight,
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
