part of 'brick_breaker_cubit.dart';

@immutable
sealed class BrickBreakerState {}

final class BrickBreakerInitial extends BrickBreakerState {}

final class StartGameState extends BrickBreakerState {}

final class UpdateSliderMovement extends BrickBreakerState {}


