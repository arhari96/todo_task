import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../logic/blocs/profile/profile_bloc.dart';
import '../../../logic/blocs/profile/profile_event.dart';
import '../../../logic/blocs/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProfileBloc(authRepository: context.read<AuthRepository>()),

      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              context.read<ProfileBloc>().add(LoadProfile());
            }
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle, size: 25.w),
                    SizedBox(height: 3.h),
                    Text(
                      "Email: ${state.email}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LogoutUser());
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            } else {
              return Center(child: Text("No profile data found."));
            }
          },
        ),
      ),
    );
  }
}
