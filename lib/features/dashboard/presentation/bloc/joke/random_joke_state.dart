import 'package:mini_task_manager/features/dashboard/data/model/joke_model.dart';

abstract class RandomJokeState {}

class RandomJokeInitial extends RandomJokeState {}

class RandomJokeLoading extends RandomJokeState {}

class RandomJokeError extends RandomJokeState {
  final String message;
  RandomJokeError(this.message);
}

class RandomJokeSuccess extends RandomJokeState {
  final JokeModel model;
  RandomJokeSuccess(this.model);
}
