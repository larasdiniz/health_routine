import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:health_routine/features/tasks/domain/entities/task_entity.dart';
import 'package:health_routine/features/tasks/domain/repositories/i_task_repository.dart';
import 'package:health_routine/features/tasks/domain/usecases/save_task_usecase.dart';

// 1. Criamos um "Dublê" do nosso Repositório usando o Mocktail
class MockTaskRepository extends Mock implements ITaskRepository {}

// Precisamos criar um "Dublê" da Entidade (Fallback) pro Mocktail não se perder com objetos complexos
class FakeTaskEntity extends Fake implements TaskEntity {}

void main() {
  late SaveTaskUseCase useCase;
  late MockTaskRepository mockRepository;

  // O setUp roda antes de CADA teste. Usamos para inicializar as coisas limpas.
  setUpAll(() {
    registerFallbackValue(FakeTaskEntity());
  });

  setUp(() {
    mockRepository = MockTaskRepository();
    useCase = SaveTaskUseCase(mockRepository);
  });

  // O nosso objeto de teste padrão
  final tTask = TaskEntity(id: '123', title: 'Meditação', isEssential: true);

  group('SaveTaskUseCase |', () {
    test(
      'Deve salvar a tarefa com sucesso quando os dados forem válidos',
      () async {
        // Arrange (Preparação): Dizemos ao dublê o que ele deve fazer quando for chamado
        when(() => mockRepository.saveTask(any())).thenAnswer((_) async => {});

        // Act (Ação): Chamamos o UseCase
        await useCase(tTask);

        // Assert (Verificação): Garantimos que o repositório foi chamado exatamente 1 vez
        verify(() => mockRepository.saveTask(tTask)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('Deve lançar uma Exception quando o título da tarefa for vazio', () async {
      // Arrange
      final tTaskInvalida = TaskEntity(
        id: '124',
        title: '', // Título vazio!
      );

      // Act
      // Quando esperamos um erro, guardamos a chamada numa variável (call) sem o 'await'
      final call = useCase.call;

      // Assert
      // Verificamos se ele joga a Exception exatamente como programamos na regra de negócio
      expect(() => call(tTaskInvalida), throwsA(isA<Exception>()));

      // E garantimos que ele NUNCA chamou o repositório para salvar essa tarefa quebrada
      verifyNever(() => mockRepository.saveTask(any()));
    });
  });
}
