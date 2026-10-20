import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistência local do Meu Saber.
/// A autenticação é demonstrativa e não substitui um servidor seguro.
class StudyStore extends ChangeNotifier {
  StudyStore._();

  static final StudyStore instance = StudyStore._();

  static const _nameKey = 'meusaber.userName';
  static const _emailKey = 'meusaber.userEmail';
  static const _sessionKey = 'meusaber.session';
  static const _totalKey = 'meusaber.totalQuestions';
  static const _correctKey = 'meusaber.correctAnswers';
  static const _activitiesKey = 'meusaber.completedActivities';
  static const _historyKey = 'meusaber.history';
  static const _completedTitlesKey = 'meusaber.completedActivityTitles';
  static const _customNameKey = 'meusaber.customName';

  String _name = 'Estudante';
  String _email = '';
  bool _signedIn = false;
  bool _hasCustomName = false;

  int _totalQuestions = 0;
  int _correctAnswers = 0;

  // Títulos únicos das atividades concluídas.
  final Set<String> _completedActivityTitles = {};

  // Histórico separado: cada tentativa gera um registro.
  List<String> _history = [];

  String get name => _name;
  String get email => _email;
  bool get signedIn => _signedIn;

  int get totalQuestions => _totalQuestions;
  int get correctAnswers => _correctAnswers;

  int get completedActivities => _completedActivityTitles.length;

  double get accuracy {
    if (_totalQuestions <= 0) return 0;
    return _correctAnswers / _totalQuestions;
  }

  List<String> get history => List.unmodifiable(_history);

  bool isActivityCompleted(String title) {
    return _completedActivityTitles.contains(title.trim());
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    _name = prefs.getString(_nameKey) ?? 'Estudante';
    _email = prefs.getString(_emailKey) ?? '';
    _signedIn = prefs.getBool(_sessionKey) ?? false;
    _hasCustomName = prefs.getBool(_customNameKey) ?? false;

    _totalQuestions = prefs.getInt(_totalKey) ?? 0;
    _correctAnswers = prefs.getInt(_correctKey) ?? 0;
    _history = prefs.getStringList(_historyKey) ?? [];

    _completedActivityTitles
      ..clear()
      ..addAll(prefs.getStringList(_completedTitlesKey) ?? []);

    // Migração de instalações anteriores: recupera títulos do histórico.
    // O histórico antigo pode ter sido limitado aos 20 registros mais recentes.
    if (_completedActivityTitles.isEmpty && _history.isNotEmpty) {
      for (final entry in _history) {
        final separator = entry.indexOf(' • ');
        if (separator > 0) {
          _completedActivityTitles.add(entry.substring(0, separator).trim());
        }
      }

      await prefs.setStringList(
        _completedTitlesKey,
        _completedActivityTitles.toList(),
      );
    }

    // Corrige o contador antigo, que podia contar repetições.
    await prefs.setInt(_activitiesKey, _completedActivityTitles.length);

    await prefs.setStringList(_completedTitlesKey,
        _completedActivityTitles.toList());

    notifyListeners();
  }

  Future<void> updateName(String name) async {
    final cleaned = name.trim();
    if (cleaned.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    _name = cleaned;
    _hasCustomName = true;

    await prefs.setString(_nameKey, _name);
    await prefs.setBool(_customNameKey, true);

    notifyListeners();
  }

  Future<void> signIn(String email) async {
    final cleanedEmail = email.trim();
    if (cleanedEmail.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    _email = cleanedEmail;

    // Só gera um nome pelo e-mail quando o aluno ainda não personalizou
    // seu nome no perfil.
    if (!_hasCustomName) {
      final localName = _email
          .split('@')
          .first
          .replaceAll(RegExp(r'[._-]+'), ' ')
          .trim();

      _name = localName.isEmpty
          ? 'Estudante'
          : localName
          .split(' ')
          .where((word) => word.isNotEmpty)
          .map((word) =>
      '${word[0].toUpperCase()}${word.substring(1)}')
          .join(' ');
    }

    _signedIn = true;

    await prefs.setString(_nameKey, _name);
    await prefs.setString(_emailKey, _email);
    await prefs.setBool(_sessionKey, true);

    notifyListeners();
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();

    _signedIn = false;
    await prefs.setBool(_sessionKey, false);

    // Sair da conta não apaga o progresso nem o perfil.
    notifyListeners();
  }

  Future<void> recordResult({
    required String title,
    required String subject,
    required int total,
    required int correct,
  }) async {
    final cleanedTitle = title.trim();
    if (cleanedTitle.isEmpty) return;

    final safeTotal = total < 0 ? 0 : total;
    final safeCorrect = correct.clamp(0, safeTotal). toInt();

    final prefs = await SharedPreferences.getInstance();

    // As estatísticas gerais somam todas as tentativas.
    _totalQuestions += safeTotal;
    _correctAnswers += safeCorrect;

    // O contador de atividades aumenta apenas na primeira conclusão
    // de cada título.
    _completedActivityTitles.add(cleanedTitle);

    final pct = safeTotal == 0
        ? 0
        : (safeCorrect / safeTotal * 100).round();

    // Cada tentativa continua aparecendo no histórico.
    _history.insert(
      0,
      '$cleanedTitle • $subject • $safeCorrect/$safeTotal ($pct%)',
    );

    // Mantém o histórico limitado aos 20 registros mais recentes.
    if (_history.length > 20) {
      _history = _history.take(20).toList();
    }

    await prefs.setInt(_totalKey, _totalQuestions);
    await prefs.setInt(_correctKey, _correctAnswers);
    await prefs.setInt(_activitiesKey, _completedActivityTitles.length);
    await prefs.setStringList(
      _completedTitlesKey,
      _completedActivityTitles.toList(),
    );
    await prefs.setStringList(_historyKey, _history);

    notifyListeners();
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();

    _totalQuestions = 0;
    _correctAnswers = 0;
    _completedActivityTitles.clear();
    _history = [];

    await prefs.remove(_totalKey);
    await prefs.remove(_correctKey);
    await prefs.remove(_activitiesKey);
    await prefs.remove(_historyKey);
    await prefs.remove(_completedTitlesKey);

    // Mantém nome, e-mail e sessão.
    notifyListeners();
  }
}