import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_task_manager/config/constants/app_constants.dart';
import 'package:mini_task_manager/config/service/api_url.dart';
import 'package:mini_task_manager/core/result_state/app_result_state.dart';
import 'package:mini_task_manager/features/dashboard/data/model/joke_model.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';
import 'package:mini_task_manager/features/dashboard/domain/repostiory/dashboard_repository.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final _dio = Dio();

  @override
  Future<AppResultState> getRandomJoke() async {
    try {
      final res = await _dio.get(ApiUrl.jokeUrl);

      if(res.statusCode == 200) {

        JokeModel model = JokeModel.fromJson(res.data);
        return AppResultState.success(model);
      }
      else {
        return AppResultState.error("signed out");
      }
    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }

  @override
  Future<AppResultState> addTask(TaskModel task) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null) {
        return AppResultState.error("signed out");
      }

      final doc = await FirebaseFirestore.instance.collection("users").doc(AppConstants.userId).collection("tasks").add(
        task.toJson()
      );

      await doc.update({'id': doc.id});
      return AppResultState.success("Task Added");

    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }

  @override
  Future<AppResultState> updateTask(TaskModel task) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null) {
        return AppResultState.error("signed out");
      }

      await FirebaseFirestore.instance.collection("users").doc(AppConstants.userId).collection("tasks").doc(task.id).update(
        task.toJson()
      );
      return AppResultState.success("Task Updated");

    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }

  @override
  Future<AppResultState> deleteTask(TaskModel task) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null) {
        return AppResultState.error("signed out");
      }

      await FirebaseFirestore.instance.collection("users").doc(AppConstants.userId).collection("tasks").doc(task.id).delete();
      return AppResultState.success("Task Deleted");

    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }
}
