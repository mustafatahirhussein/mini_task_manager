import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';
import 'package:mini_task_manager/features/dashboard/domain/repostiory/dashboard_repository.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/task/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._repository) : super(TaskInitial());

  final DashboardRepository _repository;

  addTask(TaskModel model) async {
    emit(TaskLoading());
    final res = await _repository.addTask(model);

    if(res.error != null) {
      emit(TaskError(res.error ?? ""));
    }
    else {
      emit(TaskSuccess(res.data));
    }
  }

  updateTask(TaskModel model) async {
    emit(TaskLoading());
    final res = await _repository.updateTask(model);

    if(res.error != null) {
      emit(TaskError(res.error ?? ""));
    }
    else {
      emit(TaskSuccess(res.data));
    }
  }

  deleteTask(TaskModel model) async {
    emit(TaskLoading());
    final res = await _repository.deleteTask(model);

    if(res.error != null) {
      emit(TaskError(res.error ?? ""));
    }
    else {
      emit(TaskSuccess(res.data));
    }
  }
}