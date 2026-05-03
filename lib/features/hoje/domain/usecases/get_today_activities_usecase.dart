import '../entities/activity_entity.dart';
import '../repositories/i_hoje_repository.dart';

class GetTodayActivitiesUseCase {
  final IHjeRepository repository;

  GetTodayActivitiesUseCase(this.repository);

  Future<List<ActivityEntity>> call() async {
    // Aqui no futuro podemos colocar lógicas extras, 
    // tipo filtrar só as tarefas que não foram deletadas, etc.
    return await repository.getTodayActivities();
  }
}