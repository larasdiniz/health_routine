class ActivityEntity {
  final String id;
  final String title;
  final bool isCompleted;
  final String colorCode; // Para mapear para o AppColors depois

  ActivityEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.colorCode,
  });
}