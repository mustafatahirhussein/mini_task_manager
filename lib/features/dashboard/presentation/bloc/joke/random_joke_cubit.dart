import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/dashboard/data/model/joke_model.dart';
import 'package:mini_task_manager/features/dashboard/domain/repostiory/dashboard_repository.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/joke/random_joke_state.dart';

class RandomJokeCubit extends Cubit<RandomJokeState> {
  RandomJokeCubit(this._randomJokeRepository) : super(RandomJokeInitial());

  final DashboardRepository _randomJokeRepository;

  getRandomJoke() async {
    emit(RandomJokeLoading());
    final res = await _randomJokeRepository.getRandomJoke();

    if(res.error != null) {
      emit(RandomJokeError(res.error ?? ""));
    }
    else {
      emit(RandomJokeSuccess(res.data as JokeModel));
    }
  }
}