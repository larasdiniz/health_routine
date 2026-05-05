import '../../domain/entities/task_entity.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final String message;
  TaskSuccess(this.message);
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}
