import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/hoje/data/datasources/hoje_datasource.dart';
import 'features/hoje/data/repositories/hoje_repository_impl.dart';
import 'features/hoje/domain/usecases/get_today_activities_usecase.dart';
import 'features/hoje/presentation/bloc/hoje_cubit.dart'; 
import 'features/main_navigation/presentation/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthRoutineApp());
}

class HealthRoutineApp extends StatelessWidget {
  const HealthRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Injeções de dependência manuais
    final dataSource = MockHojeDataSource();
    final repository = HojeRepositoryImpl(dataSource: dataSource);
    final getTodayActivitiesUseCase = GetTodayActivitiesUseCase(repository);

    return MaterialApp(
      title: 'Health Routine',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Provedor do estado injetado na raiz da navegação
      home: BlocProvider(
        create: (context) =>
            HojeCubit(getTodayActivities: getTodayActivitiesUseCase),
        child: const MainPage(), // <-- Agora o app abre direto na aba de navegação!
      ),
    );
  }
}