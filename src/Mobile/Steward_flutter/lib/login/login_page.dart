import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Steward_flutter/blocs/auth/auth.dart';
import 'package:Steward_flutter/login/login.dart';
import 'package:Steward_flutter/repositories/repositories.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              userRepository: userRepository);
        },
        child: const LoginForm(),
      ),
    );
  }
}
