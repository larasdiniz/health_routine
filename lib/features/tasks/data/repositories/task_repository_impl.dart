import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/i_task_repository.dart';
import '../datasources/task_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final ITaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<void> saveTask(TaskEntity task) async {
    // O Repositório recebe uma Entity pura do Domain, 
    // mas o DataSource precisa de um Model. Então a gente converte aqui!
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isEssential: task.isEssential,
      deadline: task.deadline,
      quantity: task.quantity,
      repeatDays: task.repeatDays,
      hasTimer: task.hasTimer,
      hasNotifications: task.hasNotifications,
    );

    // Manda o DataSource trabalhar
    await dataSource.saveTask(taskModel);
  }
}