class TaskEntity {
  final String id;
  final String title;
  final bool isEssential;
  final DateTime? deadline; // O botão "Adicionar Data"
  final int? quantity; // O botão "Quantidade"
  final List<String> repeatDays; // Ex: ['S', 'T', 'Q']
  final bool hasTimer;
  final bool hasNotifications;

  TaskEntity({
    required this.id,
    required this.title,
    this.isEssential = false,
    this.deadline,
    this.quantity,
    this.repeatDays = const [],
    this.hasTimer = false,
    this.hasNotifications = false,
  });
}