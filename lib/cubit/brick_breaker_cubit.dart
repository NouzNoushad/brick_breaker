import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brick_breaker/core/constant.dart';
import 'package:flutter/material.dart';
part 'brick_breaker_state.dart';

class BrickBreakerCubit extends Cubit<BrickBreakerState> {
  BrickBreakerCubit() : super(BrickBreakerInitial());

  double brickX = -0.95;
  double brickY = -0.85;
  double brickGap = 0.12;
  double brickWidth = 0.4;
  double brickHeight = 0.15;
  bool isStarted = false;
  double height = 0;
  double width = 0;
  double radius = 7;

  double sliderXPosition = 0;
  double sliderHeight = 20;
  double sliderWidth = 100;
  Direction xDirection = Direction.right;
  Direction yDirection = Direction.down;
  double xPosition = 0;
  double yPosition = 0;
  double increment = 5;

  List brick = [];

  initGame() {
    brick = [
      [brickX, brickY, false],
      [brickX + 1 * (brickGap + brickWidth), brickY, false],
      [brickX + 2 * (brickGap + brickWidth), brickY, false],
    ];
    print(brick);
  }

  updateDirection() {
    var diameter = 2 * radius;
    print(height);
    print('ypos: $yPosition');
    if (xPosition <= 0 && xDirection == Direction.left) {
      xDirection = Direction.right;
    }
    if (xPosition >= width - diameter && xDirection == Direction.right) {
      xDirection = Direction.left;
    }
    if (yPosition <= 0 && yDirection == Direction.up) {
      yDirection = Direction.down;
    }
    if (yPosition >= height - diameter - sliderHeight &&
        yDirection == Direction.down) {
      print('hit');
      print('slider x pos: $sliderXPosition');
      print('x pos: $xPosition');

      // yDirection = Direction.up;
      if (xPosition <= sliderXPosition - diameter &&
          xPosition >= sliderXPosition + sliderWidth + diameter) {
        print('up');
        yDirection = Direction.up;
      } else {
        print('down');
      }
    }
  }

  moveBall() {
    (xDirection == Direction.right)
        ? xPosition += increment.round()
        : xPosition -= increment.round();
    (yDirection == Direction.down)
        ? yPosition += increment.round()
        : yPosition -= increment.round();
  }

  String findDirection(double a, double b, double c, double d) {
    List<double> brickList = [a, b, c, d];
    double currentMinimum = a;
    for (int i = 0; i < brickList.length; i++) {
      if (brickList[i] < currentMinimum) {
        currentMinimum = brickList[i];
      }
    }
    if ((currentMinimum - a).abs() < -0.95) {
      return 'left';
    } else if ((currentMinimum - b).abs() < -0.95) {
      return 'right';
    } else if ((currentMinimum - c).abs() < -0.95) {
      return 'up';
    } else if ((currentMinimum - d).abs() < -0.95) {
      return 'down';
    }
    return '';
  }

  breakBricks() {
    for (int i = 0; i < brick.length; i++) {
      if (xPosition >= brick[i][0] &&
          xPosition <= brick[i][0] + brickWidth &&
          xPosition <= brick[i][1] + brickHeight &&
          brick[i][2] == false) {
        brick[i][2] = true;
        double leftDistance = (brick[i][0] - xPosition).abs();
        double rightDistance = (brick[i][0] + brickWidth - xPosition).abs();
        double topDistance = (brick[i][1] - yPosition).abs();
        double bottomDistance = (brick[i][1] + brickHeight - yPosition).abs();
        String direction = findDirection(
            leftDistance, rightDistance, topDistance, bottomDistance);
        switch (direction) {
          case 'left':
            return Direction.left;
          case 'right':
            return Direction.right;
          case 'up':
            return Direction.up;
          case 'down':
            return Direction.down;
        }
      }
    }
  }

  startGame() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      isStarted = true;
      updateDirection();
      moveBall();
      breakBricks();
      emit(StartGameState());
    });
  }

  sliderMovementUpdate(DragUpdateDetails drag) {
    if (sliderXPosition >= 310) {
      sliderXPosition = 310;
    }
    if (sliderXPosition <= 0) {
      sliderXPosition = 0;
    }
    sliderXPosition += drag.delta.dx;
    emit(UpdateSliderMovement());
  }
}
