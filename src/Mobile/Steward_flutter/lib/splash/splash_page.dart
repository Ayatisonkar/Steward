import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          height: 1200, // Adjust image size
          width: 844,  // Adjust image size
          image: AssetImage("assets/Steward.gif"),
        ),
      ),
    );
  }
}


