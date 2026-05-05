import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/task_cubit.dart';
import '../bloc/task_state.dart';

class NovaTarefaModal extends StatefulWidget {
  const NovaTarefaModal({super.key});

  @override
  State<NovaTarefaModal> createState() => _NovaTarefaModalState();
}

class _NovaTarefaModalState extends State<NovaTarefaModal> {
  // Controlador para o input de texto
  final TextEditingController _titleController = TextEditingController();

  bool _isEssencial = true;
  bool _hasTimer = false;
  bool _hasNotifications = true;

  DateTime? _selectedDate; // Guarda a data do calendário

  final List<String> _weekDays = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  final List<bool> _selectedDays = [
    false,
    false,
    true,
    false,
    true,
    false,
    false,
  ];

  // Função que abre o calendário nativo
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blueVariant,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener escuta o Cubit para mostrar SnackBars e fechar o modal
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Fecha o modal no sucesso
        } else if (state is TaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundOffWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
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
                        child: const Icon(
                          Icons.close,
                          color: AppColors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Mascote
                const Center(
                  child: Icon(
                    Icons.local_florist,
                    color: AppColors.starYellow,
                    size: 64,
                  ),
                ),
                const SizedBox(height: 24),

                // Input: Nome da tarefa
                Text(
                  'Nome da tarefa',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  style: const TextStyle(
                    color: AppColors.black,
                  ), // Texto digitado fica preto
                  decoration: InputDecoration(
                    hintText: 'Ex: Meditação Guiada',
                    hintStyle: AppTextStyles.bodySmall,
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
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
                      borderSide: const BorderSide(
                        color: AppColors.activityBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Checkbox: Essencial
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Marcar como essencial',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

                // Seção "Até"
                Text(
                  'Até',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownButton(
                        _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : 'Adicionar Data',
                        Icons.calendar_today_outlined,
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownButton(
                        'Quantidade',
                        Icons.keyboard_arrow_down,
                        onTap: () {
                          // Implementação futura do dropdown de quantidade
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Repetir em (Dias da Semana)
                Text(
                  'Repetir em',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    final isSelected = _selectedDays[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDays[index] = !_selectedDays[index];
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.black : AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.black
                                : Colors.black12,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _weekDays[index],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Switches
                _buildSwitchOption(
                  'Adicionar Temporizador',
                  _hasTimer,
                  (val) => setState(() => _hasTimer = val),
                ),
                _buildSwitchOption(
                  'Notificações',
                  _hasNotifications,
                  (val) => setState(() => _hasNotifications = val),
                ),
                const SizedBox(height: 32),

                // Botão Adicionar Tarefa com BlocBuilder
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<TaskCubit, TaskState>(
                    builder: (context, state) {
                      final isLoading = state is TaskLoading;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueVariant,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: isLoading
                            ? null // Desativa enquanto carrega
                            : () {
                                // Transforma a lista de booleanos (true/false) nas letras dos dias ("S", "T")
                                List<String> diasRepeticao = [];
                                for (int i = 0; i < _selectedDays.length; i++) {
                                  if (_selectedDays[i]) {
                                    diasRepeticao.add(_weekDays[i]);
                                  }
                                }

                                // Chama o Cubit para salvar!
                                context.read<TaskCubit>().saveNewTask(
                                  title: _titleController.text,
                                  isEssential: _isEssencial,
                                  deadline: _selectedDate,
                                  repeatDays: diasRepeticao,
                                  hasTimer: _hasTimer,
                                  hasNotifications: _hasNotifications,
                                );
                              },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Adicionar Tarefa',
                                style: AppTextStyles.bodyBold,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Componentes auxiliares
  Widget _buildDropdownButton(
    String title,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Icon(icon, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
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
