import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/exports.dart';
import 'package:mini_task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_task_manager/locator_setup.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      child: BlocProvider(
        create: (context) => AuthBloc(getIt<AuthRepositoryImpl>())
          ..checkState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          initialRoute: AppRoutes.initialRoute,
        ),
      ),
    );
  }
}
