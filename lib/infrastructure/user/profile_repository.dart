import '../user/profile_response.dart';
import '../core/api_agent.dart';

class UserRepository {
  static Future<UserResponse> updateProfile({
    required String name,
    required String email,
  }) async {
    const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0MjI0IiwiZGV2aWNlVHlwZSI6InBob25lIiwiaWF0IjoxNzUxMDM5MDc1LCJleHAiOjE3NjE0MDcwNzV9.mG_OwQsf2DBE9NoAWp_U4CA0VXrGjabeNIAUPMoAMKA';

    bool status = false;
    String message = '';
    Map<String, dynamic> errors = {};

    try {
      final response = await ApiAgent.post(
        url: 'https://api.dev.litigant.courtclick.com/api/user/update-profile',
        params: {
          'name': name,
          'email': email,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
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
    return UserResponse(
      status: status,
      message: message,
      errors: errors,
    );
  }
}
