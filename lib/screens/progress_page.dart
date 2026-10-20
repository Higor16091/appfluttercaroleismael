import 'package:flutter/material.dart';

import '../study_store.dart';
import '../styles.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: StudyStore.instance,
      builder: (context, _) {
        final store = StudyStore.instance;
        final percentage = (store.accuracy * 100).round();

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 112),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Meu progresso',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -.5,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Acompanhe sua evolução nos estudos.',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 22),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.blue, AppColors.purple],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'APROVEITAMENTO GERAL',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '$percentage%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              height: 1,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 9),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              store.totalQuestions == 0
                                  ? 'Faça sua primeira atividade'
                                  : 'de acertos',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: store.accuracy,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${store.correctAnswers} acertos em ${store.totalQuestions} questões respondidas',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.assignment_rounded,
                        number: '${store.completedActivities}',
                        label: 'Atividades',
                        color: AppColors.blue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.check_circle_rounded,
                        number: '${store.correctAnswers}',
                        label: 'Acertos',
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.quiz_rounded,
                        number: '${store.totalQuestions}',
                        label: 'Questões',
                        color: AppColors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 27),
                const Text(
                  'Histórico recente',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                if (store.history.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.insights_rounded,
                          color: AppColors.purple,
                          size: 38,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Seu histórico começa aqui',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Conclua uma atividade para ver seus resultados salvos.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...store.history.map(
                    (item) => Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.blueLight,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.task_alt_rounded,
                              color: AppColors.blue,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: AppColors.navy,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (store.history.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => _confirmClearHistory(context, store),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Limpar histórico'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmClearHistory(
    BuildContext context,
    StudyStore store,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Limpar histórico?'),
        content: const Text(
          'Esta ação apaga os resultados salvos neste dispositivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await store.resetProgress();
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.number,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 9),
          Text(
            number,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
