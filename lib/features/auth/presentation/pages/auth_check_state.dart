import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_state.dart';

import '../../../../exports.dart';

class AuthCheckView extends StatelessWidget {
  const AuthCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 1));
        if (state is AuthSuccess) {
          AppConstants.userId = state.user.uid;

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.dashboard,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
