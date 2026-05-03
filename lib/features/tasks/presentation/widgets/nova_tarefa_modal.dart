import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class NovaTarefaModal extends StatefulWidget {
  const NovaTarefaModal({super.key});

  @override
  State<NovaTarefaModal> createState() => _NovaTarefaModalState();
}

class _NovaTarefaModalState extends State<NovaTarefaModal> {
  bool _isEssencial = true;
  bool _hasTimer = false;
  bool _hasNotifications = true;

  @override
  Widget build(BuildContext context) {
    // Usamos um container com a cor de fundo específica do Figma
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundOffWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      // O Wrap faz o modal se adaptar ao tamanho do conteúdo
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho com o título e o botão de fechar (X)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nova Tarefa', style: AppTextStyles.heading1),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: const Icon(Icons.close, color: AppColors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Mascote da flor amarela centralizado
              Center(
                child: Icon(
                  Icons.local_florist, // Ícone provisório da florzinha
                  color: AppColors.starYellow,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),

              // Input: Nome da tarefa
              Text('Nome da tarefa', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ex: Meditação Guiada',
                  hintStyle: AppTextStyles.bodySmall,
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.activityBlue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Checkbox: Marcar como essencial
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Marcar como essencial', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                  Checkbox(
                    value: _isEssencial,
                    activeColor: AppColors.blueVariant,
                    onChanged: (value) {
                      setState(() {
                        _isEssencial = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Switches: Temporizador e Notificações
              _buildSwitchOption('Adicionar Temporizador', _hasTimer, (val) => setState(() => _hasTimer = val)),
              _buildSwitchOption('Notificações', _hasNotifications, (val) => setState(() => _hasNotifications = val)),
              const SizedBox(height: 32),

              // Botão Adicionar Tarefa
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueVariant,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Lógica para salvar a tarefa entrará aqui
                    Navigator.pop(context);
                  },
                  child: Text('Adicionar Tarefa', style: AppTextStyles.bodyBold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Componente auxiliar para os interruptores ficarem padronizados
  Widget _buildSwitchOption(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
          Switch(
            value: value,
            activeColor: AppColors.white,
            activeTrackColor: AppColors.blueVariant,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: Colors.black26,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}