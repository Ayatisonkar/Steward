import 'package:flutter/material.dart';
import 'package:Steward_flutter/utils/uidata.dart';

class MyAboutTile extends StatelessWidget {
  MyAboutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: logo,
      icon: const Icon(Icons.info_outline),
      aboutBoxChildren: const <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By @AbhithRajan",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: UIData.appVersion,
      applicationLegalese: "Apache License 2.0",
    );
  }

  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 48.0,
      child: Image.asset('graphics/logo.png'),
    ),
  );
}
