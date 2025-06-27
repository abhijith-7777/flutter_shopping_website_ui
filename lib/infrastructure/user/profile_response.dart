class UserResponse {
  final bool status;
  final String message;
  final Map<String, dynamic>? data;
   final Map<String, dynamic>? errors;

  UserResponse({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? 'Unknown error',
      data: json['data'],
      errors: json['errors'],
    );
  }
}
