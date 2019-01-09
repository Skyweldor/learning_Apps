import 'package:flutter/material.dart';

const myPrimaryColor = Colors.deepPurple;
const myAccentColor = Colors.white;
const myBackgroundColor = Colors.purple;

ThemeData buildTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      textTheme: _buildAppTextTheme(base.textTheme),
      primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
      accentColor: myAccentColor,
      primaryColor: myPrimaryColor,
      buttonColor: myPrimaryColor,
      scaffoldBackgroundColor: myBackgroundColor,
      cardColor: myBackgroundColor,
      textSelectionColor: myPrimaryColor,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
            gapPadding: 10.0),
      ));
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(fontWeight: FontWeight.w900),
        title: base.title.copyWith(fontSize: 24.0, fontWeight: FontWeight.w500),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
          fontFamily: "Major Mono Display",
          displayColor: myAccentColor,
          bodyColor: myAccentColor);
}
