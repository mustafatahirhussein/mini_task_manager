import 'package:mini_task_manager/core/result_state/app_result_state.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';

abstract class DashboardRepository {
  Future<AppResultState> getRandomJoke();
  Future<AppResultState> addTask(TaskModel taskModel);
  Future<AppResultState> updateTask(TaskModel taskModel);
  Future<AppResultState> deleteTask(TaskModel taskModel);
}