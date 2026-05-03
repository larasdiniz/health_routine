import '../../domain/entities/activity_entity.dart';
import '../../domain/repositories/i_hoje_repository.dart';
import '../datasources/hoje_datasource.dart';

class HojeRepositoryImpl implements IHjeRepository {
  final IHojeDataSource dataSource;

  HojeRepositoryImpl({required this.dataSource});

  @override
  Future<List<ActivityEntity>> getTodayActivities() async {
    // Aqui nós pegamos os Models e o Dart entende eles como Entities
    // porque ActivityModel extends ActivityEntity. Lindo, né?
    try {
      final models = await dataSource.fetchTodayActivities();
      return models;
    } catch (e) {
      // Se der erro no DataSource, a gente lança uma exceção pro Cubit tratar
      throw Exception('Falha ao buscar atividades');
    }
  }

  @override
  Future<void> toggleActivityCompletion(String activityId, bool isCompleted) async {
    // Como é um Mock, não vamos fazer nada por enquanto. 
    // No futuro, isso faria um PUT/PATCH na API ou banco local.
    await Future.delayed(const Duration(milliseconds: 500));
  }
}