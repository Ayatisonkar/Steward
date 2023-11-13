import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Steward_flutter/login/login.dart';
import 'package:Steward_flutter/widgets/primary_color_override.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tenancyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          tenancyName: _tenancyNameController.text.trim(),
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              logo,
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                "Welcome to Steward",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                "Sign in to continue",
                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black54),
              ),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                familyField(),
                usernameField(),
                passwordField(),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(12.0),
                        shape: const StadiumBorder()),
                    onPressed:
                        state is! LoginLoading ? _onLoginButtonPressed : null,
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: state is LoginLoading
                      ? const CircularProgressIndicator()
                      : null,
                ),
                const SizedBox(
                  height: 5.0,
                ),
//        Text(
//          "SIGN UP FOR AN ACCOUNT",
//          style: TextStyle(color: Colors.grey),
//        ),
              ],
            ),
          )
        ],
      ));
    }));
  }

  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 98.0,
      child: Image.asset('graphics/logo.png'),
    ),
  );

  Widget familyField() {
    return PrimaryColorOverride(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: TextField(
          maxLines: 1,
          controller: _tenancyNameController,
          decoration: const InputDecoration(
            hintText: "Enter your family name",
            labelText: "Family",
            // errorText: snapshot.error,
          ),
          // onChanged: _bloc.changeTenancyName,
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget usernameField() {
    return PrimaryColorOverride(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: TextField(
          maxLines: 1,
          controller: _usernameController,
          decoration: const InputDecoration(
            hintText: "Enter your username",
            labelText: "Username",
            // errorText: snapshot.error,
          ),
          // onChanged: _bloc.changeUsernameOrEmailAddress,
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget passwordField() {
    return PrimaryColorOverride(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: TextField(
          maxLines: 1,
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "Enter your password",
            labelText: "Password",
            // errorText: snapshot.error,
          ),
          // onChanged: _bloc.changePassword,
        ),
      ),
    );
  }
}
