import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart'; // Precisamos gerar um ID único pra tarefa
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/save_task_usecase.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final SaveTaskUseCase saveTaskUseCase;
  
  // Vamos usar o pacote uuid para gerar IDs aleatórios
  final _uuid = const Uuid(); 

  TaskCubit({required this.saveTaskUseCase}) : super(TaskInitial());

  Future<void> saveNewTask({
    required String title,
    required bool isEssential,
    DateTime? deadline,
    int? quantity,
    List<String> repeatDays = const [],
    bool hasTimer = false,
    bool hasNotifications = false,
  }) async {
    // 1. Avisa a tela que começou a carregar (pra gente poder colocar um loading depois)
    emit(TaskLoading());

    try {
      // 2. Monta a Entidade com os dados que vieram do Modal
      final newTask = TaskEntity(
        id: _uuid.v4(), // Gera um ID tipo "123e4567-e89b-12d3-a456-426614174000"
        title: title,
        isEssential: isEssential,
        deadline: deadline,
        quantity: quantity,
        repeatDays: repeatDays,
        hasTimer: hasTimer,
        hasNotifications: hasNotifications,
      );

      // 3. Manda o motor (UseCase) trabalhar
      await saveTaskUseCase(newTask);

      // 4. Se deu tudo certo, avisa a tela!
      emit(TaskSuccess('Tarefa "$title" criada com sucesso!'));
      
    } catch (e) {
      // 5. Se der erro (ex: título vazio), avisa a tela para mostrar uma mensagem vermelha
      emit(TaskError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}