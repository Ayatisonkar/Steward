import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Steward_flutter/theme/theme.dart';

typedef TitleViewCallback = FutureOr<void> Function();

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String? subTxt;
  final AnimationController? animationController;
  final Animation? animation;
  final TitleViewCallback? onPress;

  const TitleView(
      {super.key,
      this.titleTxt = "",
      this.subTxt = "",
      this.animationController,
      this.animation,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: StewardAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: StewardAppTheme.lightText,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      onTap: () async {
                        if (onPress != null) {
                          await onPress!();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: StewardAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: StewardAppTheme.nearlyDarkBlue,
                              ),
                            ),
                            const SizedBox(
                              height: 38,
                              width: 26,
                              child: Icon(
                                Icons.arrow_forward,
                                color: StewardAppTheme.darkText,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
