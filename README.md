# CodeQuest — Telas de Ranking e Perfil

Telas Flutter para o módulo de Ranking e Perfil do app CodeQuest.

## Estrutura

```
lib/
├── main.dart                        # Entry point
├── models/
│   ├── user_model.dart              # Model UserModel + dados mock
│   └── theme.dart                  # Cores, tema e helpers de liga
├── screens/
│   ├── ranking_screen.dart          # Ranking Geral + Minha Organização (tabs)
│   └── perfil_screen.dart           # Perfil (visualização) + Edição de Perfil
└── widgets/
    ├── podium_widget.dart           # Pódio visual dos top 3
    ├── ranking_card.dart            # Card de cada usuário na lista
    └── liga_badge.dart              # Badge de liga (Bronze/Prata/Ouro/Diamante)
```

## Telas

| Tela | Descrição |
|---|---|
| `RankingScreen` | Tabs "Geral" e "Minha Organização", pódio top 3, lista rolável com variação de posição |
| `PerfilScreen` | Visualização de perfil (próprio ou de outro usuário) com stats e recado |
| `EditarPerfilScreen` | Edição de nome, recado e seleção de avatar emoji |

## Requisitos atendidos

- ✅ Tabs para alternar entre Ranking Geral e da Organização
- ✅ `ListView` / `CustomScrollView` rolável com foto (avatar emoji), nome e XP
- ✅ Diferenciação visual por liga (Bronze 🥉, Prata 🥈, Ouro 🥇, Diamante 💎)
- ✅ Indicador de variação de posição (seta verde ↑ / vermelha ↓)
- ✅ Pódio animado para os 3 primeiros
- ✅ Destaque visual para "Você" na lista
- ✅ Tela de Edição de Perfil com campos Nome, Recado e seleção de avatar
- ✅ Navegação: toque no card abre o perfil do usuário

## Como rodar

```bash
flutter pub get
flutter run
```

## Integração com Firebase

Substituir os dados mock em `user_model.dart` por chamadas ao Firestore:

```dart
// Exemplo de fetch
final snapshot = await FirebaseFirestore.instance
    .collection('usuarios')
    .orderBy('xp', descending: true)
    .limit(50)
    .get();

final usuarios = snapshot.docs
    .map((doc) => UserModel.fromMap(doc.id, doc.data()))
    .toList();
```
