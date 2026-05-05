import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    super.isEssential,
    super.deadline,
    super.quantity,
    super.repeatDays,
    super.hasTimer,
    super.hasNotifications,
  });

  // Aqui entrariam os métodos fromJson e toJson para conversar com uma API de verdade.
  // Como estamos focando na arquitetura primeiro, vamos deixar a estrutura pronta!
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isEssential': isEssential,
      'deadline': deadline?.toIso8601String(),
      'quantity': quantity,
      'repeatDays': repeatDays,
      'hasTimer': hasTimer,
      'hasNotifications': hasNotifications,
    };
  }
}