# Revisão técnica — Meu Saber

## Alterações desta revisão
- Corrigidas declarações `const` indevidas no perfil que usavam valores dinâmicos.
- Estatísticas de perfil e conquistas agora acompanham os resultados persistidos, em vez de afirmar conquistas sem critério.
- A opção Dados pessoais permite editar o nome e salvar localmente.
- O progresso mostrado nos cards de atividades reflete a conclusão registrada para aquela atividade, não porcentagens demonstrativas fixas.
- O texto do desafio foi alinhado às 5 questões realmente apresentadas.
- O salvamento do resultado é aguardado antes de exibir a tela final, evitando que o usuário saia antes de o registro ser gravado.
- O nome exibido pelo aplicativo Android foi alterado para “Meu Saber”.
- Adicionada descrição de uso da câmera no iOS, além da permissão Android já existente.
- Atualizada a documentação de execução e dos limites de autenticação.

## Verificações necessárias no computador
O Flutter SDK não está instalado neste ambiente, portanto a compilação não pôde ser confirmada aqui. Na pasta do projeto, execute:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

O acesso à câmera deve ser testado em um celular/emulador compatível e após conceder permissão. O login ainda é local e demonstrativo, não uma autenticação pronta para produção.
