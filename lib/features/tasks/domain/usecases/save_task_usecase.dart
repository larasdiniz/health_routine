import '../entities/task_entity.dart';
import '../repositories/i_task_repository.dart';

class SaveTaskUseCase {
  final ITaskRepository repository;

  SaveTaskUseCase(this.repository);

  // O "call" permite que a gente chame a classe como se fosse uma função!
  Future<void> call(TaskEntity task) async {
    // Aqui no futuro poderia ter uma regra de negócio, tipo:
    // "Não pode salvar tarefa sem título", mas vamos deixar simples por enquanto.
    if (task.title.isEmpty) {
      throw Exception('O título da tarefa não pode ser vazio!');
    }
    
    await repository.saveTask(task);
  }
}