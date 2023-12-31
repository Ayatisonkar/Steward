import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool? visible;

  const LoadingWidget({super.key, this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible! ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
