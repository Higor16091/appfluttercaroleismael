# Meu Saber — aplicativo Flutter

Aplicativo educacional mobile com interface azul/roxa, atividades de múltipla escolha, câmera opcional durante os exercícios e acompanhamento local do progresso.

## Recursos implementados

- Tela de entrada com validação básica de e-mail e senha.
- Sessão e dados guardados no aparelho com `shared_preferences`.
- Tela inicial com resumo do desempenho e histórico recente.
- Atividades de Matemática, Português, Ciências e História, com 5 questões por atividade.
- Filtro de atividades por matéria, seleção de alternativas, navegação entre questões e cálculo automático do resultado.
- Resultados persistidos e refletidos no início, progresso e perfil.
- Câmera frontal opcional dentro da atividade, com tratamento de permissão/indisponibilidade e encerramento ao sair do app.
- Perfil com edição local do nome e conquistas calculadas a partir do progresso salvo.
- Navegação inferior entre Início, Atividades, Progresso e Perfil.

## Abrir e executar no Android Studio

1. Extraia este ZIP para uma pasta.
2. No Android Studio, abra a pasta que contém `pubspec.yaml` (não abra um dos ZIPs internos ou apenas a pasta `lib`).
3. Aguarde a sincronização e execute no terminal:

   ```bash
   flutter pub get
   flutter analyze
   flutter run
   ```

4. Para usar o emulador, abra **Tools → Device Manager**, crie um dispositivo virtual se necessário e inicie-o. No seletor de dispositivos da barra superior, escolha o Android virtual em vez de Chrome.
5. Na tela de entrada, informe um e-mail válido (por exemplo, `aluno@exemplo.com`) e uma senha com pelo menos 6 caracteres.
6. Abra **Atividades**, responda às questões e conclua para conferir o resultado em **Progresso**. A câmera é opcional e depende da permissão e de o dispositivo oferecer uma câmera.

## Limites importantes

O login atual é demonstrativo e local: valida o formato dos campos, mas não autentica em servidor, não cria contas reais e não sincroniza entre dispositivos. A senha não é salva. Login social, recuperação por e-mail e notificações push não estão conectados. Os dados de estudo ficam no armazenamento local do aparelho. Antes de publicar para usuários reais, integre um serviço de autenticação/backend e defina as regras de privacidade e segurança.

## Observação de validação

Este ambiente de edição não possui o SDK Flutter/Dart instalado, então não foi possível executar `flutter analyze`, `flutter test` ou compilar o APK aqui. É necessário executar os comandos acima no computador com Flutter instalado e resolver eventuais mensagens específicas do ambiente.
