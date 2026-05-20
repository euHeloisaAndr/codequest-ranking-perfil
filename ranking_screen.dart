import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/theme.dart';
import '../widgets/ranking_card.dart';
import '../widgets/podium_widget.dart';
import '../widgets/liga_badge.dart';
import 'lib/perfil_screen.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: kSurfaceColor,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerfilScreen(usuario: usuarioAtual),
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: kAccentColor.withOpacity(0.2),
                  child: Text(
                    usuarioAtual.avatarEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            title: const Text('Ranking'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: LigaBadge(liga: usuarioAtual.liga, compact: false),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildLigaTabs(),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Geral'),
                Tab(text: 'Minha Organização'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _RankingList(usuarios: rankingGeral),
            _RankingList(usuarios: rankingOrg),
          ],
        ),
      ),
    );
  }

  Widget _buildLigaTabs() {
    return Container(
      color: kSurfaceColor,
      padding: const EdgeInsets.only(top: 60, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Liga selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Liga.values.map((liga) {
              final isActive = liga == usuarioAtual.liga;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? ligaColor(liga).withOpacity(0.2)
                            : Colors.transparent,
                        border: Border.all(
                          color: isActive
                              ? ligaColor(liga)
                              : kTextSecondary.withOpacity(0.3),
                          width: isActive ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        ligaEmoji(liga),
                        style: TextStyle(
                          fontSize: isActive ? 22 : 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ligaLabel(liga),
                      style: TextStyle(
                        fontSize: 10,
                        color: isActive ? ligaColor(liga) : kTextSecondary,
                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 6),
          Text(
            'Liga ${ligaLabel(usuarioAtual.liga)} · Top 15 sobem • Termina em 4 dias',
            style: const TextStyle(
              color: kTextSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Lista de ranking ─────────────────────────────────────────────────
class _RankingList extends StatelessWidget {
  final List<UserModel> usuarios;

  const _RankingList({required this.usuarios});

  @override
  Widget build(BuildContext context) {
    final top3 = usuarios.take(3).toList();
    final resto = usuarios.skip(3).toList();

    return CustomScrollView(
      slivers: [
        // Pódio
        SliverToBoxAdapter(
          child: PodiumWidget(top3: top3),
        ),

        // Minha posição (se não está no top 3)
        if (usuarioAtual.posicao > 3)
          SliverToBoxAdapter(
            child: _MinhaPosiçao(),
          ),

        // Demais usuários
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final user = resto[index];
              return RankingCard(
                usuario: user,
                isMe: user.id == usuarioAtual.id,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerfilScreen(
                      usuario: user,
                      somenteLeitura: user.id != usuarioAtual.id,
                    ),
                  ),
                ),
              );
            },
            childCount: resto.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}

class _MinhaPosiçao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final u = usuarioAtual;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: kAccentColor, width: 1.5),
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            kAccentColor.withOpacity(0.15),
            kCardColor,
          ],
        ),
      ),
      child: Row(
        children: [
          Text(
            '${u.posicao}°',
            style: const TextStyle(
              color: kAccentColor,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundColor: kAccentColor.withOpacity(0.2),
            child: Text(u.avatarEmoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Você  ',
                      style: const TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: kAccentColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'EU',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '🔥 ${u.streak}d  ·  ${_fmtXP(u.xp)} XP',
                  style: const TextStyle(
                    color: kTextSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _fmtXP(u.xp),
                style: const TextStyle(
                  color: kTextPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              _VariacaoWidget(v: u.variacao),
            ],
          ),
        ],
      ),
    );
  }
}

class _VariacaoWidget extends StatelessWidget {
  final int v;
  const _VariacaoWidget({required this.v});

  @override
  Widget build(BuildContext context) {
    if (v == 0) {
      return const Text('—',
          style: TextStyle(color: kTextSecondary, fontSize: 11));
    }
    final up = v > 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          up ? Icons.arrow_upward : Icons.arrow_downward,
          color: up ? Colors.greenAccent : Colors.redAccent,
          size: 12,
        ),
        Text(
          '${v.abs()}',
          style: TextStyle(
            color: up ? Colors.greenAccent : Colors.redAccent,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

String _fmtXP(int xp) =>
    xp >= 1000 ? '${(xp / 1000).toStringAsFixed(1)}k' : '$xp';
