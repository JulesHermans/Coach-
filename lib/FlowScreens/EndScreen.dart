import 'package:coachthecoach/Data/sessionData.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EndScreen extends StatelessWidget {
  static String id = 'EndScreen';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text('Coach the Coach'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              child: Image.asset('images/KUL logo.png'),
            ),
            Text(
              "Einde studie",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: greyText,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Gelieve onderstaand ID nogmaals in te vullen in de survey alvorens de applicatie te sluiten!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: greyText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              getUserId().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: greyText,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
