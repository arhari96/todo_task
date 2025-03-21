import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/data/repositories/notes_repository.dart';
import 'package:todo_task/logic/blocs/notes/notes_bloc.dart';
import 'package:todo_task/presentation/screens/home/home_screen.dart';

import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import '../../../logic/blocs/notes/notes_event.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 20.w).animate().fade(duration: 500.ms),
            SizedBox(height: 5.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 4.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider(
                            create:
                                (context) => NotesBloc(
                                  notesRepository: NotesRepository(
                                    state.userId,
                                  ),
                                )..add(LoadNotes()),
                            child: HomeScreen(userId: state.userId),
                          ),
                    ),
                  );
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                return state is AuthLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty ||
                            passwordController.text.isNotEmpty) {
                          context.read<AuthBloc>().add(
                            Login(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                      child: Text("Login"),
                    ).animate().shake();
              },
            ),
            SizedBox(height: 2.h),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/register"),
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
