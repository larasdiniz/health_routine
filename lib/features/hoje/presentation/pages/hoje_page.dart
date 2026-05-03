import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_background.dart';
import '../bloc/hoje_cubit.dart';
import '../bloc/hoje_state.dart';
import '../widgets/activity_card.dart';

class HojePage extends StatefulWidget {
  const HojePage({super.key});

  @override
  State<HojePage> createState() => _HojePageState();
}

class _HojePageState extends State<HojePage> {
  @override
  void initState() {
    super.initState();
    // Assim que a tela abrir, mandamos o Cubit buscar os dados!
    context.read<HojeCubit>().loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Cabeçalho
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Olá, Mariana ! 🌟', style: AppTextStyles.heading1),
                    const CircleAvatar(
                      backgroundColor: AppColors.softYellow,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: AppColors.black,
                      ), // Avatar provisório
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Seção "Atividades de Hoje" e Botão "Baixa Energia"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Atividades de Hoje', style: AppTextStyles.heading2),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        // Exemplo chamando o toggle do modo baixa energia
                        context.read<HojeCubit>().toggleLowEnergyMode(true);
                      },
                      child: const Text(
                        'Baixa energia',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Lista de Atividades gerenciada pelo BlocBuilder!
                Expanded(
                  child: BlocBuilder<HojeCubit, HojeState>(
                    builder: (context, state) {
                      if (state is HojeLoading || state is HojeInitial) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HojeError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: AppTextStyles.bodySmall,
                          ),
                        );
                      } else if (state is HojeSuccess) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.black26),
                          ),
                          child: ListView.builder(
                            itemCount: state.activities.length,
                            itemBuilder: (context, index) {
                              return ActivityCard(
                                activity: state.activities[index],
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
