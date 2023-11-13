import 'package:flutter/material.dart';
import 'package:Steward_flutter/widgets/common/message_placeholder.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final bool? visible;

  const ErrorDisplayWidget({super.key, this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible! ? 1.0 : 0.0,
      child: const MessagePlaceholder(
        title: 'Something went wrong',
        message: 'An error occured during the operation, please try again.',
        icon: Icons.error_outline,
      ),
    );
  }
}
