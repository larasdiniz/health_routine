import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_today_activities_usecase.dart';
import 'hoje_state.dart';

class HojeCubit extends Cubit<HojeState> {
  final GetTodayActivitiesUseCase getTodayActivities;

  HojeCubit({required this.getTodayActivities}) : super(HojeInitial());

  // Função para buscar as atividades
  Future<void> loadActivities() async {
    emit(HojeLoading());
    try {
      // Chama o UseCase do nosso Domain
      final activities = await getTodayActivities.call();
      emit(HojeSuccess(activities: activities));
    } catch (e) {
      emit(const HojeError(message: 'Erro ao carregar as atividades.'));
    }
  }

  // Função para alternar o modo Baixa Energia (já deixando engatilhado!)
  void toggleLowEnergyMode(bool isActive) {
    if (state is HojeSuccess) {
      final currentState = state as HojeSuccess;
      emit(HojeSuccess(
        activities: currentState.activities, 
        isLowEnergyMode: isActive,
      ));
    }
  }
}