import 'package:flutter/material.dart';

import '../styles.dart';
import '../study_store.dart';
import 'app_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ===========================================================
  // ENTRAR
  // ===========================================================

  Future<void> entrar() async {
    final email = emailController.text.trim();
    final senha = passwordController.text;

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um e-mail válido para continuar.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter pelo menos 6 caracteres.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Sessão e perfil são salvos localmente neste dispositivo.
    await StudyStore.instance.signIn(email);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AppShell()),
    );
  }

  void mostrarRecuperacaoSenha() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.mark_email_read_outlined, color: AppColors.blue),
        title: const Text('Recuperar senha'),
        content: const Text(
          'Este protótipo ainda não envia e-mails de recuperação. '
          'Quando a autenticação for integrada, você poderá recuperar sua senha aqui.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }

  void mostrarAvisoLoginSocial(String provedor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login com $provedor ainda precisa ser integrado.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // =================================================
              // TOPO
              // =================================================

              _buildTop(),

              // =================================================
              // FORMULÁRIO
              // =================================================

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  30,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 22),

                    _buildLoginCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // TOPO
  // ===========================================================

  Widget _buildTop() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        28,
        35,
        28,
        42,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.blue,
            AppColors.purple,
          ],
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(42),
          bottomRight: Radius.circular(42),
        ),
      ),
      child: Column(
        children: [
          // ---------------------------------------------------
          // LOGO
          // ---------------------------------------------------

          Container(
            width: 92,
            height: 92,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school_rounded,
                color: AppColors.blue,
                size: 48,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ---------------------------------------------------
          // NOME
          // ---------------------------------------------------

          const Text(
            'Meu Saber',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Aprender hoje para ir mais longe amanhã',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // CARD DE LOGIN
  // ===========================================================

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------------
          // TÍTULO
          // ---------------------------------------------------

          const Text(
            'Bem-vindo de volta! 👋',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Entre na sua conta para continuar seus estudos.',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 11,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // ---------------------------------------------------
          // E-MAIL
          // ---------------------------------------------------

          const Text(
            'E-mail',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,

            decoration: InputDecoration(
              hintText: 'seuemail@email.com',

              prefixIcon: Container(
                margin: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: AppColors.blue,
                  size: 19,
                ),
              ),
            ),
          ),

          const SizedBox(height: 17),

          // ---------------------------------------------------
          // SENHA
          // ---------------------------------------------------

          const Text(
            'Senha',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 7),

          TextField(
            controller: passwordController,
            obscureText: obscurePassword,

            decoration: InputDecoration(
              hintText: 'Sua senha',

              prefixIcon: Container(
                margin: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lock_outline_rounded,
                  color: AppColors.purple,
                  size: 19,
                ),
              ),

              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },

                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,

                  color: AppColors.muted,
                  size: 20,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ---------------------------------------------------
          // ESQUECI SENHA
          // ---------------------------------------------------

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: mostrarRecuperacaoSenha,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ---------------------------------------------------
          // BOTÃO ENTRAR
          // ---------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.blue,
                    AppColors.purple,
                  ],
                ),

                borderRadius: BorderRadius.circular(16),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.blue.withOpacity(.22),
                    blurRadius: 15,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),

              child: ElevatedButton(
                onPressed: entrar,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(width: 8),

                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ---------------------------------------------------
          // DIVISOR
          // ---------------------------------------------------

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.border,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'ou continue com',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.border,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ---------------------------------------------------
          // LOGIN SOCIAL
          // ---------------------------------------------------

          Row(
            children: [
              Expanded(
                child: _socialButton(
                  icon: 'G',
                  label: 'Google',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _socialButton(
                  icon: '',
                  label: 'Apple',
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ---------------------------------------------------
          // CADASTRO
          // ---------------------------------------------------

          Center(
            child: Text.rich(
              TextSpan(
                text: 'Não tem uma conta? ',

                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),

                children: [
                  TextSpan(
                    text: 'Cadastre-se',

                    style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BOTÃO SOCIAL
  // ===========================================================

  Widget _socialButton({
    required String icon,
    required String label,
  }) {
    return OutlinedButton(
      onPressed: () => mostrarAvisoLoginSocial(label),

      style: OutlinedButton.styleFrom(
        minimumSize: const Size(
          0,
          50,
        ),

        backgroundColor: const Color(0xFFFAFBFD),

        side: const BorderSide(
          color: Color(0xFFE4E9F0),
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(
              color: icon == 'G'
                  ? AppColors.blue
                  : AppColors.text,

              fontSize: icon == 'G'
                  ? 18
                  : 20,

              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            label,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}