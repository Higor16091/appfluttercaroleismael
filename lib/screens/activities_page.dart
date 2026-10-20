
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../styles.dart';
import '../study_store.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  String selectedSubject = 'Todas';

  static const Color blue = Color(0xFF287BFF);
  static const Color purple = Color(0xFF6855FF);
  static const Color pink = Color(0xFFFF4968);
  static const Color green = Color(0xFF20B77A);
  static const Color orange = Color(0xFFFFA62B);

  @override
  void initState() {
    super.initState();
    StudyStore.instance.addListener(_onStoreChanged);
  }

  void _onStoreChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    StudyStore.instance.removeListener(_onStoreChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allActivities = <_ActivityData>[
      _ActivityData(
        title: 'Área e perímetro',
        subject: 'Matemática',
        questions: 5,
        difficulty: 'Fácil',
        progress: StudyStore.instance.isActivityCompleted('Área e perímetro') ? 1.0 : 0.0,
        color: blue,
        background: const Color(0xFFEAF2FF),
        icon: Icons.calculate_rounded,
      ),
      _ActivityData(
        title: 'Interpretação de texto',
        subject: 'Português',
        questions: 5,
        difficulty: 'Médio',
        progress: StudyStore.instance.isActivityCompleted('Interpretação de texto') ? 1.0 : 0.0,
        color: pink,
        background: const Color(0xFFFFEDF1),
        icon: Icons.menu_book_rounded,
      ),
      _ActivityData(
        title: 'Sistema Solar',
        subject: 'Ciências',
        questions: 5,
        difficulty: 'Médio',
        progress: StudyStore.instance.isActivityCompleted('Sistema Solar') ? 1.0 : 0.0,
        color: green,
        background: const Color(0xFFE7FAF2),
        icon: Icons.science_rounded,
      ),
      _ActivityData(
        title: 'Revolução Francesa',
        subject: 'História',
        questions: 5,
        difficulty: 'Difícil',
        progress: StudyStore.instance.isActivityCompleted('Revolução Francesa') ? 1.0 : 0.0,
        color: orange,
        background: const Color(0xFFFFF3E2),
        icon: Icons.account_balance_rounded,
      ),
    ];

    final activities = selectedSubject == 'Todas' ? allActivities : allActivities.where((a) => a.subject == selectedSubject).toList();

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 110),
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
                        'Atividades',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -.7,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Escolha uma atividade e comece a aprender.',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: const Color(0xFFE0E8F5),
                    ),
                  ),
                  child: IconButton(
                    tooltip: 'Filtrar atividades',
                    onPressed: () => _showFilters(context),
                    icon: const Icon(
                      Icons.filter_list_rounded,
                      color: blue,
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // DESAFIO DO DIA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [blue, purple],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: blue.withOpacity(.20),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 20,
                    child: Icon(
                      Icons.emoji_events_rounded,
                      size: 100,
                      color: Colors.white.withOpacity(.17),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.20),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'DESAFIO DO DIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Quanto você\nconsegue acertar? 🧠',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 13),

                      const Text(
                        '5 questões • resultado salvo no progresso',
                        style: TextStyle(
                          color: Color(0xFFDCE6FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton.icon(
                        onPressed: () => _showChallenge(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: blue,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          size: 21,
                        ),
                        label: const Text(
                          'Começar desafio',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 34),

            // LISTA DE ATIVIDADES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    'Todas as atividades',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF5FF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    '${activities.length} atividades',
                    style: const TextStyle(
                      color: blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            ...activities.map(
                  (activity) => Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: _ActivityCard(
                  activity: activity,
                  onTap: () => _openActivity(context, activity),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChallenge(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivityExercisePage(
      title: 'Desafio do dia', subject: 'Matemática', totalQuestions: 5,
    )));
  }

  void _openActivity(BuildContext context, _ActivityData activity) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ActivityExercisePage(
      title: activity.title,
      subject: activity.subject,
      totalQuestions: activity.questions,
    )));
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Filtrar por matéria', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            for (final subject in ['Todas', 'Matemática', 'Português', 'Ciências', 'História'])
              RadioListTile<String>(
                value: subject, groupValue: selectedSubject, title: Text(subject),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => selectedSubject = value);
                  Navigator.pop(sheetContext);
                },
              ),
          ]),
        ),
      ),
    );
  }

}

