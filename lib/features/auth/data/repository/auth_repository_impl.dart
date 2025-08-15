import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_task_manager/core/result_state/app_result_state.dart';
import 'package:mini_task_manager/features/auth/domain/repostiory/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<AppResultState> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        return AppResultState.success("Login Successful");
      }
      else {
        return AppResultState.error("Login Failed");
      }
    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }

  @override
  Future<AppResultState> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (FirebaseAuth.instance.currentUser != null) {
        return AppResultState.success("Register Successful");
      }
      else {
        return AppResultState.error("Register Failed");
      }
    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }

  @override
  Future<AppResultState> checkState() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        return AppResultState.success("already login");
      }
      else {
        return AppResultState.error("signed out");
      }
    } catch (e) {
      return AppResultState.error(e.toString());
    }
  }
}
