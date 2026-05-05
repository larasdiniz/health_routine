import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_background.dart';
import '../../domain/entities/activity_entity.dart';
import '../bloc/hoje_cubit.dart';
import '../bloc/hoje_state.dart';
import '../widgets/activity_card.dart';
import '../widgets/check_in_card.dart';
import '../widgets/low_energy_dialog.dart';
import '../widgets/suggestion_card.dart';

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
            // O BlocBuilder agora envolve a coluna inteira para atualizar a tela toda
            child: BlocBuilder<HojeCubit, HojeState>(
              builder: (context, state) {
                // Variáveis auxiliares para facilitar o layout
                bool isLowEnergy = false;
                List<ActivityEntity> atividades = [];

                if (state is HojeSuccess) {
                  isLowEnergy = state.isLowEnergyMode;
                  atividades = state.activities;
                }

                return Column(
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
                    const SizedBox(height: 24),

                    // O Card de Check-in (Só aparece se NÃO estiver em baixa energia)
                    if (!isLowEnergy) ...[
                      const CheckInCard(),
                      const SizedBox(height: 24),
                    ],

                    // Banner de Baixa Energia Ativado (Aparece se estiver ativo)
                    if (isLowEnergy) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.moodInsegura, // Laranja do Figma
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Modo Baixa Energia Ativado',
                              style: AppTextStyles.heading2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Suas metas complexas foram ocultadas para focar apenas no mínimo viável de saúde',
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Seção "Atividades de Hoje" e Botão
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
                          onPressed: () async {
                            if (isLowEnergy) {
                              // Se já tá ativo, só desativa direto
                              context.read<HojeCubit>().toggleLowEnergyMode(false);
                            } else {
                              // Se não tá ativo, mostra o Modal de confirmação
                              final confirmar = await showDialog<bool>(
                                context: context,
                                builder: (context) => const LowEnergyDialog(),
                              );
                              // Se o usuário clicou em "Ativar", a gente muda o state
                              if (confirmar == true) {
                                context.read<HojeCubit>().toggleLowEnergyMode(true);
                              }
                            }
                          },
                          // O texto do botão muda dinamicamente
                          child: Text(
                            isLowEnergy ? 'Desativar' : 'Baixa energia',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Lista de Atividades
                    Expanded(
                      child: _buildListContent(state, atividades),
                    ),


                    if (!isLowEnergy) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sugerido para você', style: AppTextStyles.bodyBold.copyWith(color: AppColors.black)),
                          Text('Ver todas', style: AppTextStyles.bodyBold.copyWith(color: AppColors.cloudBlue)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SuggestionCard(
                            title: 'Dica de nutrição',
                            subtitle: 'Alimentos que ajudam...',
                            icon: Icons.egg_alt_outlined, // Ícone provisório simulando o ovo
                            iconColor: AppColors.nutritionBrown,
                          ),
                          const SuggestionCard(
                            title: 'Técnica de meditação',
                            subtitle: '', // Sem subtítulo no Figma para este card
                            icon: Icons.cloud, // Ícone provisório simulando a nuvem
                            iconColor: AppColors.cloudBlue,
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Função separada só para deixar o código do build mais limpo
  Widget _buildListContent(HojeState state, List<ActivityEntity> atividades) {
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
          itemCount: atividades.length,
          itemBuilder: (context, index) {
            return ActivityCard(
              activity: atividades[index],
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }
}