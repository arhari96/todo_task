import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_task/data/repositories/auth_repository.dart';
import 'package:todo_task/firebase_options.dart';
import 'package:todo_task/logic/blocs/auth/auth_bloc.dart';
import 'package:todo_task/logic/blocs/profile/profile_bloc.dart';
import 'package:todo_task/presentation/screens/auth/login_screen.dart';
import 'package:todo_task/presentation/screens/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthRepository();

  runApp(
    RepositoryProvider<AuthRepository>(
      create: (context) => authRepository,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create:
                  (context) =>
                      AuthBloc(authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider<ProfileBloc>(
              create:
                  (context) => ProfileBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo Task',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: LoginScreen(),
            routes: {
              '/register': (context) => RegisterScreen(),
              '/login': (context) => LoginScreen(),
            },
          ),
        );
      },
    );
  }
}
