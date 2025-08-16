import 'package:get_it/get_it.dart';
import 'package:mini_task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:mini_task_manager/features/dashboard/data/repository/dashboard_repository_impl.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => AuthRepositoryImpl());
  getIt.registerLazySingleton(() => DashboardRepositoryImpl());
}