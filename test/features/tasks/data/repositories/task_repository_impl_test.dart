import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:health_routine/features/tasks/data/datasources/task_datasource.dart';
import 'package:health_routine/features/tasks/data/models/task_model.dart';
import 'package:health_routine/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:health_routine/features/tasks/domain/entities/task_entity.dart';

// 1. Criamos o "Dublê" do DataSource
class MockTaskDataSource extends Mock implements ITaskDataSource {}

// 2. Dublê (Fallback) do Model para o Mocktail não se perder
class FakeTaskModel extends Fake implements TaskModel {}

void main() {
  late TaskRepositoryImpl repository;
  late MockTaskDataSource mockDataSource;

  setUpAll(() {
    registerFallbackValue(FakeTaskModel());
  });

  setUp(() {
    mockDataSource = MockTaskDataSource();
    repository = TaskRepositoryImpl(mockDataSource);
  });

  // A Entidade que vem da nossa regra de negócio
  final tTaskEntity = TaskEntity(
    id: '123',
    title: 'Estudar Flutter',
    isEssential: true,
  );

  group('TaskRepositoryImpl |', () {
    test('Deve converter TaskEntity em TaskModel e repassar para o DataSource', () async {
      // Arrange: Dizemos pro dublê que tá tudo certo ao salvar
      when(() => mockDataSource.saveTask(any())).thenAnswer((_) async => {});

      // Act: Chamamos a função do repositório
      await repository.saveTask(tTaskEntity);

      // Assert: A parte mais legal! 
      // Vamos capturar ("pegar no flagra") o que o repositório enviou pro DataSource
      final captured = verify(() => mockDataSource.saveTask(captureAny())).captured;
      
      // Pegamos o objeto que foi enviado
      final savedModel = captured.first as TaskModel;

      // Verificamos se ele realmente converteu pra TaskModel e manteve os dados!
      expect(savedModel, isA<TaskModel>());
      expect(savedModel.id, tTaskEntity.id);
      expect(savedModel.title, tTaskEntity.title);
      expect(savedModel.isEssential, tTaskEntity.isEssential);
    });
  });
}