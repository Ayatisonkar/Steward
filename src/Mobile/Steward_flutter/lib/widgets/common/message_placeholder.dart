import 'package:flutter/material.dart';

class MessagePlaceholder extends StatelessWidget {
  const MessagePlaceholder({super.key, 
    this.title = 'Nothing Here',
    this.message = 'Add a new item to get started.',
    this.icon = Icons.sentiment_dissatisfied,
  });
  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 100.0,
//              color: iconColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.w700,
//                  color: textColor
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 15.0, fontWeight: FontWeight.normal,
//                  color: textColor
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
