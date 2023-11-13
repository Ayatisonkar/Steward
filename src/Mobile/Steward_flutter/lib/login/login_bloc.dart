import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:Steward_flutter/blocs/auth/auth.dart';
import 'package:Steward_flutter/login/login.dart';
import 'package:Steward_flutter/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.userRepository, required this.authBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          tenancyName: event.tenancyName,
          usernameOrEmailAddress: event.username,
          password: event.password,
        );

        authBloc.add(LoggedIn(token: token, tenancyName: event.tenancyName));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(errorMessage: error.toString());
      }
    }
  }
}
