class User {
  final String uid;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? profileImageUrl;
  final DateTime createdAt;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> data, String uid) {
    return User(
      uid: uid,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'],
      createdAt: DateTime.parse(data['createdAt'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
