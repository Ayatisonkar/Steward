// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Steward_flutter/blocs/settings/bloc.dart';
import 'package:Steward_flutter/repositories/repositories.dart';
import 'package:Steward_flutter/screens/reports/categorywise_accounts_report_screen.dart';
import 'package:Steward_flutter/theme/theme.dart';
import 'package:Steward_flutter/widgets/common/common.dart';

import 'categorywise_recent_months_report_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key, required this.animationController});
  final AnimationController? animationController;

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with TickerProviderStateMixin {
  late Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;

  Animation<double>? bodyAnimation;
  List<Widget> listViews = <Widget>[];

  SettingsBloc? settingsBloc;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );

    bodyAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    settingsBloc = SettingsBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context));

    addAllListData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StewardAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    settingsBloc?.close();
    super.dispose();
  }

  void addAllListData() {
    const int count = 1;

    listViews.add(
      TitleView(
        titleTxt: 'Categorywise Accounts',
        subTxt: 'Expenses',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        onPress: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  CategorywiseAccountsReportScreen(
                animationController: widget.animationController,
              ),
            ),
          );
        },
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Monthly Categorywise',
        subTxt: 'Last 3 Months',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        onPress: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                CategoryWiseRecentMonthsReportScreen(
              animationController: widget.animationController,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController!.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: StewardAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: StewardAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Reports',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: StewardAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: StewardAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    // child: Icon(
                                    //   Icons.calendar_today,
                                    //   color: PiggyAppTheme.grey,
                                    //   size: 18,
                                    // ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        // // setState(() {
                                        // //   isDatePopupOpen = true;
                                        // // });
                                        // showDemoDialog(
                                        //     context: context,
                                        //     bloc: recentTransactionsBloc);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            // Text(
                                            //   '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                                            //   textAlign: TextAlign.left,
                                            //   style: TextStyle(
                                            //     fontFamily:
                                            //         PiggyAppTheme.fontName,
                                            //     fontWeight: FontWeight.normal,
                                            //     fontSize: 18,
                                            //     letterSpacing: -0.2,
                                            //     color:
                                            //         PiggyAppTheme.darkerText,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
