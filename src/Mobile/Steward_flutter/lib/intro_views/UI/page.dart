import 'package:flutter/material.dart';
import 'package:Steward_flutter/intro_views/Models/page_view_model.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final PageViewModel? pageViewModel;

  ///percent visible of page
  final double? percentVisible;

  /// [MainAxisAligment]
  final MainAxisAlignment columnMainAxisAlignment;

  //Constructor
  const Page({super.key, 
    this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: pageViewModel!.pageColor,
      child: Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible!,
        child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPage()
              : __buildLandscapePage();
        }), //OrientationBuilder
      ),
    );
  }

  /// when device is Portrait place title, image and body in a column
  Widget _buildPortraitPage() {
    return Column(
      key: const Key("Portrait Page"),
      mainAxisAlignment: columnMainAxisAlignment,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SafeArea(
          child: _TitlePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ), //Transform
        Expanded(
          flex: 4,
          child: _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ), //Transform
        Flexible(
          flex: 2,
          child: _BodyPageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ), //Transform
      ],
    );
  }

  /// if Device is Landscape reorder with row and column
  Widget __buildLandscapePage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ), //Transform

        Flexible(
          child: Column(
            mainAxisAlignment: columnMainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SafeArea(
                  child: _TitlePageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                ),
              ), //Transform
              Expanded(
                flex: 4,
                child: _BodyPageTransform(
                  percentVisible: percentVisible,
                  pageViewModel: pageViewModel,
                ),
              ), //Transform
            ],
          ), // Column
        ),
      ],
    );
  }
}

/// Body for the Page.
class _BodyPageTransform extends StatelessWidget {
  final double? percentVisible;

  final PageViewModel? pageViewModel;

  const _BodyPageTransform({
    required this.percentVisible,
    required this.pageViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible!), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 75.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel!.mergedBodyTextStyle,
          textAlign: TextAlign.center,
          child: pageViewModel!.body,
        ),
      ), //Padding
    );
  }
}

/// Main Image of the Page
class _ImagePageTransform extends StatelessWidget {
  final double? percentVisible;

  final PageViewModel? pageViewModel;

  const _ImagePageTransform({
    required this.percentVisible,
    required this.pageViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible!), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 40.0,
        ),
        child: Container(
          child: pageViewModel!.mainImage, //Loading main
        ), //Container
      ), //Padding
    );
  }
}

/// Title for the Page
class _TitlePageTransform extends StatelessWidget {
  final double? percentVisible;

  final PageViewModel? pageViewModel;

  const _TitlePageTransform({
    required this.percentVisible,
    required this.pageViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      //Used for vertical transformation
      transform:
          Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible!), 0.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel!.mergedTitleTextStyle,
          child: pageViewModel!.title,
        ),
      ), //Padding
    );
  }
}
