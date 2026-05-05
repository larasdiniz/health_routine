import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LowEnergyDialog extends StatelessWidget {
  const LowEnergyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 72, 24, 24), // Espaço pro círculo laranja
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ativar Modo Baixa Energia ?',
                  style: AppTextStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Vamos simplificar sua jornada. Metas detalhadas, barras de progresso e estatísticas serão ocultadas para focar apenas no essencial hoje .',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botão Cancelar
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.moodInsegura, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'Cancelar',
                        style: AppTextStyles.bodyBold.copyWith(color: AppColors.moodInsegura),
                      ),
                    ),
                    // Botão Ativar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.moodInsegura, // Usando o laranja/amarelo do Figma
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Ativar', style: AppTextStyles.bodyBold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // O círculo laranja vazando pra fora do topo
          Positioned(
            top: -40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.moodInsegura,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}