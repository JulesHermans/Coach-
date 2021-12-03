import 'package:coachthecoach/FlowScreens/EndSessionScreen.dart';
import 'package:coachthecoach/FeedbackScreens/ResultScreen.dart';
import 'package:coachthecoach/InputScreens/QuadrantScreen.dart';
import 'package:coachthecoach/InputScreens/1ButtonRestScreen.dart';
import 'package:coachthecoach/InputScreens/ObservationsScreen.dart';
import 'FlowScreens/EndScreen.dart';
import 'package:coachthecoach/FlowScreens/SelectSessionScreen.dart';
import 'FlowScreens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        accentColor: lightBlue,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: accentDarkBlue,
        appBarTheme: AppBarTheme(
          color: accentDarkBlue,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        primaryTextTheme: TextTheme(
            bodyText2: TextStyle(
          fontFamily: 'pop',
          color: Colors.red,
        )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartScreen(),
      routes: {
        SelectSessionScreen.id: (context) => SelectSessionScreen(),
        QuadrantScreen.id: (context) => QuadrantScreen(),
        Button1RestScreen.id: (context) => Button1RestScreen(),
        ObservationScreen.id: (context) => ObservationScreen(),
        EndSessionScreen.id: (context) => EndSessionScreen(),
        ResultScreens.id: (context) => ResultScreens(),
        EndScreen.id: (context) => EndScreen(),
      },
    );
  }
}
