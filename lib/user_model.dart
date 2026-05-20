import 'theme.dart';

class UserModel {
  final String id;
  final String nome;
  final String recado;
  final int xp;
  final Liga liga;
  final int posicao;
  final int streak;
  final String avatarEmoji;
  final String organizacao;
  final String avatarUrl;

  UserModel({
    required this.id,
    required this.nome,
    required this.recado,
    required this.xp,
    required this.liga,
    required this.posicao,
    required this.streak,
    required this.avatarEmoji,
    required this.organizacao,
    this.avatarUrl = '',
  });
}