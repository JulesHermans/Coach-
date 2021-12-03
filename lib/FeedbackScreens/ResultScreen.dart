import 'package:coachthecoach/Data/LoggingData.dart';
import 'package:coachthecoach/Data/sessionData.dart';
import 'package:coachthecoach/FeedbackScreens/OctantResultScreen.dart';
import 'package:coachthecoach/FlowScreens/SelectSessionScreen.dart';
import 'package:coachthecoach/constants.dart';
import 'package:flutter/material.dart';
import 'VideoResultScreen.dart';

class ResultScreens extends StatefulWidget {
  static String id = "ResultScreens";
  @override
  _ResultScreensState createState() => _ResultScreensState();
}

class _ResultScreensState extends State<ResultScreens> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text('Feedback'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                int nr = getSessionNr();
                showDialogueWith2Buttons(
                    context,
                    "Afsluiten videosessie $nr",
                    "Ben je zeker dat je de videosessie wilt afsluiten? De feedback van deze video zal niet meer zichtbaar zijn verder in de studie",
                    "Volgende sessie", () {
                  addFeedbackLog(
                      FBLog(DateTime.now(), null, LogAction.FeedbackEnd));
                  Navigator.pushNamed(context, SelectSessionScreen.id);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (int value) {
            if (value == 0) {
              addFeedbackLog(
                  FBLog(DateTime.now(), null, LogAction.FeedbackSwipeToOctant));
            } else
              addFeedbackLog(
                  FBLog(DateTime.now(), null, LogAction.FeedbackSwipeToVideo));
          },
          children: [
            OctantResultScreen(),
            //VideoResultScreen(null),
          ],
        ),
      ),
    );
  }
}
