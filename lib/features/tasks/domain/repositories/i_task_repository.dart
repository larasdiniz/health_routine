import '../entities/task_entity.dart';

abstract class ITaskRepository {
  // A promessa é simples: O sistema deve conseguir salvar uma tarefa.
  Future<void> saveTask(TaskEntity task);
}