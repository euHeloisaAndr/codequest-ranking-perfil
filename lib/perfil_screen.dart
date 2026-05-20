import 'package:flutter/material.dart';
import 'user_model.dart'; // Importação corrigida para o mesmo nível de pasta
import 'theme.dart';      // Importação corrigida para o mesmo nível de pasta
import 'liga_badge.dart'; // Importação corrigida para o mesmo nível de pasta

// Tela de Perfil (Visualização)
class PerfilScreen extends StatelessWidget {
  final UserModel usuario;
  final bool somenteLeitura;

  const PerfilScreen({
    super.key,
    required this.usuario,
    this.somenteLeitura = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = !somenteLeitura;

    return Scaffold(
      backgroundColor: kBgColor,
      body: CustomScrollView(
        slivers: [
          // AppBar com fundo gradiente e avatar
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: kSurfaceColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context, isMe),
            ),
            actions: [
              if (isMe)
                TextButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditarPerfilScreen(usuario: usuario),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined,
                      color: kAccentColor, size: 16),
                  label: const Text(
                    'Editar',
                    style: TextStyle(color: kAccentColor, fontSize: 13),
                  ),
                ),
            ],
          ),

          // Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  _StatsRow(usuario: usuario),
                  const SizedBox(height: 24),

                  // Recado
                  if (usuario.recado.isNotEmpty) ...[
                    const _SectionLabel('Recado'),
                    const SizedBox(height: 8),
                    _RecadoCard(recado: usuario.recado),
                    const SizedBox(height: 24),
                  ],

                  // Organização
                  const _SectionLabel('Organização'),
                  const SizedBox(height: 8),
                  _InfoTile(
                    icon: Icons.school_outlined,
                    label: usuario.organizacao,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMe) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ligaColor(usuario.liga).withOpacity(0.3),
            kSurfaceColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ligaColor(usuario.liga),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ligaColor(usuario.liga).withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                    color: kCardColor,
                  ),
                  child: Center(
                    child: Text(
                      usuario.avatarEmoji,
                      style: const TextStyle(fontSize: 44),
                    ),
                  ),
                ),
                if (usuario.posicao == 1)
                  const Text('👑', style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              usuario.nome,
              style: const TextStyle(
                color: kTextPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            LigaBadge(liga: usuario.liga, compact: false),
          ],
        ),
      ),
    );
  }
}

// ── Stats Row
class _StatsRow extends StatelessWidget {
  final UserModel usuario;
  const _StatsRow({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatBox(
          emoji: '⭐',
          value: '${usuario.xp}',
          label: 'XP Total',
        ),
        const SizedBox(width: 12),
        _StatBox(
          emoji: '🏆',
          value: '${usuario.posicao}°',
          label: 'Posição',
        ),
        const SizedBox(width: 12),
        _StatBox(
          emoji: '🔥',
          value: '${usuario.streak}d',
          label: 'Sequência',
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  const _StatBox(
      {required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: kTextPrimary,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: kTextSecondary, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecadoCard extends StatelessWidget {
  final String recado;
  const _RecadoCard({required this.recado});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kAccentColor.withOpacity(0.2)),
      ),
      child: Text(
        '"$recado"',
        style: const TextStyle(
          color: kTextPrimary,
          fontStyle: FontStyle.italic,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: kAccentColor, size: 18),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(color: kTextPrimary, fontSize: 14)),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: kTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}

// ── Tela de Edição de Perfil
class EditarPerfilScreen extends StatefulWidget {
  final UserModel usuario;
  const EditarPerfilScreen({super.key, required this.usuario});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  late TextEditingController _nomeCtrl;
  late TextEditingController _recadoCtrl;
  late String _avatarSelecionado;

  final _avatares = [
    '🦊',
    '🦁',
    '🐯',
    '🐻',
    '🐼',
    '🐨',
    '🦄',
    '🐉',
    '🦅',
    '🐬',
    '🦊',
    '🤖',
    '👩‍💻',
    '🧑‍🚀',
    '🧙',
    '🦸',
    '🧑‍🎤',
    '🥷',
  ];

  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _nomeCtrl = TextEditingController(text: widget.usuario.nome);
    _recadoCtrl = TextEditingController(text: widget.usuario.recado);
    _avatarSelecionado = widget.usuario.avatarEmoji;
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _recadoCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    setState(() => _salvando = true);
    await Future.delayed(
        const Duration(milliseconds: 800)); // simula requisição
    if (mounted) {
      setState(() => _salvando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.greenAccent),
              SizedBox(width: 8),
              Text('Perfil atualizado!'),
            ],
          ),
          backgroundColor: kCardColor,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: kSurfaceColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: _salvando ? null : _salvar,
              child: _salvando
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: kAccentColor),
                    )
                  : const Text(
                      'Salvar',
                      style: TextStyle(
                        color: kAccentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview do avatar selecionado
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kAccentColor, width: 3),
                      color: kCardColor,
                    ),
                    child: Center(
                      child: Text(
                        _avatarSelecionado,
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kBgColor, width: 2),
                    ),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Seleção de avatar
            const _SectionLabel('Escolher avatar'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: _avatares.length,
                itemBuilder: (context, i) {
                  final av = _avatares[i];
                  final selected = av == _avatarSelecionado;
                  return GestureDetector(
                    onTap: () => setState(() => _avatarSelecionado = av),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: selected
                            ? kAccentColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selected ? kAccentColor : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(av, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Nome
            const _SectionLabel('Nome'),
            const SizedBox(height: 8),
            _InputField(
              controller: _nomeCtrl,
              hint: 'Seu nome de usuário',
              icon: Icons.person_outline,
              maxLength: 30,
            ),
            const SizedBox(height: 20),

            // Recado
            const _SectionLabel('Recado'),
            const SizedBox(height: 8),
            _InputField(
              controller: _recadoCtrl,
              hint: 'Escreva um recado...',
              icon: Icons.chat_bubble_outline,
              maxLength: 80,
              maxLines: 3,
            ),
            const SizedBox(height: 40),

            // Botão salvar
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _salvando ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: _salvando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Salvar Alterações',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLength;
  final int maxLines;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      style: const TextStyle(color: kTextPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kTextSecondary),
        prefixIcon: Icon(icon, color: kAccentColor, size: 18),
        counterStyle: const TextStyle(color: kTextSecondary, fontSize: 11),
        filled: true,
        fillColor: kCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kAccentColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }
}
