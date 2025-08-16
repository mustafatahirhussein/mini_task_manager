abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

class TaskSuccess extends TaskState {
  final String message;
  TaskSuccess(this.message);
}
