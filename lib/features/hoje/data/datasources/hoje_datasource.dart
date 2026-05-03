import '../models/activity_model.dart';

abstract class IHojeDataSource {
  Future<List<ActivityModel>> fetchTodayActivities();
}

// Nossa fonte de dados "falsa" para simular o backend
class MockHojeDataSource implements IHojeDataSource {
  @override
  Future<List<ActivityModel>> fetchTodayActivities() async {
    // Simulando um delay de internet de 1 segundo
    await Future.delayed(const Duration(seconds: 1));

    // Retornando os dados iguaizinhos ao seu Figma!
    return [
      ActivityModel(
        id: '1',
        title: 'Caminhar com o cachorro',
        isCompleted: false,
        colorCode: 'pink', 
      ),
      ActivityModel(
        id: '2',
        title: 'Estudar',
        isCompleted: false,
        colorCode: 'blue',
      ),
      ActivityModel(
        id: '3',
        title: 'Meditação Rápida',
        isCompleted: false,
        colorCode: 'green',
      ),
    ];
  }
}