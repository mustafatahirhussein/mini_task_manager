import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_manager/config/extensions/padding_ext.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_task_manager/features/auth/presentation/bloc/auth_state.dart';
import 'package:mini_task_manager/features/dashboard/data/model/task_model.dart';
import 'package:mini_task_manager/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/joke/random_joke_cubit.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/task/task_cubit.dart';
import 'package:mini_task_manager/features/dashboard/presentation/bloc/task/task_state.dart';
import 'package:mini_task_manager/features/dashboard/presentation/widgets/task_widget.dart';
import 'package:mini_task_manager/locator_setup.dart';

import '../../../../exports.dart';
import '../bloc/joke/random_joke_state.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RandomJokeCubit(getIt<DashboardRepositoryImpl>())..getRandomJoke(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLogoutSuccess) {
                  AppConstants.userId = "-1";
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (_) => false,
                  );
                }
              },
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().logout();
                  },
                  icon: state is AuthLoading
                      ? AppLoader()
                      : const Icon(Icons.logout),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<RandomJokeCubit, RandomJokeState>(
          builder: (context, state) {
            if (state is RandomJokeLoading) {
              return AppLoader();
            }
            if (state is RandomJokeSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.subHeader(
                    text: "Joke of the Day",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                  AppText.subHeader(
                    text: "Setup:",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText.subHeader(text: state.model.setup ?? ""),
                  AppText.subHeader(
                    text: "\nPunchline:",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText.subHeader(text: state.model.punchline ?? ""),

                  SizedBox(height: .03.sh),
                  AppText.subHeader(
                    text: "Tasks",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                  SizedBox(height: .01.sh),

                  /// All tasks
                  BlocConsumer<TaskCubit, TaskState>(
                    listener: (c, taskState) {
                      if (taskState is TaskSuccess) {
                        AppSnackBar.showSuccessMessage(
                          context,
                          message: taskState.message,
                        );
                      }
                    },
                    builder: (c, taskState) {
                      return Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(AppConstants.userId)
                              .collection("tasks")
                              .snapshots(),
                          builder: (context, taskSp) {
                            if (taskSp.connectionState ==
                                ConnectionState.waiting) {
                              return AppLoader();
                            }
                            if (taskSp.hasError) {
                              return Center(
                                child: AppText.subHeader(
                                  text: taskSp.error.toString(),
                                ),
                              );
                            }
                            if (taskSp.hasData) {
                              return SafeArea(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: taskSp.data?.docs.length ?? 0,
                                  itemBuilder: (context, i) {
                                    TaskModel? item = TaskModel.fromJson(
                                      taskSp.data?.docs[i].data() ?? {},
                                    );
                                    return Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (val) {
                                        context.read<TaskCubit>().deleteTask(
                                          item,
                                        );
                                      },
                                      background: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: .01.sh,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            .04.sw,
                                          ),
                                          color: AppColors.red,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            size: .12.sw,
                                            color: AppColors.white,
                                          ),
                                        ).applyDefaultPadding(),
                                      ),
                                      child: TaskWidget(
                                        task: item,
                                        onDone: () {
                                          if (item.isDone) {
                                            item.isDone = false;
                                          } else {
                                            item.isDone = true;
                                          }
                                          context.read<TaskCubit>().updateTask(
                                            item,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, _) {
                                    return SizedBox(height: 10);
                                  },
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ).applyDefaultPadding();
            }
            if (state is RandomJokeError) {
              return Center(child: AppText.subHeader(text: state.message));
            }
            return SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addTask);
          },
          label: AppText.subHeader(text: "Add Task", color: AppColors.white),
          icon: Icon(Icons.add, color: Colors.white),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}
