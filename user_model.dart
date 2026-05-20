enum Liga { bronze, prata, ouro, diamante }

class UserModel {
  final String id;
  final String nome;
  final String avatarEmoji;
  final int xp;
  final Liga liga;
  final int streak;
  final int posicao;
  final int variacao; // positivo = subiu, negativo = desceu, 0 = igual
  final String recado;
  final String organizacao;

  const UserModel({
    required this.id,
    required this.nome,
    required this.avatarEmoji,
    required this.xp,
    required this.liga,
    required this.streak,
    required this.posicao,
    required this.variacao,
    required this.recado,
    required this.organizacao,
  });
}

// ── Usuário logado (você) ──────────────────────────────────────────
final usuarioAtual = UserModel(
  id: 'eu',
  nome: 'Você',
  avatarEmoji: '🦊',
  xp: 2105,
  liga: Liga.ouro,
  streak: 12,
  posicao: 4,
  variacao: 1,
  recado: 'Aprendendo Flutter com café ☕',
  organizacao: 'Católica SC',
);

// ── Ranking Geral ──────────────────────────────────────────────────
final rankingGeral = <UserModel>[
  UserModel(id: '1', nome: 'Ana Code', avatarEmoji: '👩‍💻', xp: 4820, liga: Liga.diamante, streak: 45, posicao: 1, variacao: 0, recado: 'Top 1 💎', organizacao: 'UFSC'),
  UserModel(id: '2', nome: 'Bruno Dev', avatarEmoji: '🧑‍🚀', xp: 3870, liga: Liga.diamante, streak: 30, posicao: 2, variacao: 1, recado: 'Rumo ao topo!', organizacao: 'UDESC'),
  UserModel(id: '3', nome: 'Carla.js', avatarEmoji: '🦸‍♀️', xp: 3400, liga: Liga.ouro, streak: 21, posicao: 3, variacao: -1, recado: 'JS lover 💛', organizacao: 'Católica SC'),
  UserModel(id: 'eu', nome: 'Você', avatarEmoji: '🦊', xp: 2105, liga: Liga.ouro, streak: 12, posicao: 4, variacao: 1, recado: 'Aprendendo Flutter', organizacao: 'Católica SC'),
  UserModel(id: '5', nome: 'Diego Bug', avatarEmoji: '🐛', xp: 1980, liga: Liga.prata, streak: 9, posicao: 5, variacao: -1, recado: 'Fix all bugs', organizacao: 'Unisul'),
  UserModel(id: '6', nome: 'Eva Loops', avatarEmoji: '🔁', xp: 1820, liga: Liga.prata, streak: 21, posicao: 6, variacao: 0, recado: 'Loop infinito de estudos', organizacao: 'UFSC'),
  UserModel(id: '7', nome: 'Felipe.py', avatarEmoji: '🐍', xp: 1650, liga: Liga.prata, streak: 7, posicao: 7, variacao: 2, recado: 'Python é vida', organizacao: 'UDESC'),
  UserModel(id: '8', nome: 'Gabi Array', avatarEmoji: '📦', xp: 1430, liga: Liga.bronze, streak: 3, posicao: 8, variacao: -2, recado: 'Arrays são legais', organizacao: 'Unisul'),
  UserModel(id: '9', nome: 'Hugo NULL', avatarEmoji: '🕳️', xp: 1200, liga: Liga.bronze, streak: 1, posicao: 9, variacao: 0, recado: 'Null pointer everywhere', organizacao: 'Católica SC'),
  UserModel(id: '10', nome: 'Iris Git', avatarEmoji: '🌿', xp: 980, liga: Liga.bronze, streak: 5, posicao: 10, variacao: 3, recado: 'Commit e vai!', organizacao: 'UFSC'),
];

// ── Ranking da Organização ─────────────────────────────────────────
final rankingOrg = rankingGeral
    .where((u) => u.organizacao == 'Católica SC')
    .toList()
  ..sort((a, b) => b.xp.compareTo(a.xp));
