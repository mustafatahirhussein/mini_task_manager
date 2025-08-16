import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_state.dart';

import '../../../exports.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: [
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthLogoutSuccess) {
              AppConstants.userId = "-1";
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
            }
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<AuthBloc>().logout();
                },
              icon: state is AuthLoading ? const CircularProgressIndicator() : const Icon(Icons.logout),
            );
          }
        ),
      ],),
    );
  }
}
