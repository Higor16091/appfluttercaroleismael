import 'package:flutter/material.dart';

import '../styles.dart';

import 'home_page.dart';
import 'activities_page.dart';
import 'progress_page.dart';
import 'profile_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  List<Widget> get pages => [
        HomePage(onOpenActivities: () {
          setState(() => selectedIndex = 1);
        }),
        const ActivitiesPage(),
        const ProgressPage(),
        const ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      // =========================================================
      // PÁGINAS
      // =========================================================

      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      // =========================================================
      // NAVEGAÇÃO INFERIOR
      // =========================================================

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        child: Container(
          height: 76,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),

            border: Border.all(
              color: AppColors.border,
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: AppColors.navy.withOpacity(.10),
                blurRadius: 25,
                spreadRadius: 0,
                offset: const Offset(0, 9),
              ),

              BoxShadow(
                color: AppColors.blue.withOpacity(.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Row(
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: 'Início',
              ),

              _buildNavItem(
                index: 1,
                icon: Icons.menu_book_outlined,
                selectedIcon: Icons.menu_book_rounded,
                label: 'Atividades',
              ),

              _buildNavItem(
                index: 2,
                icon: Icons.insights_outlined,
                selectedIcon: Icons.insights_rounded,
                label: 'Progresso',
              ),

              _buildNavItem(
                index: 3,
                icon: Icons.person_outline_rounded,
                selectedIcon: Icons.person_rounded,
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // ITEM DA NAVEGAÇÃO
  // ===========================================================

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,

          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color: selected
                ? AppColors.blueLight.withOpacity(.75)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(18),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // -------------------------------------------------
              // ÍCONE
              // -------------------------------------------------

              AnimatedScale(
                scale: selected ? 1.05 : 1.0,

                duration: const Duration(
                  milliseconds: 180,
                ),

                child: Icon(
                  selected ? selectedIcon : icon,

                  color: selected
                      ? AppColors.blue
                      : AppColors.muted,

                  size: selected ? 23 : 21,
                ),
              ),

              const SizedBox(height: 4),

              // -------------------------------------------------
              // TEXTO
              // -------------------------------------------------

              AnimatedDefaultTextStyle(
                duration: const Duration(
                  milliseconds: 180,
                ),

                style: TextStyle(
                  color: selected
                      ? AppColors.blue
                      : AppColors.muted,

                  fontSize: selected ? 10 : 9,

                  fontWeight: selected
                      ? FontWeight.w900
                      : FontWeight.w600,
                ),

                child: Text(label),
              ),

              // -------------------------------------------------
              // INDICADOR
              // -------------------------------------------------

              const SizedBox(height: 3),

              AnimatedContainer(
                duration: const Duration(
                  milliseconds: 220,
                ),

                width: selected ? 5 : 0,
                height: selected ? 5 : 0,

                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}