class _ActivityData {
  final String title;
  final String subject;
  final int questions;
  final String difficulty;
  final double progress;
  final Color color;
  final Color background;
  final IconData icon;

  const _ActivityData({
    required this.title,
    required this.subject,
    required this.questions,
    required this.difficulty,
    required this.progress,
    required this.color,
    required this.background,
    required this.icon,
  });
}

class _ActivityCard extends StatelessWidget {
  final _ActivityData activity;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progress = activity.progress;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: const Color(0xFFE0E8F3),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.025),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  color: activity.background,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  activity.icon,
                  color: activity.color,
                  size: 36,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 9),

                    Text(
                      '${activity.subject} • '
                          '${activity.questions} questões',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 9,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: activity.background,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            activity.difficulty,
                            style: TextStyle(
                              color: activity.color,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Text(
                          '${(progress * 100).round()}% concluído',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: 54,
                height: 58,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activity.color,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    elevation: 5,
                    shadowColor: activity.color.withOpacity(.25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: activity.background,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      activity.color,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Icon(
                progress >= 1
                    ? Icons.check_circle_rounded
                    : Icons.play_circle_outline_rounded,
                color: activity.color,
                size: 23,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityExercisePage extends StatefulWidget {
  final String title;
  final String subject;
  final int totalQuestions;

  const ActivityExercisePage({
    super.key,
    required this.title,
    required this.subject,
    required this.totalQuestions,
  });

  @override
  State<ActivityExercisePage> createState() =>
      _ActivityExercisePageState();
}

class _ActivityExercisePageState
    extends State<ActivityExercisePage> with WidgetsBindingObserver {
  int currentQuestion = 0;
  int correctAnswers = 0;
  bool finished = false;
  bool resultSaved = false;

  final Map<int, int> answers = {};

  CameraController? _cameraController;
  bool _cameraLoading = false;
  String? _cameraError;

  late final List<_ExerciseQuestion> questions;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    questions = _createQuestions(widget.subject).take(widget.totalQuestions).toList();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      controller.dispose();
      _cameraController = null;
      if (mounted) setState(() {});
    }
  }

  Future<void> _toggleCamera() async {
    if (_cameraController != null) {
      await _stopCamera();
      return;
    }

    setState(() {
      _cameraLoading = true;
      _cameraError = null;
    });

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException('no-camera', 'Nenhuma câmera foi encontrada neste dispositivo.');
      }
      final preferredCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        preferredCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _cameraController = controller;
        _cameraLoading = false;
      });
    } on CameraException catch (error) {
      if (!mounted) return;
      setState(() {
        _cameraLoading = false;
        _cameraError = error.code == 'CameraAccessDenied'
            ? 'Permita o acesso à câmera nas configurações do celular.'
            : 'Não foi possível abrir a câmera. Verifique a permissão e tente novamente.';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _cameraLoading = false;
        _cameraError = 'Não foi possível acessar a câmera neste dispositivo.';
      });
    }
  }

  Future<void> _stopCamera() async {
    final controller = _cameraController;
    _cameraController = null;
    if (mounted) setState(() {});
    await controller?.dispose();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _cameraController = null;
    super.dispose();
  }

  Widget _buildCameraPanel() {
    final controller = _cameraController;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE1E8F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.videocam_rounded, color: Color(0xFF287BFF)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Câmera da atividade', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF18294A))),
                    SizedBox(height: 3),
                    Text('Ative a câmera quando precisar', style: TextStyle(fontSize: 12, color: Color(0xFF68758B))),
                  ],
                ),
              ),
              Icon(controller != null ? Icons.check_circle_rounded : Icons.camera_alt_outlined,
                  color: controller != null ? const Color(0xFF20B77A) : const Color(0xFF68758B)),
            ],
          ),
          if (controller != null && controller.value.isInitialized) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          ],
          if (_cameraLoading) ...[
            const SizedBox(height: 14),
            const LinearProgressIndicator(),
            const SizedBox(height: 8),
            const Text('Abrindo câmera...', style: TextStyle(color: Color(0xFF68758B))),
          ],
          if (_cameraError != null) ...[
            const SizedBox(height: 12),
            Text(_cameraError!, style: const TextStyle(color: Color(0xFFD93652), fontSize: 12)),
          ],
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _cameraLoading ? null : _toggleCamera,
              icon: Icon(controller == null ? Icons.camera_alt_rounded : Icons.videocam_off_rounded),
              label: Text(controller == null ? 'Ativar câmera' : 'Desativar câmera'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF287BFF),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_ExerciseQuestion> _createQuestions(String subject) {
    if (subject == 'Matemática') {
      return [
        _ExerciseQuestion(
          'Quanto é 8 × 7?',
          ['54', '56', '64', '48'],
          1,
        ),
        _ExerciseQuestion(
          'Qual é a área de um quadrado de lado 5 cm?',
          ['10 cm²', '20 cm²', '25 cm²', '30 cm²'],
          2,
        ),
        _ExerciseQuestion(
          'Quanto é 100 ÷ 4?',
          ['20', '25', '40', '50'],
          1,
        ),
        _ExerciseQuestion(
          'Um retângulo tem lados de 6 cm e 3 cm. Qual é o perímetro?',
          ['9 cm', '18 cm', '18 cm²', '12 cm'],
          1,
        ),
        _ExerciseQuestion(
          'Quanto é 15 + 27?',
          ['32', '40', '42', '45'],
          2,
        ),
      ];
    }

    if (subject == 'Português') {
      return [
        _ExerciseQuestion(
          'Qual é a principal função de um título?',
          [
            'Apresentar o assunto',
            'Finalizar o texto',
            'Substituir os parágrafos',
            'Indicar o autor sempre',
          ],
          0,
        ),
        _ExerciseQuestion(
          'Qual palavra é um substantivo?',
          ['Correr', 'Bonito', 'Escola', 'Rapidamente'],
          2,
        ),
        _ExerciseQuestion(
          'Qual sinal geralmente indica uma pergunta?',
          ['Ponto final', 'Vírgula', 'Dois-pontos', 'Interrogação'],
          3,
        ),
        _ExerciseQuestion(
          'Qual é um sinônimo de “feliz”?',
          ['Contente', 'Distante', 'Cansado', 'Confuso'],
          0,
        ),
        _ExerciseQuestion(
          'O que é interpretação de texto?',
          [
            'Copiar todas as frases',
            'Compreender os sentidos do texto',
            'Contar os parágrafos',
            'Ler apenas o título',
          ],
          1,
        ),
      ];
    }

    if (subject == 'Ciências') {
      return [
        _ExerciseQuestion(
          'Qual estrela está no centro do Sistema Solar?',
          ['Lua', 'Terra', 'Sol', 'Marte'],
          2,
        ),
        _ExerciseQuestion(
          'Qual planeta é conhecido como planeta vermelho?',
          ['Vênus', 'Marte', 'Saturno', 'Mercúrio'],
          1,
        ),
        _ExerciseQuestion(
          'Qual órgão bombeia o sangue?',
          ['Pulmão', 'Cérebro', 'Estômago', 'Coração'],
          3,
        ),
        _ExerciseQuestion(
          'Qual é uma fonte de energia renovável?',
          ['Carvão', 'Petróleo', 'Solar', 'Gasolina'],
          2,
        ),
        _ExerciseQuestion(
          'Qual gás as plantas absorvem na fotossíntese?',
          ['Oxigênio', 'Gás carbônico', 'Hélio', 'Hidrogênio'],
          1,
        ),
      ];
    }

    return [
      _ExerciseQuestion(
        'Em qual país começou a Revolução Francesa?',
        ['Inglaterra', 'França', 'Itália', 'Portugal'],
        1,
      ),
      _ExerciseQuestion(
        'Em que ano começou a Revolução Francesa?',
        ['1492', '1776', '1789', '1822'],
        2,
      ),
      _ExerciseQuestion(
        'Qual era um lema associado à Revolução Francesa?',
        [
          'Ordem e progresso',
          'Paz e amor',
          'Trabalho e riqueza',
          'Liberdade, igualdade e fraternidade',
        ],
        3,
      ),
      _ExerciseQuestion(
        'Qual era o nome da prisão tomada em 1789?',
        ['Bastilha', 'Versalhes', 'Louvre', 'Concórdia'],
        0,
      ),
      _ExerciseQuestion(
        'Qual grupo fazia parte do Terceiro Estado?',
        [
          'Clero',
          'Nobreza',
          'Burguesia e trabalhadores',
          'Família real',
        ],
        2,
      ),
    ];
  }

  Future<void> _nextQuestion() async {
    if (!answers.containsKey(currentQuestion)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma alternativa antes de continuar.'),
        ),
      );
      return;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() => currentQuestion++);
    } else {
      await _finishActivity();
    }
  }

  Future<void> _finishActivity() async {
    correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctIndex) {
        correctAnswers++;
      }
    }

    if (!resultSaved) {
      resultSaved = true;
      await StudyStore.instance.recordResult(
        title: widget.title,
        subject: widget.subject,
        total: questions.length,
        correct: correctAnswers,
      );
    }
    if (mounted) setState(() => finished = true);
  }

  @override
  Widget build(BuildContext context) {
    if (finished) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FC),
        appBar: AppBar(
          title: const Text('Resultado'),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  color: Color(0xFFFFB52E),
                  size: 82,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Atividade concluída!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$correctAnswers de ${questions.length} acertos',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF287BFF),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pontuação: '
                      '${(correctAnswers / questions.length * 100).round()}%',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Voltar às atividades'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final question = questions[currentQuestion];
    final selected = answers[currentQuestion];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.subject),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF18294A),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Questão ${currentQuestion + 1} de ${questions.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF68758B),
                          ),
                        ),
                        Text(
                          '${((currentQuestion + 1) / questions.length * 100).round()}%',
                          style: const TextStyle(
                            color: Color(0xFF287BFF),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: (currentQuestion + 1) / questions.length,
                        minHeight: 9,
                        backgroundColor: const Color(0xFFE1EAF8),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF287BFF),
                        ),
                      ),
                    ),
                    _buildCameraPanel(),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFE1E8F2),
                        ),
                      ),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontSize: 19,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF18294A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Escolha uma alternativa:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(
                      question.options.length,
                          (index) {
                        final isSelected = selected == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(17),
                            onTap: () {
                              setState(() {
                                answers[currentQuestion] = index;
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(17),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFEAF1FF)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(17),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF287BFF)
                                      : const Color(0xFFE1E8F2),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? const Color(0xFF287BFF)
                                          : const Color(0xFFF0F3F8),
                                    ),
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF68758B),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE1E8F2)),
                ),
              ),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: currentQuestion == 0
                        ? null
                        : () => setState(() => currentQuestion--),
                    child: const Text('Anterior'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF287BFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        currentQuestion == questions.length - 1
                            ? 'Finalizar atividade'
                            : 'Próxima questão',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const _ExerciseQuestion(
      this.question,
      this.options,
      this.correctIndex,
      );
}
