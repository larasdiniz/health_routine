import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/activity_entity.dart';

class ActivityCard extends StatelessWidget {
  final ActivityEntity activity;

  const ActivityCard({super.key, required this.activity});

  // Função simples para mapear a string de cor do backend para a cor do nosso tema
  Color _getCardColor(String colorCode) {
    switch (colorCode) {
      case 'pink':
        return AppColors.activityPink;
      case 'blue':
        return AppColors.activityBlue;
      case 'green':
        return AppColors.activityGreen;
      default:
        return AppColors.activityBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getCardColor(activity.colorCode),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black87, width: 1.5), // Bordinha charmosa do Figma
      ),
      child: Row(
        children: [
          // Círculo branco simulando o Checkbox
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: activity.isCompleted 
                ? const Icon(Icons.check, color: AppColors.black, size: 20) 
                : null,
          ),
          const SizedBox(width: 16),
          
          // Título da atividade
          Expanded(
            child: Text(
              activity.title,
              style: AppTextStyles.bodyBold,
            ),
          ),
          
          // Ícone de lápis (editar)
          const Icon(
            Icons.edit,
            color: AppColors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}