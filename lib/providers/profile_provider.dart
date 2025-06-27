import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../infrastructure/user/models.dart';
import '../infrastructure/user/profile_repository.dart';
import '../infrastructure/user/profile_response.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier()
      : super(UserProfile(
          name: 'abhi',
          email: 'abhijith7777@gmail.com',
        ));

  Future<UserResponse> updateProfile({
    required String name,
    required String email,
  }) async {
    final response = await UserRepository.updateProfile(name: name, email: email);
    if (response.status) {
      state = UserProfile(name: name, email: email);
    } else {
      throw Exception(response.message);
    }
    return response;
  }
}
