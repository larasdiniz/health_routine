import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:health_routine/features/hoje/presentation/pages/hoje_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Começamos na aba 0 (Home/Hoje)
  int _currentIndex = 0;

  // Essa lista guarda as páginas que vão aparecer no "miolo" do app
  final List<Widget> _pages = [
    const HojePage(),
    const Center(child: Text('Templates (Em breve)')), // Placeholder
    const Center(child: Text('Relatórios (Em breve)')), // Placeholder
    const Center(child: Text('Perfil (Em breve)')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Evita que o degradê fique cortado ou que o teclado empurre o layout de forma bizarra
      resizeToAvoidBottomInset: false, 
      
      // O corpo muda dependendo do botão que foi clicado
      body: _pages[_currentIndex],
      
      // O Botão Flutuante (O "+" preto e amarelo)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aqui depois vamos abrir aquele Modal lindão de "Nova Tarefa"
        },
        backgroundColor: AppColors.black,
        shape: const CircleBorder(), // Força ele a ser redondinho
        child: const Icon(Icons.add, color: AppColors.starYellow, size: 32),
      ),
      // Posiciona o botão no centro e avisa a barra para abrir espaço pra ele
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      // A nossa Barra Inferior customizada
      bottomNavigationBar: BottomAppBar(
        color: AppColors.cloudBlue, // Ajuste para o azul exato da sua barra
        shape: const CircularNotchedRectangle(), // É isso aqui que faz a curvinha (o notch)
        notchMargin: 8.0, // Espaço em branco entre o botão e a barra
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home_filled, label: 'Home', index: 0),
              _buildNavItem(icon: Icons.list_alt_rounded, label: 'Templates', index: 1),
              
              const SizedBox(width: 48), // Esse espaço é o "buraco" do botão flutuante!
              
              _buildNavItem(icon: Icons.bar_chart_rounded, label: 'Relatórios', index: 2),
              _buildNavItem(icon: Icons.person_outline, label: 'Perfil', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  // Componente que desenha cada ícone e texto da barra
  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            // Se estiver selecionado, fica amarelinho (ou da cor que preferir), senão fica preto
            color: isSelected ? AppColors.softYellow : AppColors.black, 
            size: 26,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? AppColors.softYellow : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}