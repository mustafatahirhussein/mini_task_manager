import 'package:mini_task_manager/core/result_state/app_result_state.dart';

abstract class AuthRepository {
  Future<AppResultState> login({required String email, required String password});
  Future<AppResultState> register({required String email, required String password});
  Future<AppResultState> checkState();
}