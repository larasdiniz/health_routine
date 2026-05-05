import '../models/task_model.dart';

abstract class ITaskDataSource {
  Future<void> saveTask(TaskModel task);
}

class MockTaskDataSource implements ITaskDataSource {
  // Simulando um banco de dados em memória
  final List<TaskModel> _bancoDeDadosMock = [];

  @override
  Future<void> saveTask(TaskModel task) async {
    // Finge o tempo de carregamento da internet (1 segundo)
    await Future.delayed(const Duration(seconds: 1));
    
    // Salva na nossa lista local
    _bancoDeDadosMock.add(task);
    
    // Só pra gente ver no terminal do Flutter que funcionou!
    print('✅ Tarefa salva no banco mockado com sucesso: ${task.title}');
    print('Dados: ${task.toJson()}');
  }
}