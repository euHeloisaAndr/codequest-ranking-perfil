import 'package:flutter/material.dart';
import 'user_model.dart'; // Importação corrigida na mesma pasta
import 'theme.dart';      // Importação corrigida na mesma pasta

class PodiumWidget extends StatelessWidget {
  final List<UserModel> top3;
  const PodiumWidget({super.key, required this.top3});

  @override
  Widget build(BuildContext context) {
    if (top3.isEmpty) return const SizedBox.shrink();

    final primeiro = top3[0];
    final segundo = top3.length > 1 ? top3[1] : null;
    final terceiroc = top3.length > 2 ? top3[2] : null;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: kAccentColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (segundo != null) _PodiumItem(user: segundo, place: 2, height: 80),
          _PodiumItem(user: primeiro, place: 1, height: 110),
          if (terceiroc != null)
            _PodiumItem(user: terceiroc, place: 3, height: 60),
        ],
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final UserModel user;
  final int place;
  final double height;

  const _PodiumItem({
    required this.user,
    required this.place,
    required this.height,
  });

  Color get _placeColor {
    switch (place) {
      case 1:
        return kOuro;
      case 2:
        return kPrata;
      default:
        return kBronze;
    }
  }

  String get _crownEmoji {
    switch (place) {
      case 1:
        return '👑';
      case 2:
        return '🥈';
      default:
        return '🥉';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_crownEmoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _placeColor, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: _placeColor.withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: place == 1 ? 30 : 22,
            backgroundColor: kSurfaceColor,
            child: Text(
              user.avatarEmoji,
              style: TextStyle(fontSize: place == 1 ? 28 : 20),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          child: Text(
            user.nome,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: kTextPrimary,
              fontWeight: FontWeight.w700,
              fontSize: place == 1 ? 13 : 11,
            ),
          ),
        ),
        Text(
          '${user.xp} XP',
          style: TextStyle(
            color: _placeColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          width: 70,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _placeColor.withOpacity(0.4),
                _placeColor.withOpacity(0.1),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(
              color: _placeColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              '$place°',
              style: TextStyle(
                color: _placeColor,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}