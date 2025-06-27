class UserProfile {
  final String name;
  final String email;

  UserProfile({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}

