import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        // Uma sombrinha bem suave igual a do Figma para o card "saltar" da tela
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Check-in', style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          Text('Como você está hoje?', style: AppTextStyles.bodySmall),
          const SizedBox(height: 16),
          
          // A linha com os 4 humores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MoodOption(
                color: AppColors.moodAnimada, 
                label: 'Animada', 
                icon: Icons.sentiment_satisfied_alt, // Sorriso
              ),
              _MoodOption(
                color: AppColors.moodSensivel, 
                label: 'Sensível', 
                icon: Icons.water_drop_outlined, // Gotinha simulando lágrima
              ),
              _MoodOption(
                color: AppColors.moodBrava, 
                label: 'Brava', 
                icon: Icons.sentiment_very_dissatisfied, // Cara fechada
                isSquare: true, // No Figma esse parece um quadradinho arredondado!
              ),
              _MoodOption(
                color: AppColors.moodInsegura, 
                label: 'Insegura', 
                icon: Icons.remove_red_eye_outlined, // Olhinho
                isSquare: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar privado só para não repetir código dos botõezinhos
class _MoodOption extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final bool isSquare;

  const _MoodOption({
    required this.color,
    required this.label,
    required this.icon,
    this.isSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            // Se for isSquare, arredonda menos (parecendo o card laranja/amarelo)
            borderRadius: BorderRadius.circular(isSquare ? 16 : 30), 
          ),
          child: Icon(icon, color: AppColors.black, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}