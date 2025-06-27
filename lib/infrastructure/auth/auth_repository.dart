import 'auth_response.dart';
import '../core/api_agent.dart';

class AuthRepository {
  /// Send OTP to phone number

  static Future<AuthResponse> sendOtp({required String phoneNumber}) async {
    bool status = false;
    String message = '';
    Map<String, dynamic> errors = {};

    try {
      final response = await ApiAgent.post(
        url: 'https://api.dev.litigant.courtclick.com/api/auth/send-otp',
        params: {'phone': phoneNumber},
      );

      status = response.statusCode == 200 ? response.data['status'] : false; // Check if the request was successful

      // Retrieve the message from the response data.
      message = response.data['message'];

      // Retrieve the errors from the response data, if any, or initialize an empty map if there are no errors.
      errors = response.data['errors'] ?? {};
    } catch (error) {
      // If an error occurs, set a generic error message and status.
      message = 'Server Error';
      status = false;
      rethrow;
    }
    return AuthResponse(
      status: status,
      message: message,
      errors: errors,
    );
  }
  /// Verify OTP

  static Future<AuthResponse> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await ApiAgent.post(
        url: 'https://api.dev.litigant.courtclick.com/api/auth/verify-otp',
        params: {'phone': phoneNumber, 'otp': otp},
      );

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Server Error',
        errors: {'exception': e.toString()},
      );
    }
  }
}
