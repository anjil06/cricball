class Match {
  final String id;
  final String team1Name;
  final String team2Name;
  final String mode; // 10 overs, 20 overs, 50 overs, custom
  final List<String> team1Playing11;
  final List<String> team2Playing11;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String status; // ongoing, completed, cancelled
  final String? winnerTeam;

  Match({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    required this.mode,
    required this.team1Playing11,
    required this.team2Playing11,
    required this.createdBy,
    required this.createdAt,
    this.completedAt,
    this.status = 'ongoing',
    this.winnerTeam,
  });

  factory Match.fromMap(Map<String, dynamic> data, String id) {
    return Match(
      id: id,
      team1Name: data['team1Name'] ?? '',
      team2Name: data['team2Name'] ?? '',
      mode: data['mode'] ?? '20 overs',
      team1Playing11: List<String>.from(data['team1Playing11'] ?? []),
      team2Playing11: List<String>.from(data['team2Playing11'] ?? []),
      createdBy: data['createdBy'] ?? '',
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toString()),
      completedAt: data['completedAt'] != null ? DateTime.parse(data['completedAt']) : null,
      status: data['status'] ?? 'ongoing',
      winnerTeam: data['winnerTeam'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'team1Name': team1Name,
      'team2Name': team2Name,
      'mode': mode,
      'team1Playing11': team1Playing11,
      'team2Playing11': team2Playing11,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status,
      'winnerTeam': winnerTeam,
    };
  }
}
