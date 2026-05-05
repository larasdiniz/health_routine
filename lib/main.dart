import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';

// Imports da Feature Hoje
import 'features/hoje/data/datasources/hoje_datasource.dart';
import 'features/hoje/data/repositories/hoje_repository_impl.dart';
import 'features/hoje/domain/usecases/get_today_activities_usecase.dart';
import 'features/hoje/presentation/bloc/hoje_cubit.dart';

// Imports da Feature Tarefas (Novos!)
import 'features/tasks/data/datasources/task_datasource.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/usecases/save_task_usecase.dart';
import 'features/tasks/presentation/bloc/task_cubit.dart';

import 'features/main_navigation/presentation/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HealthRoutineApp());
}

class HealthRoutineApp extends StatelessWidget {
  const HealthRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Injeções da Feature: Hoje
    final hojeDataSource = MockHojeDataSource();
    final hojeRepository = HojeRepositoryImpl(dataSource: hojeDataSource);
    final getTodayActivitiesUseCase = GetTodayActivitiesUseCase(hojeRepository);

    // Injeções da Feature: Tarefas
    final taskDataSource = MockTaskDataSource();
    final taskRepository = TaskRepositoryImpl(taskDataSource);
    final saveTaskUseCase = SaveTaskUseCase(taskRepository);

    // Agora os provedores envolvem o MaterialApp!
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HojeCubit(getTodayActivities: getTodayActivitiesUseCase),
        ),
        BlocProvider(
          create: (context) => TaskCubit(saveTaskUseCase: saveTaskUseCase),
        ),
      ],
      child: MaterialApp(
        title: 'Health Routine',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainPage(),
      ),
    );
  }
}
