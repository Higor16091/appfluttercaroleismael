import 'package:flutter/material.dart';

import '../study_store.dart';
import '../styles.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onOpenActivities;

  const HomePage({super.key, this.onOpenActivities});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: StudyStore.instance,
      builder: (context, _) {
        final store = StudyStore.instance;
        final firstName = store.name.trim().isEmpty
            ? 'Estudante'
            : store.name.trim().split(' ').first;

        final accuracy = store.accuracy.clamp(0.0, 1.0).toDouble();

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blue.withOpacity(0.18),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 29,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, $firstName!',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.navy,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Seu próximo aprendizado começa aqui.',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.purpleLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: AppColors.purple,
                        size: 23,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // Resumo de estudos
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withOpacity(0.20),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.18),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.insights_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 7),
                            Text(
                              'SEU DESEMPENHO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Pequenos passos.\nGrandes conquistas.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        store.totalQuestions == 0
                            ? 'Comece a estudar e acompanhe sua evolução.'
                            : 'Continue assim! Cada questão conta.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.88),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Indicadores
                      Row(
                        children: [
                          Expanded(
                            child: _Metric(
                              value: '${store.completedActivities}',
                              label: 'Atividades',
                              icon: Icons.task_alt_rounded,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 43,
                            color: Colors.white.withOpacity(0.25),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: _Metric(
                                value: '${store.totalQuestions}',
                                label: 'Questões',
                                icon: Icons.quiz_rounded,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 43,
                            color: Colors.white.withOpacity(0.25),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: _Metric(
                                value: '${(accuracy * 100).round()}%',
                                label: 'Acertos',
                                icon: Icons.track_changes_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Aproveitamento',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${(accuracy * 100).round()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: store.totalQuestions == 0 ? 0 : accuracy,
                          minHeight: 8,
                          backgroundColor: Colors.white.withOpacity(0.24),
                          valueColor:
                          const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Matérias
                const _SectionHeading(
                  title: 'Explore as matérias',
                  subtitle: 'Escolha o que deseja aprender hoje.',
                ),

                const SizedBox(height: 16),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 1.28,
                  children: [
                    _SubjectTile(
                      title: 'Matemática',
                      subtitle: 'Raciocínio lógico',
                      icon: Icons.calculate_rounded,
                      color: AppColors.blue,
                      background: AppColors.blueLight,
                      onTap: onOpenActivities,
                    ),
                    _SubjectTile(
                      title: 'Português',
                      subtitle: 'Leitura e escrita',
                      icon: Icons.menu_book_rounded,
                      color: AppColors.purple,
                      background: AppColors.purpleLight,
                      onTap: onOpenActivities,
                    ),
                    _SubjectTile(
                      title: 'Ciências',
                      subtitle: 'Descobertas',
                      icon: Icons.science_rounded,
                      color: AppColors.green,
                      background: const Color(0xFFE7FAF2),
                      onTap: onOpenActivities,
                    ),
                    _SubjectTile(
                      title: 'História',
                      subtitle: 'Conheça o passado',
                      icon: Icons.account_balance_rounded,
                      color: AppColors.orange,
                      background: const Color(0xFFFFF3E2),
                      onTap: onOpenActivities,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Histórico
                Row(
                  children: [
                    const Expanded(
                      child: _SectionHeading(
                        title: 'Atividades recentes',
                        subtitle: 'Acompanhe o que você já fez.',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${store.history.length}',
                        style: const TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                if (store.history.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(21),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.auto_stories_rounded,
                          color: AppColors.purple,
                          size: 35,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Sua jornada começa aqui!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Conclua sua primeira atividade para ver seu histórico neste espaço.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...store.history.take(3).map(
                        (item) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7FAF2),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.green,
                              size: 23,
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: AppColors.navy,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.muted,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            color: AppColors.navy,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _Metric({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.85),
          size: 17,
        ),
        const SizedBox(height: 7),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _SubjectTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback? onTap;

  const _SubjectTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 23),
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: color,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}