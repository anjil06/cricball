class Scorecard {
  final String id;
  final String matchId;
  final String team1Name;
  final String team2Name;
  final int team1Runs;
  final int team1Wickets;
  final int team1Overs;
  final int team2Runs;
  final int team2Wickets;
  final int team2Overs;
  final List<InningDetails> team1Innings;
  final List<InningDetails> team2Innings;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Scorecard({
    required this.id,
    required this.matchId,
    required this.team1Name,
    required this.team2Name,
    required this.team1Runs,
    required this.team1Wickets,
    required this.team1Overs,
    required this.team2Runs,
    required this.team2Wickets,
    required this.team2Overs,
    required this.team1Innings,
    required this.team2Innings,
    required this.createdAt,
    this.updatedAt,
  });

  factory Scorecard.fromMap(Map<String, dynamic> data, String id) {
    return Scorecard(
      id: id,
      matchId: data['matchId'] ?? '',
      team1Name: data['team1Name'] ?? '',
      team2Name: data['team2Name'] ?? '',
      team1Runs: data['team1Runs'] ?? 0,
      team1Wickets: data['team1Wickets'] ?? 0,
      team1Overs: data['team1Overs'] ?? 0,
      team2Runs: data['team2Runs'] ?? 0,
      team2Wickets: data['team2Wickets'] ?? 0,
      team2Overs: data['team2Overs'] ?? 0,
      team1Innings: (data['team1Innings'] as List?)?.map((e) => InningDetails.fromMap(e)).toList() ?? [],
      team2Innings: (data['team2Innings'] as List?)?.map((e) => InningDetails.fromMap(e)).toList() ?? [],
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toString()),
      updatedAt: data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'matchId': matchId,
      'team1Name': team1Name,
      'team2Name': team2Name,
      'team1Runs': team1Runs,
      'team1Wickets': team1Wickets,
      'team1Overs': team1Overs,
      'team2Runs': team2Runs,
      'team2Wickets': team2Wickets,
      'team2Overs': team2Overs,
      'team1Innings': team1Innings.map((e) => e.toMap()).toList(),
      'team2Innings': team2Innings.map((e) => e.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class InningDetails {
  final String playerName;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final String status; // not out, out, dnb (did not bat)

  InningDetails({
    required this.playerName,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    this.status = 'dnb',
  });

  factory InningDetails.fromMap(Map<String, dynamic> data) {
    return InningDetails(
      playerName: data['playerName'] ?? '',
      runs: data['runs'] ?? 0,
      balls: data['balls'] ?? 0,
      fours: data['fours'] ?? 0,
      sixes: data['sixes'] ?? 0,
      status: data['status'] ?? 'dnb',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'runs': runs,
      'balls': balls,
      'fours': fours,
      'sixes': sixes,
      'status': status,
    };
  }
}
