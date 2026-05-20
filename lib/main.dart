import 'package:flutter/material.dart';
import 'theme.dart';
import 'user_model.dart';
import 'liga_badge.dart';
import 'podium_widget.dart';
import 'perfil_screen.dart';

void main() {
  runApp(const CodeQuestApp());
}

class CodeQuestApp extends StatelessWidget {
  const CodeQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeQuest',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const MainNavigationScreen(),
    );
  }
}

// NAVEGAÇÃO PRINCIPAL (BARRA INFERIOR)
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Usuário fictício simulado para popular as informações do Perfil
  final UserModel _usuarioLogado = UserModel(
    id: '4',
    nome: 'Você',
    recado: '...',
    xp: 2105,
    liga: Liga.ouro,
    posicao: 4,
    streak: 12,
    avatarEmoji: '🧙',
    organizacao: 'Católica de Santa Catarina',
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      const RankingAbasView(),
      PerfilScreen(usuario: _usuarioLogado), // tela de perfil importada do arquivo correto
    ];

    return Scaffold(
      body: _telas[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: kAccentColor,
        unselectedItemColor: kTextSecondary,
        backgroundColor: kSurfaceColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), label: 'Ranking'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}

// ABAS DO RANKING (GERAL E ORGANIZAÇÃO)
class RankingAbasView extends StatelessWidget {
  const RankingAbasView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados fictícios para popular as tabelas de ranking
    final List<UserModel> rankingGeral = [
      UserModel(id: '1', nome: 'Ana Code', recado: 'Focada em Dart!', xp: 2500, liga: Liga.diamante, posicao: 1, streak: 30, avatarEmoji: '👩‍💻', organizacao: 'Católica SC'),
      UserModel(id: '2', nome
          : 'Bruno Dev', recado: 'Buscando o topo', xp: 2300, liga: Liga.ouro, posicao: 2, streak: 15, avatarEmoji: '🦊', organizacao: 'Católica SC'),
      UserModel(id: '3', nome: 'Carla.js', recado: 'Mobile Dev', xp: 2200, liga: Liga.ouro, posicao: 3, streak: 20, avatarEmoji: '🥷', organizacao: 'Católica SC'),
      UserModel(id: '4', nome: 'Você', recado: 'Estudando muito', xp: 2105, liga: Liga.ouro, posicao: 4, streak: 12, avatarEmoji: '🧙', organizacao: 'Católica SC'),
      UserModel(id: '5', nome: 'Diego Bug', recado: 'Caçador de bugs', xp: 1800, liga: Liga.prata, posicao: 5, streak: 5, avatarEmoji: '🤖', organizacao: 'Católica SC'),
    ];

    final List<UserModel> rankingOrg = [
      UserModel(id: '4', nome: 'Você', recado: 'Estudando muito', xp: 2105, liga: Liga.ouro, posicao: 1, streak: 12, avatarEmoji: '🧙', organizacao: 'Católica SC'),
      UserModel(id: '5', nome: 'Diego Bug', recado: 'Caçador de bugs', xp: 1800, liga: Liga.prata, posicao: 2, streak: 5, avatarEmoji: '🤖', organizacao: 'Católica SC'),
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          backgroundColor: kSurfaceColor,
          elevation: 0,
          title: const Text(
            'Leaderboard',
            style: TextStyle(color: kTextPrimary, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: kAccentColor,
            labelColor: kAccentColor,
            unselectedLabelColor: kTextSecondary,
            tabs: [
              Tab(text: 'GERAL'),
              Tab(text: 'MINHA ORG'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRankList(rankingGeral),
            _buildRankList(rankingOrg),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList(List<UserModel> lista) {
    final top3 = lista.take(3).toList();
    final restantes = lista.skip(3).toList();

    return ListView.builder(
      itemCount: restantes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return PodiumWidget(top3: top3); // Acopla o pódio visual no topo da lista rolável
        }

        final user = restantes[index - 1];
        final isMe = user.nome == 'Você';

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? kAccentColor.withOpacity(0.05) : kCardColor,
            borderRadius: BorderRadius.circular(16),
            border: isMe ? Border.all(color: kAccentColor, width: 1) : null,
          ),
          child: Row(
            children: [
              Text(
                '#${user.posicao}',
                style: const TextStyle(
                  color: kTextPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: kAccentColor.withOpacity(0.1),
                child: Text(user.avatarEmoji, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.nome,
                      style: TextStyle(
                        color: kTextPrimary,
                        fontWeight: isMe ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    LigaBadge(liga: user.liga, compact: true), // Badge customizado de cada liga
                  ],
                ),
              ),
              Text(
                '${user.xp} XP',
                style: const TextStyle(
                  color: kAccentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}