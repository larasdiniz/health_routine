import '../../domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.id,
    required super.title,
    super.isCompleted,
    required super.colorCode,
  });

  // Transforma um Map (JSON) vindo da internet/banco de dados em um Objeto
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      colorCode: map['colorCode'] ?? 'blue', // Cor padrão de fallback
    );
  }

  // Transforma o Objeto de volta para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'colorCode': colorCode,
    };
  }
}