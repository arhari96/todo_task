import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await authRepository.signUp(event.email, event.password);

        emit(AuthSuccess(res.user!.uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<Login>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthSuccess(user.user!.uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<Logout>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial());
    });
  }
}
