// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:Steward_flutter/theme/settings_styles.dart';

typedef SettingsItemCallback = FutureOr<void> Function();

class SettingsNavigationIndicator extends StatelessWidget {
  const SettingsNavigationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.forward,
      color: Styles.settingsMediumGray,
      size: 21,
    );
  }
}

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    required this.icon,
    this.foregroundColor = CupertinoColors.white,
    this.backgroundColor = CupertinoColors.black,
    super.key,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: foregroundColor,
          size: 20,
        ),
      ),
    );
  }
}

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    required this.label,
    this.icon,
    this.content,
    this.subtitle,
    this.onPress,
    super.key,
  });

  final String label;
  final Widget? icon;
  final Widget? content;
  final String? subtitle;
  final SettingsItemCallback? onPress;

  @override
  State<StatefulWidget> createState() => SettingsItemState();
}

class SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: pressed ? Styles.settingsItemPressed : Styles.transparentColor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          if (widget.onPress != null) {
            setState(() {
              pressed = true;
            });
            await widget.onPress!();
            Future.delayed(
              const Duration(milliseconds: 150),
              () {
                setState(() {
                  pressed = false;
                });
              },
            );
          }
        },
        child: SizedBox(
          height: widget.subtitle == null ? 44 : 57,
          child: Row(
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 2,
                  ),
                  child: SizedBox(
                    height: 29,
                    width: 29,
                    child: widget.icon,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: widget.subtitle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 8.5),
                            Text(widget.label),
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle!,
                              style: const TextStyle(
                                fontSize: 12,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 1.5),
                          child: Text(widget.label),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: widget.content ?? Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
