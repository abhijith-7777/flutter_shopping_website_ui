class AuthResponse {
  final bool status;
  final String message;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? errors;

  AuthResponse({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      errors: json['errors'],
    );
  }
}

