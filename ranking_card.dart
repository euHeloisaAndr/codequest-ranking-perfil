import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/theme.dart';
import 'liga_badge.dart';

class RankingCard extends StatelessWidget {
  final UserModel usuario;
  final bool isMe;
  final VoidCallback? onTap;

  const RankingCard({
    super.key,
    required this.usuario,
    this.isMe = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isMe
              ? kAccentColor.withOpacity(0.1)
              : kCardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isMe
                ? kAccentColor.withOpacity(0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Posição
            SizedBox(
              width: 32,
              child: Text(
                '${usuario.posicao}°',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isMe ? kAccentColor : kTextSecondary,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 4),

            // Variação
            SizedBox(
              width: 28,
              child: _VariacaoIcon(v: usuario.variacao),
            ),

            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: ligaColor(usuario.liga).withOpacity(0.15),
              child: Text(
                usuario.avatarEmoji,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 12),

            // Nome + streak
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          usuario.nome,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextPrimary,
                            fontWeight: isMe ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 6),
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
                    ],
                  ),
                  Row(
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 11)),
                      Text(
                        ' ${usuario.streak}d',
                        style: const TextStyle(
                          color: kTextSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // XP + liga
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${usuario.xp} XP',
                  style: TextStyle(
                    color: isMe ? kAccentColor : kTextPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                LigaBadge(liga: usuario.liga, compact: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VariacaoIcon extends StatelessWidget {
  final int v;
  const _VariacaoIcon({required this.v});

  @override
  Widget build(BuildContext context) {
    if (v == 0) {
      return const Icon(Icons.remove, color: kTextSecondary, size: 14);
    }
    final up = v > 0;
    return Icon(
      up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      color: up ? Colors.greenAccent : Colors.redAccent,
      size: 20,
    );
  }
}
