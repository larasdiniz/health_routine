import '../entities/activity_entity.dart';

abstract class IHjeRepository {
  // Retorna a lista de atividades do dia
  Future<List<ActivityEntity>> getTodayActivities();
  
  // Marca uma atividade como concluída ou não
  Future<void> toggleActivityCompletion(String activityId, bool isCompleted);
}