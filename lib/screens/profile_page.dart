
import 'package:flutter/material.dart';
import '../styles.dart';
import '../study_store.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: StudyStore.instance, builder: (context, _) => SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CABEÇALHO
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meu perfil',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.6,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Gerencie sua conta e acompanhe suas conquistas.',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: IconButton(
                    tooltip: 'Configurações',
                    onPressed: () => _showInfo(
                      context,
                      'Configurações',
                      'As preferências da conta serão disponibilizadas em uma próxima versão.',
                    ),
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.text,
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            _buildProfileHeader(),

            const SizedBox(height: 24),

            _buildAchievements(),

            const SizedBox(height: 26),

            _buildMenu(context),
          ],
        ),
      ),
    ));
  }

  // CARD DO PERFIL
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blue,
            AppColors.purple,
          ],
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue.withOpacity(.24),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.22),
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppColors.blue,
                size: 52,
              ),
            ),
          ),

          const SizedBox(height: 13),

          Text(
            StudyStore.instance.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 4),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Aluno do MeuSaber',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.10),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ProfileStat(
                    icon: Icons.assignment_rounded,
                    number: '${StudyStore.instance.totalQuestions}', 
                    label: 'Questões',
                  ),
                ),
                Container(
                  width: 1,
                  height: 38,
                  color: Colors.white.withOpacity(.18),
                ),
                Expanded(
                  child: _ProfileStat(
                    icon: Icons.star_rounded,
                    number: '${(StudyStore.instance.accuracy * 100).round()}%',
                    label: 'Média',
                  ),
                ),
                Container(
                  width: 1,
                  height: 38,
                  color: Colors.white.withOpacity(.18),
                ),
                Expanded(
                  child: _ProfileStat(
                    icon: Icons.local_fire_department_rounded,
                    number: '${StudyStore.instance.completedActivities}',
                    label: 'Atividades',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _unlockedAchievements() {
    final store = StudyStore.instance;
    var count = 0;
    if (store.completedActivities >= 1) count++;
    if (store.completedActivities >= 5) count++;
    if (store.accuracy >= .8 && store.totalQuestions > 0) count++;
    return count;
  }

  // CONQUISTAS calculadas a partir do progresso real salvo.
  Widget _buildAchievements() {
    final store = StudyStore.instance;
    final firstActivity = store.completedActivities >= 1;
    final fiveActivities = store.completedActivities >= 5;
    final highAccuracy = store.totalQuestions > 0 && store.accuracy >= .8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Conquistas',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_unlockedAchievements()} desbloqueadas',
                style: TextStyle(
                  color: AppColors.purple,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _Achievement(
                icon: Icons.local_fire_department_rounded,
                title: 'Primeira',
                subtitle: firstActivity ? 'Desbloqueada' : 'Conclua 1 atividade',
                color: firstActivity ? AppColors.orange : AppColors.muted,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Achievement(
                icon: Icons.star_rounded,
                title: 'Dedicado',
                subtitle: fiveActivities ? '5 atividades' : 'Conclua 5 atividades',
                color: fiveActivities ? AppColors.blue : AppColors.muted,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Achievement(
                icon: Icons.emoji_events_rounded,
                title: 'Destaque',
                subtitle: highAccuracy ? '80% ou mais' : 'Atinga 80% de acertos',
                color: highAccuracy ? AppColors.purple : AppColors.muted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // MENU DE CONFIGURAÇÕES
  Widget _buildMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configurações',
          style: TextStyle(
            color: AppColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 14),

        _MenuItem(
          icon: Icons.person_outline_rounded,
          title: 'Dados pessoais',
          subtitle: 'Nome, e-mail e informações',
          onTap: () => _editName(context),
        ),

        _MenuItem(
          icon: Icons.notifications_none_rounded,
          title: 'Notificações',
          subtitle: 'Gerencie seus avisos',
          onTap: () => _showInfo(
            context,
            'Notificações',
            'As notificações ainda não estão ativadas neste protótipo.',
          ),
        ),

        _MenuItem(
          icon: Icons.lock_outline_rounded,
          title: 'Privacidade e segurança',
          subtitle: 'Senha e segurança da conta',
          onTap: () => _showInfo(
            context,
            'Privacidade e segurança',
            'A segurança da conta será configurada junto com o serviço de autenticação.',
          ),
        ),

        _MenuItem(
          icon: Icons.help_outline_rounded,
          title: 'Central de ajuda',
          subtitle: 'Precisa de ajuda?',
          onTap: () => _showInfo(
            context,
            'Central de ajuda',
            'Em caso de dúvidas sobre o projeto, procure a equipe responsável pelo Meu Saber.',
          ),
        ),

        const SizedBox(height: 6),

        // SAIR DA CONTA
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1F3),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.red.withOpacity(.10),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.red,
                size: 20,
              ),
            ),
            title: const Text(
              'Sair da conta',
              style: TextStyle(
                color: AppColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: const Text(
              'Encerrar sessão',
              style: TextStyle(
                color: AppColors.red,
                fontSize: 9,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.red,
              size: 21,
            ),
            onTap: () => _confirmLogout(context),
          ),
        ),
      ],
    );
  }

  Future<void> _editName(BuildContext context) async {
    final controller = TextEditingController(text: StudyStore.instance.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar nome'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          maxLength: 40,
          decoration: const InputDecoration(
            labelText: 'Como devemos chamar você?',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) Navigator.pop(dialogContext, value);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (newName == null || newName.trim().isEmpty) return;
    await StudyStore.instance.updateName(newName.trim());
  }

  // MOSTRAR INFORMAÇÕES
  void _showInfo(
      BuildContext context,
      String title,
      String message,
      ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  // CONFIRMAR SAÍDA
  void _confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.logout_rounded,
          color: AppColors.red,
        ),
        title: const Text('Sair da conta?'),
        content: const Text(
          'Você voltará para a tela inicial de acesso.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await StudyStore.instance.signOut();
              if (!context.mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                    (route) => false,
              );
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}

// ESTATÍSTICA DO PERFIL
class _ProfileStat extends StatelessWidget {
  final IconData icon;
  final String number;
  final String label;

  const _ProfileStat({
    required this.icon,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        const SizedBox(height: 5),
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 8,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// CARD DE CONQUISTA
class _Achievement extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _Achievement({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ITEM DO MENU
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 5,
        ),
        leading: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: AppColors.blueLight.withOpacity(.65),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: AppColors.blue,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 8,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.muted,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }
}
