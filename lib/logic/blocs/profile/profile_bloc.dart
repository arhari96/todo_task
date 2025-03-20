import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;

  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = authRepository.currentUser;
        if (user != null) {
          emit(ProfileLoaded(email: user.email ?? 'No Email'));
        } else {
          emit(ProfileError("User not found"));
        }
      } catch (e) {
        emit(ProfileError("Failed to load profile: $e"));
      }
    });

    on<LogoutUser>((event, emit) async {
      try {
        await authRepository.logout();
        emit(ProfileInitial());
      } catch (e) {
        emit(ProfileError("Failed to log out"));
      }
    });
  }
}
