import 'package:mini_task_manager/features/auth/domain/repostiory/auth_repository.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc(this._authRepository) : super(AuthInitial());

  final AuthRepository _authRepository;

  login({required String email, required String password}) async {
    emit(AuthLoading());
    final res = await _authRepository.login(email: email, password: password);

    if(res.error != null) {
      emit(AuthError(res.error ?? ""));
    }
    else {
      emit(AuthSuccess(res.data));
    }
  }

  register({required String email, required String password}) async {
    emit(AuthLoading());
    final res = await _authRepository.register(email: email, password: password);

    if(res.error != null) {
      emit(AuthError(res.error ?? ""));
    }
    else {
      emit(AuthSuccess(res.data));
    }
  }

  checkState() async {
    emit(AuthLoading());
    final res = await _authRepository.checkState();

    if(res.error != null) {
      emit(AuthError(res.error ?? ""));
    }
    else {
      emit(AuthSuccess(res.data));
    }
  }

  logout() async {
    emit(AuthLoading());
    final res = await _authRepository.logout();

    if(res.error != null) {
      emit(AuthError(res.error ?? ""));
    }
    else {
      emit(AuthLogoutSuccess());
    }
  }
}