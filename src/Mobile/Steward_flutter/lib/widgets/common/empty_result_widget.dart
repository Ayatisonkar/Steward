import 'package:flutter/material.dart';
import 'package:Steward_flutter/widgets/common/message_placeholder.dart';

class EmptyResultWidget extends StatelessWidget {
  final bool? visible;

  const EmptyResultWidget({super.key, this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible! ? 1.0 : 0.0,
      child: const MessagePlaceholder(),
    );
  }
}
