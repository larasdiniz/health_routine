import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SuggestionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const SuggestionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos um container com tamanho fixo para os cards ficarem padronizados
    return Container(
      width: 150, 
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12), // Borda bem sutil
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyBold.copyWith(color: AppColors.black)),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTextStyles.bodySmall),
          const SizedBox(height: 12),
          // Empurra o ícone lá para o canto inferior direito
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(icon, color: iconColor, size: 40),
          ),
        ],
      ),
    );
  }
}